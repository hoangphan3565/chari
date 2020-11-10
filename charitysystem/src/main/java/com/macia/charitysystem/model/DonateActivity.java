package com.macia.charitysystem.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@SuppressWarnings("ALL")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DonateActivity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer DNA_ID;

    @ManyToOne
    @JoinColumn(name = "dnt_id")
    private Donator donator;

    @ManyToOne
    @JoinColumn(name = "prj_id")
    private Project project;

    @JsonIgnore
    @OneToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE},mappedBy = "donateActivity")
    private List<DonateDetails> donateDetails;
}
