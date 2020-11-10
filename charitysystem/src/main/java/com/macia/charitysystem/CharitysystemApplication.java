package com.macia.charitysystem;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CharitysystemApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(CharitysystemApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		System.out.println("Web API service is running!");
	}
}
