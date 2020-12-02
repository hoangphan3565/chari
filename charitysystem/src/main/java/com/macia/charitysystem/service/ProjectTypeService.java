package com.macia.charitysystem.service;

import com.macia.charitysystem.model.Project;
import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.repository.ProjectTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

@Service
public class ProjectTypeService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private ProjectTypeRepository projectTypeRepo;

    public ProjectType save(ProjectType projectType) {
        return projectTypeRepo.saveAndFlush(projectType);
    }

    public ProjectType findById(Integer id){
        try{
            TypedQuery<ProjectType> query =  em.createNamedQuery("named.projecttype.findById", ProjectType.class);
            query.setParameter("id", id);
            return query.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }
}
