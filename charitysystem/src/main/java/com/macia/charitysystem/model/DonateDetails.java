package com.macia.charitysystem.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@SuppressWarnings("ALL")
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DonateDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer DND_ID;

    @Column
    private Double money;

    @Column
    private LocalDateTime donateDate;

    @ManyToOne
    @JoinColumn(name = "dna_id")
    private DonateActivity donateActivity;
}
