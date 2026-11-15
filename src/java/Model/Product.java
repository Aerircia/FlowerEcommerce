/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.ArrayList;
import java.util.List;

public class Product {

    private int product_id;
    private String product_name;
    private String description;
    private double price;
    private double gia_sau;
    private int discount_percent;
    private int sold;
    private String img_path;
    List<Category> categories=new ArrayList();
    
    public Product(int product_id, String product_name, double price, String description, int discount_percent, String img_path, int sold,List categories) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.description = description;
        this.price = price;
        this.discount_percent = discount_percent;
        this.sold = sold;
        this.img_path = img_path;
        this.categories=categories;
        
    }

    public Product(int product_id, String product_name, double price, double gia_sau, int discount_percent, String img_path) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.price = price;
        this.gia_sau = gia_sau;
        this.discount_percent = discount_percent;
        this.img_path = img_path;
    }

    public Product() {
    }

    public int getProduct_id() {
        return product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public double getGia_sau() {
        return gia_sau;
    }

    public int getDiscount_percent() {
        return discount_percent;
    }

    public int getSold() {
        return sold;
    }

    public String getImg_path() {
        return img_path;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setGia_sau(double gia_sau) {
        this.gia_sau = gia_sau;
    }

    public void setDiscount_percent(int discount_percent) {
        this.discount_percent = discount_percent;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public void setImg_path(String img_path) {
        this.img_path = img_path;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public void setCategories(List<Category> categories) {
        this.categories = categories;
    }


 
}
