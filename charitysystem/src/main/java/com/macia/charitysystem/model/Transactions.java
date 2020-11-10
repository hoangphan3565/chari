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
public class Transactions {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer TRS_ID;

    @ManyToOne
    @JoinColumn(name = "dnt_id")
    private Donator donator;
}
