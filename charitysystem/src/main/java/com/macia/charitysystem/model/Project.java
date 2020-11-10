package com.macia.charitysystem.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jayway.jsonpath.internal.function.numeric.Max;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@SuppressWarnings("ALL")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@NamedQueries({
        @NamedQuery(name = "named.project.findAll",
                query = "SELECT p FROM Project p"),
        @NamedQuery(name = "named.project.findById",
                query = "SELECT p FROM Project p where p.PRJ_ID =:id"),
        @NamedQuery(name = "named.project.findByProjectTypeId",
                query = "SELECT p FROM Project p where p.projectType.PRT_ID =:id"),
        @NamedQuery(name = "named.project.findAllProjectLikeProjectName",
                query = "from Project p where LOWER(p.projectName) like '%' || LOWER(:projectName) ||'%'"),
})
public class Project {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer PRJ_ID;

    @Column(length = 10,unique = true)
    private String projectCode;

    @Column(length = 200)
    private String projectName;

    @Column(length = 5000)
    private String description;

    @Column
    private LocalDate startDate;

    @Column
    private LocalDate endDate;

    @Column
    private Integer targetMoney;

    @Column(length = 20)
    private String status;

    @Column(length = 500)
    private String videoUrl;

    @ManyToOne
    @JoinColumn(name = "prt_id")
    private ProjectType projectType;

    @ManyToOne
    @JoinColumn(name = "stp_id")
    private SupportedPeople supportedPeople;

    @ManyToOne
    @JoinColumn(name = "clb_id")
    private Collaborator collaborator;

    @JsonIgnore
    @OneToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE},mappedBy = "project")
    private List<ProjectImages> projectImages;

    @JsonIgnore
    @OneToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE},mappedBy = "project")
    private List<DonateActivity> donateActivities;
}
