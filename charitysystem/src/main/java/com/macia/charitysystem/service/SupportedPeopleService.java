package com.macia.charitysystem.service;

import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.model.SupportedPeople;
import com.macia.charitysystem.repository.SupportedPeopleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

@Service
public class SupportedPeopleService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private SupportedPeopleRepository supportedPeopleRepo;

    public SupportedPeople save(SupportedPeople supportedPeople) {
        return supportedPeopleRepo.saveAndFlush(supportedPeople);
    }

    public SupportedPeople findById(Integer id){
        TypedQuery<SupportedPeople> query =  em.createNamedQuery("named.supportedpeople.findById", SupportedPeople.class);
        query.setParameter("id", id);
        return query.getSingleResult();
    }
}
