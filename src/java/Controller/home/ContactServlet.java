/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.home;

import DAO.AccountsDAO;
import DAO.ContactDAO;
import DAO.OrdersDAO;
import Model.Accounts;
import Model.Contact;
import Model.Orders;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Properties;

/**
 *
 * @author pipo1
 */
public class ContactServlet extends HttpServlet {

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
            out.println("<title>Servlet ContactServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ContactServlet at " + request.getContextPath() + "</h1>");
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
        request.setAttribute("account", account);
        
        request.getRequestDispatcher("/WEB-INF/views/home/Contact.jsp").forward(request, response);
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
        response.setContentType("text/plain;charset=UTF-8");
        HttpSession session = request.getSession();
        int id = (int) session.getAttribute("userId");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // basic server validation
        if (name == null || phone == null || email == null || message == null) {
            response.getWriter().write("error");
            return;
        }
        try {
            ContactDAO dao = new ContactDAO();
            dao.insert(new Contact(id, name, phone, email, message));

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
            Session sessionmail = Session.getInstance(props, new jakarta.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("fleurshopant@gmail.com", "fyjzwoaneojjlods");
                }
            });
            try {
                MimeMessage mm = new MimeMessage(sessionmail);
                mm.setFrom(new InternetAddress(email));
                mm.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                mm.setSubject("Thư phản hồi", "UTF-8");
                mm.setText("\nKính gửi: "+name
                        + "\n\nCảm ơn đã liên hệ với chúng tôi! Đây là thư trả lời tự động, chúng tôi sẽ trả lời lại nhanh nhất có thể!"
                        +"\nHãy cho chúng tôi biết nếu bạn còn có những câu hỏi, ý kiến hoặc sự quan tâm về những mặt hàng của chúng tôi."
                        + "\n\nTrân trọng,"
                        + "\nFleur", "UTF-8");

                Transport.send(mm);
            } catch (MessagingException e) {
                response.getWriter().write("error");
            }
            response.getWriter().write("success");
        } catch (Exception e) {
            response.getWriter().write("error");
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
