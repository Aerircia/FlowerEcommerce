/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Cart;

import DAO.CartItemDAO;
import DAO.ProductDAO;
import Model.CartItem;
import Model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author pipo1
 */
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        CartItemDAO cart = (CartItemDAO) session.getAttribute("cart");
        if (cart == null) {
            cart = new CartItemDAO();
        }
        
        if ("add".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int qty = 1;
            String qtyRaw = request.getParameter("qty");
            if (qtyRaw != null && !qtyRaw.isEmpty()) {
                qty = Integer.parseInt(qtyRaw);
            }
            ProductDAO dao = new ProductDAO();
            Product p = dao.getProductById(id);
            if (p != null) {
                cart.add(p, qty);
            }
        }

        if ("remove".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            cart.remove(id);
        }

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int qty = Integer.parseInt(request.getParameter("qty"));

            cart.updateQuantity(id, qty);
        }

        session.setAttribute("cart", cart);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"total\":")
                .append(cart.getTotalQuantity())
                .append(",");
        json.append("\"totalPrice\":")
                .append(cart.getTotalPrice())
                .append(",");
        json.append("\"items\":[");

        boolean first = true;
        for (CartItem item : cart.getItems()) {
            if (!first) {
                json.append(",");
            }
            first = false;
            json.append("{")
                    .append("\"product_id\":")
                    .append(item.getProduct_id())
                    .append(",")
                    .append("\"product_name\":\"")
                    .append(item.getProduct_name())
                    .append("\",")
                    .append("\"price\":")
                    .append(item.getPrice())
                    .append(",")
                    .append("\"img_path\":\"")
                    .append(item.getImg_path())
                    .append("\",")
                    .append("\"quantity\":")
                    .append(item.getQuantity())
                    .append("}");
        }
        json.append("]}");
        response.getWriter().print(json.toString());
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
        processRequest(request, response);
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
