package com.macia.charitysystem.repository;

import com.macia.charitysystem.model.Transactions;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TransactionsRepository extends JpaRepository<Transactions, Integer> {
}
