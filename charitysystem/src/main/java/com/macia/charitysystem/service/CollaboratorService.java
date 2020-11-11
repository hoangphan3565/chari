package com.macia.charitysystem.service;

import com.macia.charitysystem.model.Collaborator;
import com.macia.charitysystem.model.Donator;
import com.macia.charitysystem.repository.CollaboratorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Service
public class CollaboratorService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private CollaboratorRepository collaboratorRepo;

    public Collaborator save(Collaborator collaborator) {
        return collaboratorRepo.saveAndFlush(collaborator);
    }
}