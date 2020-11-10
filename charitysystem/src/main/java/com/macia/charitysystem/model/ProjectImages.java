package com.macia.charitysystem.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@SuppressWarnings("ALL")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProjectImages {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer PRI_ID;

    @Column
    private String title;

    @Column
    private String imageUrl;

    @Column
    private Boolean isDefault;

    @Column
    private Integer orderNumber;

    @ManyToOne
    @JoinColumn(name = "prj_id")
    private Project project;
}
