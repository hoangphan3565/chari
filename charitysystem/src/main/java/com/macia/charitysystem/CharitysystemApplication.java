package com.macia.charitysystem;

import com.macia.charitysystem.model.Donator;
import com.macia.charitysystem.service.DonatorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CharitysystemApplication implements CommandLineRunner {

    @Autowired
    DonatorService donatorService;

    public static void main(String[] args) {
        SpringApplication.run(CharitysystemApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        System.out.println("Web API service is running!");
    }
}
