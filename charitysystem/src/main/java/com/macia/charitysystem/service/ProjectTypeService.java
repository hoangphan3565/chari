package com.macia.charitysystem.service;

import com.macia.charitysystem.DTO.ProjectDTO;
import com.macia.charitysystem.model.Collaborator;
import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.repository.ProjectTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import java.util.List;

@Service
public class ProjectTypeService {
    @PersistenceContext
    private EntityManager em;
    @Autowired
    private ProjectTypeRepository ptRepo;

    public List<ProjectType> findAll() {
        TypedQuery<ProjectType> query = em.createNamedQuery("named.projecttype.findAll", ProjectType.class);
        return query.getResultList();
    }

    public ProjectType findById(Integer id) {
        try {
            TypedQuery<ProjectType> query = em.createNamedQuery("named.projecttype.findById", ProjectType.class);
            query.setParameter("id", id);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
    public ProjectType save(ProjectType pt) {
        return ptRepo.saveAndFlush(pt);
    }

    public void removeById(Integer id){
        ptRepo.deleteById(id);
    }
}
