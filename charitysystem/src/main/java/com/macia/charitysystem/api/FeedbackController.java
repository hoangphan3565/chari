package com.macia.charitysystem.api;

import com.macia.charitysystem.model.Donator;
import com.macia.charitysystem.model.Feedback;
import com.macia.charitysystem.repository.FeedbackRepository;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/feedbacks")
public class FeedbackController {
    @Autowired
    FeedbackRepository feedbackRepo;
    @PostMapping()
    public ResponseEntity<?> saveFeedback(@RequestBody Feedback feedback) {
        feedbackRepo.save(feedback);
        JSONObject jo = new JSONObject();
        jo.put("errorCode", 0);
        jo.put("messenger", "Đóng góp ý kiến thành công!");
        jo.put("data", feedback);
        return ResponseEntity.ok(jo.toMap());
    }
}
