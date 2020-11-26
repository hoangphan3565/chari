package com.macia.charitysystem.api;

import com.macia.charitysystem.model.AppUser;
import com.macia.charitysystem.model.Order;
import com.macia.charitysystem.service.PaypalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;

//@Controller
@RestController
@CrossOrigin("*")
@RequestMapping("/api/paypal")
public class PaypalController {

	@Autowired
	PaypalService service;

	@GetMapping()
	public String home() {
		return "paypal home";
	}

	@PostMapping("/pay")
	public String payment(Order order) {
		order.setPrice(100);
		order.setCurrency("USD");
		order.setMethod("PAYPAL");
		order.setIntent("authorize");
		order.setDescription("Tesst from Hoangphan");
		try {
			Payment payment = service.createPayment(
					order.getPrice(),
					order.getCurrency(),
					order.getMethod(),
					order.getIntent(),
					order.getDescription(),
					"http://localhost:8080/api/paypal/cancel",
					"http://localhost:8080/api/paypal/success");
			for(Links link:payment.getLinks()) {
				if(link.getRel().equals("approval_url")) {
					return "redirect:"+link.getHref();
				}
			}
			
		} catch (PayPalRESTException e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	 @GetMapping("/cancel")
	 public String cancelPay() {
	        return "cancel";
	    }

	 @GetMapping("/success")
	 public String successPay(@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId) {
	     try {
	         Payment payment = service.executePayment(paymentId, payerId);
	         System.out.println(payment.toJSON());
	         if (payment.getState().equals("approved")) {
	             return "success";
	         }
	     } catch (PayPalRESTException e) {
	      System.out.println(e.getMessage());
	     }
	     return "redirect:/";
	 }

}
