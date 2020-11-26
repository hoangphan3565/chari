package com.macia.charitysystem.api;

import com.macia.charitysystem.DTO.ImageDTO;
import com.macia.charitysystem.model.Project;
import com.macia.charitysystem.model.ProjectImages;
import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.model.SupportedPeople;
import com.macia.charitysystem.service.ProjectImagesService;
import com.macia.charitysystem.service.ProjectService;
import com.macia.charitysystem.service.ProjectTypeService;
import com.macia.charitysystem.service.SupportedPeopleService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/projectimages")
public class ProjectImageController {
    @Autowired
    private ProjectImagesService projectImagesService;



    @GetMapping()
    public List<String> getAllProjectImg(){
        List<ImageDTO> imgs =  projectImagesService.findAllProjectImages();
        List<String> list = new ArrayList<>();
        for (var ImageDTO:imgs) {
            list.add(ImageDTO.getImageUrl());
        }
        return list;
    }


    @GetMapping("/{id}")
    public String getProjectImagesById(@PathVariable(value = "id") Integer id) {
        return projectImagesService.findProjectImagesById(id).getImageUrl();
    }

    @GetMapping("/project/{id}")
    public List<String> getProjectByTypeId(@PathVariable(value = "id") Integer id) {
        List<ImageDTO> imgs = projectImagesService.findProjectImagesByProjectId(id);
        List<String> list = new ArrayList<>();
        for (var ImageDTO:imgs) {
            list.add(ImageDTO.getImageUrl());
        }
        return list;
    }
}
