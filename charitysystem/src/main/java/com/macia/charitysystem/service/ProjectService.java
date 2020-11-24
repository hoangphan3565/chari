package com.macia.charitysystem.service;

import com.macia.charitysystem.DTO.ProjectDTO;
import com.macia.charitysystem.model.Project;
import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.StoredProcedureQuery;
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

    @SuppressWarnings("unchecked")
    public List<ProjectDTO> findAllProjectDTO(){
        StoredProcedureQuery query = this.em.createNamedStoredProcedureQuery("named_getProjectDTOList");
        query.execute();
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<ProjectDTO> findProjectDTOById(Integer id){
        StoredProcedureQuery query = this.em.createNamedStoredProcedureQuery("named_getProjectDTOById");
        query.setParameter("id",id);
        query.execute();
        return query.getResultList();
    }
    @SuppressWarnings("unchecked")
    public List<ProjectDTO> findAllProjectDTOByType(Integer prtid){
        StoredProcedureQuery query = this.em.createNamedStoredProcedureQuery("named_getProjectDTOListByType");
        query.setParameter("prtid",prtid);
        query.execute();
        return query.getResultList();
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
