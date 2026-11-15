/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.user;

import DAO.AccountsDAO;
import Utils.PasswordUtil;
import DAO.OrdersDAO;
import Model.Accounts;
import Model.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author pipo1
 */
public class UserServlet extends HttpServlet {

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
            out.println("<title>Servlet UserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserServlet at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        int userid = (int) session.getAttribute("userId");

        Accounts account = new AccountsDAO().getAccountByID(userid);
        List<Orders> orders = new OrdersDAO().getOrdersByID(userid);

        request.setAttribute("account", account);
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/WEB-INF/views/user/UserProfile.jsp").forward(request, response);
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

        AccountsDAO adao = new AccountsDAO();
        OrdersDAO odao = new OrdersDAO();

        try {
            if ("updateProfile".equals(action)) {

                int id = Integer.parseInt(request.getParameter("id"));

                String username = request.getParameter("username");
                String nickname = request.getParameter("nickname");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");

                adao.updateUser(id, username, nickname, phone, address);
            } else if ("updatePassword".equals(action)) {
                HttpSession session = request.getSession();
                int id = Integer.parseInt(request.getParameter("id"));
                String oldPass = request.getParameter("oldPassword");
                String newPass = request.getParameter("newPassword");
                String confirmPass = request.getParameter("confirmPassword");
                if (newPass.equals(confirmPass)) {
                    Accounts acc = adao.getAccountByID(id);
                    if (acc != null && PasswordUtil.checkPassword(oldPass, acc.getPassword())) {
                        // HASH NEW PASSWORD
                        String hashedNewPassword = PasswordUtil.hashPassword(newPass);
                        adao.updatePassword(id, hashedNewPassword);
                        session.setAttribute("type", "success");
                        session.setAttribute("message", "Đổi mật khẩu thành công!");
                    } else {
                        session.setAttribute("type", "error");
                        session.setAttribute("message", "Mật khẩu cũ không đúng!");
                    }
                } else {
                    session.setAttribute("type", "error");
                    session.setAttribute("message", "Mật khẩu mới không khớp!");
                }
            } else if ("updateAvatar".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String avatar = request.getParameter("avatar");
                adao.updateAvatar(id, avatar);
            } else if ("updateOrder".equals(action)) {
                String deliveryType = request.getParameter("delivery_type");

                int orderId = Integer.parseInt(request.getParameter("orderId"));

                String buyerName = request.getParameter("buyer_name");

                String receiverName = request.getParameter("receiver_name");

                String buyerPhone = request.getParameter("buyer_phone");

                String receiverPhone = request.getParameter("receiver_phone");

                String buyerEmail = request.getParameter("buyer_email");

                String shippingAddress = "Nhận tại cửa hàng";

                if ("delivery".equals(deliveryType)) {
                    shippingAddress = request.getParameter("shipping_address");
                }

                String note = request.getParameter("note");

                LocalDate deliveryDate = LocalDate.parse(request.getParameter("delivery_date"));

                odao.updateOrder(orderId, buyerName, receiverName, buyerPhone, receiverPhone, buyerEmail, shippingAddress, note, deliveryDate);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("UserServlet");
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
