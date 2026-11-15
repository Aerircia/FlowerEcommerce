/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Cart;

import DAO.CartItemDAO;
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

/**
 *
 * @author pipo1
 */
public class CheckOut extends HttpServlet {

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
            out.println("<title>Servlet CheckOut</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckOut at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        if (session == null || session.getAttribute("userRole") == null) {
            response.sendRedirect("./LoginServlet");
            return;
        }
        Accounts userAcc = (Accounts) session.getAttribute("userAcc");
        if (userAcc != null) {
            request.setAttribute("user_id", userAcc.getUserID());
            request.setAttribute("username", userAcc.getUsername());
            request.setAttribute("email", userAcc.getEmail());
            request.setAttribute("phone", userAcc.getPhone());
            request.setAttribute("address", userAcc.getAddress());
        }
        CartItemDAO cart = (CartItemDAO) session.getAttribute("cart");
        if (cart == null) {
            cart = new CartItemDAO();
            session.setAttribute("cart", cart);
        }
        request.getRequestDispatcher("/WEB-INF/views/cart/CheckOut.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        int id = (int) session.getAttribute("userId");
        CartItemDAO cart = (CartItemDAO) session.getAttribute("cart");

        // nếu cart rỗng
        if (cart == null || cart.getItems().isEmpty()) {
            request.setAttribute("type", "error");
            request.setAttribute("message", "Giỏ hàng đang trống!");
            request.getRequestDispatcher("/WEB-INF/views/cart/CheckOut.jsp").forward(request, response);
            return;
        }

        try {
            String buyerName = request.getParameter("customer_name");
            String buyerPhone = request.getParameter("customer_phone");
            String buyerEmail = request.getParameter("customer_email");
            String receiverName = request.getParameter("receiver_name");
            String receiverPhone = request.getParameter("receiver_phone");
            String deliveryType = request.getParameter("delivery_type");
            String address = "Nhận tại cửa hàng";
            if (buyerName.trim().isEmpty()
                    || buyerPhone.trim().isEmpty()
                    || buyerEmail.trim().isEmpty()
                    || receiverName.trim().isEmpty()
                    || receiverPhone.trim().isEmpty()
                    || address.trim().isEmpty()) {
                request.setAttribute("type", "error");
                request.setAttribute("message", "Vui lòng nhập thông tin!");
                request.getRequestDispatcher("/WEB-INF/views/cart/CheckOut.jsp").forward(request, response);
                return;
            }
            if ("delivery".equals(deliveryType)) {
                address = request.getParameter("address");
            }

            String receiveDate = request.getParameter("receive_date");

            LocalDate deliveryDate = null;

            if (receiveDate != null && !receiveDate.isEmpty()) {
                deliveryDate = LocalDate.parse(receiveDate);
            }

            String note = request.getParameter("note");
            String paymentRaw = request.getParameter("payment_method");

            int paymentMethod = 0;
            if ("deposit".equals(paymentRaw)) {
                paymentMethod = 1;
            }

            double total = cart.getTotalPrice();

            Orders order = new Orders();
            order.setBuyer_id(id);
            order.setBuyer_name(buyerName);
            order.setBuyer_phone(buyerPhone);
            order.setBuyer_email(buyerEmail);

            order.setReceiver_name(receiverName);
            order.setReceiver_phone(receiverPhone);

            order.setShipping_address(address);

            order.setDelivery_date(deliveryDate);

            order.setNote(note);

            order.setTotal(total);

            order.setPayment_method(paymentMethod);

            OrdersDAO dao = new OrdersDAO();

            boolean success = dao.createOrder(order, cart.getItems());
            if (success) {
                session.removeAttribute("cart");
                request.setAttribute("type", "success");
                request.setAttribute("message", "Đặt hàng thành công!");
            } else {
                request.setAttribute("type", "error");
                request.setAttribute("message", "Có lỗi xảy ra khi đặt hàng!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("type", "error");
            request.setAttribute("message", "Có lỗi xảy ra!");
        }

        request.getRequestDispatcher("/WEB-INF/views/cart/CheckOut.jsp").forward(request, response);

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
