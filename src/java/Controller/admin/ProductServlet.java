/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import Model.Product;
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
public class ProductServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        String categoryId = request.getParameter("categoryId");
        String section = request.getParameter("section");
        ProductDAO dao = new ProductDAO();
        List<Product> products;
        CategoryDAO cdao = new CategoryDAO();
        if (section == null || section.isEmpty()) {
            section = "productSection";
        }
        if (categoryId != null && !categoryId.isEmpty()) {
            products = dao.getProductsByCategory(Integer.parseInt(categoryId));
        } else {
            products = dao.getAllProducts();
        }
        if ("filterpd".equals(action)) {
            request.setAttribute("products", products);
            request.setAttribute("allCategories", cdao.getAllCategories());
            request.setAttribute("section", section);
            request.getRequestDispatcher("/WEB-INF/views/admin/AdminDashboard.jsp").forward(request, response);
        } else if ("deleteProduct".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteProduct(id);
            response.sendRedirect("AdminServlet?section=productSection");
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
        ProductDAO dao = new ProductDAO();

        try {
            if ("addProduct".equals(action)) {
                String name = request.getParameter("ten_sp");
                double price = Double.parseDouble(request.getParameter("gia_goc"));
                String descrip = request.getParameter("mo_ta");
                int sold = Integer.parseInt(request.getParameter("sold"));
                String image = request.getParameter("img_path");
                int dis = Integer.parseInt(request.getParameter("discount_percent"));
                String[] categoryIds = request.getParameterValues("categoryIds");

                dao.addProduct(name, price, descrip, sold, image, dis, categoryIds);
            } else if ("editProduct".equals(action)) {
                int id = Integer.parseInt(request.getParameter("ma_sp"));
                String name = request.getParameter("ten_sp");
                double price = Double.parseDouble(request.getParameter("gia_goc"));
                String descrip = request.getParameter("mo_ta");
                int sold = Integer.parseInt(request.getParameter("sold"));
                String image = request.getParameter("img_path");
                int dis = Integer.parseInt(request.getParameter("discount_percent"));
                String[] categoryIds = request.getParameterValues("categoryIds");
                dao.updateProduct(id, name, price, descrip, sold, image, dis, categoryIds);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdminServlet?section=productSection");
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
