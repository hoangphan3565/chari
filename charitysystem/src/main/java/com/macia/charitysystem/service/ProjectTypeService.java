package com.macia.charitysystem.service;

import com.macia.charitysystem.DTO.ProjectDTO;
import com.macia.charitysystem.model.ProjectType;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import java.util.List;

@Service
public class ProjectTypeService {
    @PersistenceContext
    private EntityManager em;

    public List<ProjectType> findAllProjectType() {
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
}
