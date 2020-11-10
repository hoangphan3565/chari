package com.macia.charitysystem.service;

import com.macia.charitysystem.model.Donator;
import com.macia.charitysystem.repository.DonatorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Service
public class DonatorService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private DonatorRepository donatorRepo;

    public Donator save(Donator donator) {
        return donatorRepo.saveAndFlush(donator);
    }
}
