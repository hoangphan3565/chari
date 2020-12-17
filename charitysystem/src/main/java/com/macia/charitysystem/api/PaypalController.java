package com.macia.charitysystem.api;

import com.macia.charitysystem.model.DonateActivity;
import com.macia.charitysystem.model.DonateDetails;
import com.macia.charitysystem.model.Donator;
import com.macia.charitysystem.model.Order;
import com.macia.charitysystem.repository.DonateDetailsRepository;
import com.macia.charitysystem.service.DonateActivityService;
import com.macia.charitysystem.service.DonatorService;
import com.macia.charitysystem.service.PaypalService;
import com.macia.charitysystem.service.ProjectService;
import com.macia.charitysystem.utility.MoneyUtility;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import java.time.LocalDateTime;


@RestController
@CrossOrigin("*")
@RequestMapping("/api/paypal")
public class PaypalController {

    @Value("${server.address}")
    private String server_address;

    @Autowired
    PaypalService service;

    @Autowired
    DonateActivityService donateActivityService;

    @Autowired
    DonatorService donatorService;

    @Autowired
    ProjectService projectService;

    @Autowired
    DonateDetailsRepository donateDetailsRepository;


    @GetMapping()
    public String home() {
        return "paypal home";
    }

    @Transactional
    @PostMapping("/donatorid/{did}/projectid/{pid}/donate")
    public String payment(@PathVariable(value = "did") Integer donator_id,
                          @PathVariable(value = "pid") Integer project_id,
                          @RequestBody Order order) {
        double price = order.getPrice();
        order.setPrice(MoneyUtility.VNDToUSD(order.getPrice()));
        order.setCurrency("USD");
        order.setMethod("PAYPAL");
        order.setIntent("sale"); //sale-thanh toán ngay | authorize-bên đặt mất tiền nhưng bên bán chưa có tiền | order-tạo đơn đặt hàng, cả 2 bên đều chưa có tiền
        try {
            Payment payment = service.createPayment(
                    order.getPrice(),
                    order.getCurrency(),
                    order.getMethod(),
                    order.getIntent(),
                    order.getDescription(),
                    "http://" + server_address + ":8080/api/paypal/cancel",
                    "http://" + server_address + ":8080/api/paypal/success/donatorid/" + donator_id + "/projectid/" + project_id + "/money/" + price);
            for (Links link : payment.getLinks()) {
                if (link.getRel().equals("approval_url")) {
                    return link.getHref();
                }
            }
        } catch (PayPalRESTException e) {
            e.printStackTrace();
        }
        return "error";
    }

    @GetMapping("/cancel")
    public String cancelPay() {
        return "cancel";
    }

    @Transactional
    @GetMapping("/success/donatorid/{did}/projectid/{pid}/money/{money}")
    public String successPay(
            @PathVariable(value = "did") Integer donator_id,
            @PathVariable(value = "pid") Integer project_id,
            @PathVariable(value = "money") Double money,
            @RequestParam("paymentId") String paymentId,
            @RequestParam("PayerID") String payerId) {
        try {
            Payment payment = service.executePayment(paymentId, payerId);
            System.out.println(payment.toJSON());
            if (payment.getState().equals("approved")) {
                DonateActivity donateActivity = donateActivityService.findDonateActivityByDonatorIdAndProjectID(donator_id, project_id);
                if (donateActivity == null) {
                    donateDetailsRepository.save(DonateDetails.builder()
                            .donateActivity(donateActivityService.save(DonateActivity.builder()
                                    .donator(donatorService.findById(donator_id))
                                    .project(projectService.findProjectById(project_id))
                                    .build()))
                            .donateDate(LocalDateTime.now())
                            .money(money)
                            .build());
                } else {
                    donateDetailsRepository.save(DonateDetails.builder()
                            .donateActivity(donateActivity)
                            .donateDate(LocalDateTime.now())
                            .money(money)
                            .build());
                }
                return "Ủng hộ thành công!";
            }
        } catch (PayPalRESTException e) {
            System.out.println(e.getMessage());
        }
        return "Chuyển tiền không thành công";
    }
}
