/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author pipo1
 */
public class Contact {
    private final String name, phone, email, message;
    private final int contact_id;

    public Contact(int contact_id, String name, String phone, String email, String message) {
        this.contact_id = contact_id;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.message = message;
    }
    public int getContact_id() {
        return contact_id;
    }
    public String getName(){ return name; }
    public String getPhone(){ return phone; }
    public String getEmail(){ return email; }
    public String getMessage(){ return message; }
}