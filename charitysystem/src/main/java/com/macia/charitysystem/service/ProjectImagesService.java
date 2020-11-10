package com.macia.charitysystem.service;

import com.macia.charitysystem.model.ProjectImages;
import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.repository.ProjectImagesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Service
public class ProjectImagesService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private ProjectImagesRepository projectImagesRepo;

    public ProjectImages save(ProjectImages projectImages) {
        return projectImagesRepo.saveAndFlush(projectImages);
    }
}
