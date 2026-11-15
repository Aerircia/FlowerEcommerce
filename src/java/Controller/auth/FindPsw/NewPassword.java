/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.auth.FindPsw;

import Utils.PasswordUtil;
import Model.DBConnection;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

/**
 *
 * @author pipo1
 */
public class NewPassword extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newpass = request.getParameter("newpass");
        String confirm = request.getParameter("confirm");

        if (newpass.equals(confirm)) {
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");
            try {
                Connection conn = DBConnection.getConnection();

                PreparedStatement pst = conn.prepareStatement("update users set password=? where email=?");
                String hashedPassword = PasswordUtil.hashPassword(newpass);
                pst.setString(1, hashedPassword);
                pst.setString(2, email);

                pst.executeUpdate();

                session.setAttribute("type", "success");
                session.setAttribute("title", "Password Reset");
                session.setAttribute("message", "Your password has been updated successfully!");
                response.sendRedirect("./LoginServlet");
                return;

            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {

            request.setAttribute("msg3", "Passwords do not match");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/ForgorPassword/NewPassword.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
