package com.macia.charitysystem.service;

import com.macia.charitysystem.DTO.ImageDTO;
import com.macia.charitysystem.DTO.ProjectDTO;
import com.macia.charitysystem.model.Project;
import com.macia.charitysystem.model.ProjectType;
import com.macia.charitysystem.repository.ProjectImagesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import java.util.List;

@Service
public class ProjectImagesService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    private ProjectImagesRepository ImageDTORepo;

    public List<ImageDTO> findAllProjectImages(){
        TypedQuery<ImageDTO> query =  em.createNamedQuery("named.projectImages.findAll", ImageDTO.class);
        return query.getResultList();
    }

    public ImageDTO findProjectImagesById(Integer id){
        try{
            TypedQuery<ImageDTO> query =  em.createNamedQuery("named.projectImages.findById", ImageDTO.class);
            query.setParameter("id", id);
            return query.getSingleResult();
        } catch(NoResultException e) {
            return null;
        }
    }

    public List<ImageDTO> findProjectImagesByProjectId(Integer id){
        TypedQuery<ImageDTO> query =  em.createNamedQuery("named.projectImages.findByProjectId", ImageDTO.class);
        query.setParameter("id", id);
        return query.getResultList();
    }
}
