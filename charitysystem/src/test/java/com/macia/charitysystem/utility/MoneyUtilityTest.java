package com.macia.charitysystem.utility;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class MoneyUtilityTest {
    @Test
    public void testConvertMoney_ShouldReturnSameValue_WhenEnteringUSDMoney(){
        System.out.println("-----Convert Money test is running-----");
        assertEquals(460500,MoneyUtility.USDToVND(20));
    }
    @Test
    public void testConvertMoney_ShouldReturnSameValue_WhenEnteringVNDMoney(){
        System.out.println("-----Convert Money test is running-----");
        assertEquals(43.43,MoneyUtility.VNDToUSD(1000000));
    }
}
