/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import DAO.AccountsDAO;
import DAO.CategoryDAO;
import DAO.ContactDAO;
import DAO.OrdersDAO;
import DAO.ProductDAO;
import Model.Accounts;
import Model.Category;
import Model.Contact;
import Model.Orders;
import Model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author pipo1
 */
public class AdminServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminServlet at " + request.getContextPath() + "</h1>");
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
        // chưa login
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("userRole") == null) {
            response.sendRedirect("./LoginServlet");
            return;
        }

        String role = (String) session.getAttribute("userRole");

        if (!"admin".equals(role)) {
            request.getRequestDispatcher("./HomePageServlet").forward(request, response);
            return;
        }
        
        String section = request.getParameter("section");
        if (section == null || section.isEmpty()) {
            section = "dashboardHome";
        }
        List<Double> revenueByMonth = new OrdersDAO().getRevenueByMonth();
        ContactDAO cdao = new ContactDAO();
        int totalProducts = new ProductDAO().countProducts();
        int totalUsers = new AccountsDAO().countUsers();
        int totalOrders = new OrdersDAO().countOrders();
        double totalRevenue = new OrdersDAO().getTotalRevenue();
        List<Orders> orders = new OrdersDAO().getAllOrders();
        List<Product> products = new ProductDAO().getAllProducts();
        List<Accounts> accounts = new AccountsDAO().getAllAccounts();
        List<Category> categories = new CategoryDAO().getAllCategories();
        List<Contact> contacts = cdao.getAllContacts();
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("contactList", contacts);
        request.setAttribute("revenueByMonth", revenueByMonth);
        request.setAttribute("orders", orders);
        request.setAttribute("allCategories", categories);
        request.setAttribute("products", products);
        request.setAttribute("accounts", accounts);
        request.setAttribute("section", section);
        request.getRequestDispatcher("/WEB-INF/views/admin/AdminDashboard.jsp").forward(request, response);
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
        ProductDAO dao = new ProductDAO();
        CategoryDAO cdao = new CategoryDAO();

        String categoryId = request.getParameter("categoryId");

        List<Product> list;

        if (categoryId != null && !categoryId.isEmpty()) {
            list = dao.getProductsByCategory(Integer.parseInt(categoryId));
        } else {
            list = dao.getAllProducts();
        }

        request.setAttribute("products", list);
        request.setAttribute("allCategories", cdao.getAllCategories());
        request.setAttribute("section", "productSection");
        request.getRequestDispatcher("/WEB-INF/views/admin/AdminDashboard.jsp").forward(request, response);
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
