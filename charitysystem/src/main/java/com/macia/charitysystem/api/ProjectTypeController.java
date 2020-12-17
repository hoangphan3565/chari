package com.macia.charitysystem.api;

import com.macia.charitysystem.DTO.ImageDTO;
import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.service.ProjectTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/projecttypes")
public class ProjectTypeController {

    @Autowired
    ProjectTypeService projectTypeService;

    @GetMapping()
    public List<ProjectType> getAllProjectType() {
        return projectTypeService.findAllProjectType();
    }
}
