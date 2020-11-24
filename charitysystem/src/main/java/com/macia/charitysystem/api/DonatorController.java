package com.macia.charitysystem.api;

import com.macia.charitysystem.model.Project;
import com.macia.charitysystem.service.DonatorService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/donators")
public class DonatorController {
    @Autowired
    DonatorService donatorService;

    @GetMapping("phone/{phone}")
    public ResponseEntity<?> getDonatorByPhone(@PathVariable(value = "phone") String phone) {
        return ResponseEntity.ok().body(donatorService.findByPhone(phone));
    }

    @PostMapping("/addfavorite/project/{prjid}/donator/{dntid}")
    public ResponseEntity<?> addProjectToFavoriteList(@PathVariable(value = "prjid") Integer prtid,
                                                      @PathVariable(value = "dntid") Integer dntid) {
        donatorService.addProjectToFavoriteList(prtid,dntid);
        return ResponseEntity.ok(donatorService.findById(dntid));
    }
    @PostMapping("/removefavorite/project/{prjid}/donator/{dntid}")
    public ResponseEntity<?> removeProjectFromFavoriteList(@PathVariable(value = "prjid") Integer prtid,
                                                      @PathVariable(value = "dntid") Integer dntid) {
        donatorService.removeProjectFromFavoriteList(prtid,dntid);
        return ResponseEntity.ok(donatorService.findById(dntid));
    }
}
