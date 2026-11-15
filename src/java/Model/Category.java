/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author pipo1
 */
public class Category {
    private int category_id;
    private String category_name;

    public Category() {
    }

    public Category(int category_id, String category_name) {
        this.category_id = category_id;
        this.category_name = category_name;
    }

    public int getCategoryID() {
        return category_id;
    }

    public String getCategoryName() {
        return category_name;
    }

    public void setCategoryID(int category_id) {
        this.category_id = category_id;
    }

    public void setCategoryName(String category_name) {
        this.category_name = category_name;
    }
    
}
