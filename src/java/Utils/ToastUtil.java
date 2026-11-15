/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

/**
 *
 * @author pipo1
 */

import jakarta.servlet.http.HttpSession;

public class ToastUtil {

    public static void setToast(
            HttpSession session,
            String type,
            String title,
            String message
    ) {

        session.setAttribute("type", type);
        session.setAttribute("title", title);
        session.setAttribute("message", message);
    }
}