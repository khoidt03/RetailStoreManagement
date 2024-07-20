/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import DAL.ProductDAO;
import java.util.Random;

/**
 *
 * @author ADMIN
 */
public class RandomCode {
    public String getRandomString() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder result = new StringBuilder(9);
        Random random = new Random();
        for (int i = 0; i < 9; i++) {
            int charIndex = random.nextInt(characters.length());
            result.append(characters.charAt(charIndex));
        }
        return "P" + result.toString();
    } 
    
    public String generateCode(){
        ProductDAO dao = new ProductDAO();
        String code = getRandomString();
        while(dao.isExistProduct(code)){
            code = getRandomString();
        }
        return code;
    } 
}
