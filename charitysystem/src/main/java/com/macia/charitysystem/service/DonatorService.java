package com.macia.charitysystem.service;

import com.macia.charitysystem.model.Donator;
import com.macia.charitysystem.repository.DonatorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

@Service
public class DonatorService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private DonatorRepository donatorRepo;

    public void save(Donator donator) {
        donatorRepo.saveAndFlush(donator);
    }

    public Donator findById(Integer id){
        return donatorRepo.findById(id).orElseThrow();
    }

    public Donator findByPhone(String phone){
        try{
            return donatorRepo.findByPhoneNumber(phone);
        } catch(NoResultException e) {
            return null;
        }
    }

    public void addProjectToFavoriteList(Integer projectId,Integer donatorid){
        Donator donator = donatorRepo.findById(donatorid).orElseThrow();
        donator.setFavoriteProject(donator.getFavoriteProject()+projectId.toString()+" ");
        donatorRepo.saveAndFlush(donator);
    }
    public void removeProjectFromFavoriteList(Integer projectId,Integer donatorid){
        Donator donator = donatorRepo.findById(donatorid).orElseThrow();
        String[] curFavoriteList = donator.getFavoriteProject().split(" "); // "1 2 10 11 " -> [1,2,10,11,]
        StringBuilder sb = new StringBuilder();
        for (String s : curFavoriteList) {
            if (!s.equals(projectId.toString())) sb.append(s).append(" ");
        }
        donator.setFavoriteProject(sb.toString());
        donatorRepo.saveAndFlush(donator);
    }
}
