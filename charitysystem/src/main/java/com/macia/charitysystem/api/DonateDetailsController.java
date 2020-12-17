package com.macia.charitysystem.api;

import com.macia.charitysystem.service.DonateDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/donatedetails")
public class DonateDetailsController {
    @Autowired
    DonateDetailsService donateDetailsService;

    @GetMapping("donatorid/{dntid}")
    public ResponseEntity<?> getDonateDetailsOfDonatorByDonatorId(@PathVariable(value = "dntid") Integer id) {
        return ResponseEntity.ok().body(donateDetailsService.findDonateDetailsByDonatorId(id));
    }
}
