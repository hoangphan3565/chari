package com.macia.charitysystem.api;

import com.macia.charitysystem.model.Project;
import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.model.SupportedPeople;
import com.macia.charitysystem.service.ProjectService;
import com.macia.charitysystem.service.ProjectTypeService;
import com.macia.charitysystem.service.SupportedPeopleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/projects")
public class ProjectController {
    @Autowired
    private ProjectService projectService;

    @Autowired
    private ProjectTypeService projectTypeService;

    @Autowired
    private SupportedPeopleService supportedPeopleService;


    @GetMapping()
    public ResponseEntity<?> getAllProject() {
        return ResponseEntity.ok().body(projectService.findAllProjectDTO());
    }


    @GetMapping("/type/{id}")
    public ResponseEntity<?> getProjectByTypeId(@PathVariable(value = "id") Integer id) {
        return ResponseEntity.ok().body(projectService.findAllProjectDTOByType(id));
    }


    @PostMapping("/create/type/{prtid}/peo/{sptid}")
    public ResponseEntity<?> createEmployeeWithDeptAndPostID(
            @RequestBody Project project,
            @PathVariable(value = "prtid") Integer prtid,
            @PathVariable(value = "sptid") Integer sptid) {
        ProjectType projectType = projectTypeService.findById(prtid);
        project.setProjectType(projectType);
        SupportedPeople supportedPeople = supportedPeopleService.findById(sptid);
        project.setSupportedPeople(supportedPeople);
        return ResponseEntity.ok().body(projectService.save(project));
    }
}
