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

    @Column(length=200)
    private String title;

    @Column(length=500)
    private String imageUrl;

    @Column
    private Integer orderNumber;

    @ManyToOne
    @JoinColumn(name = "prj_id")
    private Project project;
}
