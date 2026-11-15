/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author pipo1
 */
public class CartItem {
    private int product_id;
    private String product_name;
    private double price;
    private String img_path;
    private int quantity;

    public CartItem() {
    }

    public CartItem(int product_id, String product_name, double price, String img_path, int quantity) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.price = price;
        this.img_path = img_path;
        this.quantity = quantity;
    }

    public int getProduct_id() {
        return product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public double getPrice() {
        return price;
    }

    public String getImg_path() {
        return img_path;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setImg_path(String img_path) {
        this.img_path = img_path;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

   
    
    
}
