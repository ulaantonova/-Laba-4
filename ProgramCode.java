package com.mycompany.product;


public class ProgramCode {
    private static final String PRODUCT_NAME = "MySoftwareProduct";

    
    public static void displayProductName(String name) {
        System.out.println("Створюємо програмний продукт: " + name);
    }

    public static void main(String[] args) {
        displayProductName(PRODUCT_NAME);
    }
}
