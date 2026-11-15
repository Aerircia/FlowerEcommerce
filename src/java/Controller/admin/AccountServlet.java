/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Utils.PasswordUtil;
import DAO.AccountsDAO;
import DAO.OrdersDAO;
import Model.Accounts;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author pipo1
 */
public class AccountServlet extends HttpServlet {

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
            out.println("<title>Servlet AccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        String role = request.getParameter("role");
        String section = request.getParameter("section");

        AccountsDAO dao = new AccountsDAO();
        List<Accounts> accounts;
        if (section == null || section.isEmpty()) {
            section = "roleSection";
        }

        if (role != null && !role.isEmpty()) {

            accounts = dao.getAccountsByRole(role);

        } else {

            accounts = dao.getAllAccounts();
        }
        if ("filter".equals(action)) {
            request.setAttribute("accounts", accounts);
            request.setAttribute("section", section);
            request.getRequestDispatcher("/WEB-INF/views/admin/AdminDashboard.jsp").forward(request, response);
        } else if ("deleteAccount".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteAccount(id);
            response.sendRedirect("AdminServlet?section=roleSection");
        }
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
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        AccountsDAO dao = new AccountsDAO();

        try {
            if ("addAccount".equals(action)) {
                String username = request.getParameter("username");
                String nickname = request.getParameter("nickname");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                String avatar = request.getParameter("avatar");
                String address = request.getParameter("address");

                dao.addAccount(username, nickname, email, phone, password, role, avatar, address);
            } else if ("editAccount".equals(action)) {
                String idstr = request.getParameter("idacc");
                if (idstr != null && !idstr.isEmpty()) {
                    int id = Integer.parseInt(idstr);
                    String username = request.getParameter("username");
                    String nickname = request.getParameter("nickname");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String password = request.getParameter("password");
                    String hashedNewPassword = PasswordUtil.hashPassword(password);
                    String role = request.getParameter("role");
                    String avatar = request.getParameter("avatar");
                    String address = request.getParameter("address");
                    dao.updateAccount(id, username, nickname, email, phone, hashedNewPassword, role, avatar, address);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdminServlet?section=roleSection");
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
