package com.macia.charitysystem.service;

import com.macia.charitysystem.model.Donator;
import org.aspectj.lang.annotation.Before;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
public class DonatorServiceTest {
    @Autowired
    private DonatorService donatorService;

    @Test
    public void testFindDonatorById_ShouldNotNull_WhenEnteringTheValidDonatorId(){
        System.out.println("----test case for findById in DonatorServiceTest is running-----");
        assertNotNull(donatorService.findById(1));
    }

    @Test
    public void testFindDonatorByPhone_ShouldNotNull_WhenEnteringTheValidPhoneNumber(){
        System.out.println("----test case for findById in DonatorServiceTest is running-----");
        assertNotNull(donatorService.findByPhone("0973465515"));
    }

    @Test
    public void testAddProjectIdToFavoriteList_ShouldTrue_WhenCallFunctionForDonatorHaveNotProjectIdInFavouriteListYet(){
        System.out.println("----test case for addProjectIdToFavoriteList in DonatorServiceTest is running-----");
        donatorService.addProjectIdToFavoriteList(5,1);
        String list = donatorService.findById(1).getFavoriteProject();
        assertTrue(list.indexOf('5') > 0);
    }

    @Test
    public void testRemoveProjectIdFromFavoriteList_ShouldTrue_WhenCallFunctionForDonatorAlreadyHaveProjectIdInFavouriteList(){
        System.out.println("----test case for removeProjectIdFromFavoriteList in DonatorServiceTest is running-----");
        donatorService.removeProjectIdFromFavoriteList(5,1);
        String list = donatorService.findById(1).getFavoriteProject();
        assertTrue(list.indexOf('5') < 0);
    }
}
