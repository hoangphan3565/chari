package com.macia.charitysystem.service;

import com.macia.charitysystem.model.Project;
import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Service
public class ProjectService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private ProjectRepository projectRepo;

    public Project save(Project project) {
        return projectRepo.saveAndFlush(project);
    }

    public List<Project> findAllProject(){
        TypedQuery<Project> query =  em.createNamedQuery("named.project.findAll", Project.class);
        return query.getResultList();
    }

    public Project findProjectById(Integer id){
        TypedQuery<Project> query =  em.createNamedQuery("named.project.findById", Project.class);
        query.setParameter("id", id);
        return query.getSingleResult();
    }

    public List<Project> findProjectByTypeId(Integer id){
        TypedQuery<Project> query =  em.createNamedQuery("named.project.findByProjectTypeId", Project.class);
        query.setParameter("id", id);
        return query.getResultList();
    }
}
