/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.CartItem;
import Model.Product;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author pipo1
 */
public class CartItemDAO {
    private final Map<Integer, CartItem> items = new HashMap<>();

    public void add(Product p, int qty) {
        int id = p.getProduct_id();
        if (items.containsKey(id)) {
            items.get(id).setQuantity(items.get(id).getQuantity() + qty);
        } else {
            CartItem item = new CartItem(
                    p.getProduct_id(),
                    p.getProduct_name(),
                    p.getGia_sau(),
                    p.getImg_path(),
                    qty
            );
            items.put(id, item);
        }
    }

    public void remove(int id) {
        items.remove(id);
    }

    public void updateQuantity(int productId, int qty) {
        if (items.containsKey(productId)) {
            if (qty <= 0) {
                items.remove(productId);
            } else {
                items.get(productId).setQuantity(qty);
            }
        }
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }

    public int getTotalQuantity() {
        int total = 0;
        for (CartItem i : items.values()) {
            total += i.getQuantity();
        }
        return total;
    }

    public double getTotalPrice() {
        double total = 0;
        for (CartItem item : items.values()) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }
    
    public boolean isEmpty() {
        return items.isEmpty();
    }
    
    public void clear() {
        items.clear();
    }
}
