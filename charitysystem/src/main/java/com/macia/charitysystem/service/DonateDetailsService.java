package com.macia.charitysystem.service;

import com.macia.charitysystem.model.DonateActivity;
import com.macia.charitysystem.model.DonateDetails;
import com.macia.charitysystem.repository.DonateActivityRepository;
import com.macia.charitysystem.repository.DonateDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Service
public class DonateDetailsService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private DonateDetailsRepository donateDetailsRepository;

    public void save(DonateDetails donateDetails) {
        donateDetailsRepository.saveAndFlush(donateDetails);
    }
}
