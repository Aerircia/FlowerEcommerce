/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.auth.RegAuth;

import DAO.LoginDAO;
import Utils.ToastUtil;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;

/**
 *
 * @author pipo1
 */
public class RegOTPGenerator extends HttpServlet {

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
            out.println("<title>Servlet RegOTPGenerator</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegOTPGenerator at " + request.getContextPath() + "</h1>");
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String username = request.getParameter("username");
        String nickname = request.getParameter("nickname");
        String phone = request.getParameter("phone");
        HttpSession session = request.getSession();
        session.setAttribute("email", email);
        session.setAttribute("password", password);
        session.setAttribute("username", username);
        session.setAttribute("nickname", nickname);
        session.setAttribute("phone", phone);
        try {
            // validate
            if (email.trim().isEmpty() ||
                    username.trim().isEmpty() ||
                    nickname.trim().isEmpty() ||
                    email.trim().isEmpty() ||
                    phone.trim().isEmpty() ||
                    password.trim().isEmpty()) {
                ToastUtil.setToast(
                        session,
                        "error",
                        "Đăng ký",
                        "Vui lòng nhập đầy đủ thông tin!"
                );
                request.getRequestDispatcher("/WEB-INF/views/auth/Register.jsp").forward(request, response);
                return;
            }
            // password mismatch
            if (!password.equals(confirmPassword)) {
                ToastUtil.setToast(
                        session,
                        "error",
                        "Đăng ký",
                        "Mật khẩu xác nhận không khớp!"
                );
                request.getRequestDispatcher("/WEB-INF/views/auth/Register.jsp").forward(request, response);
                return;
            }
            // email existed
            if (LoginDAO.isEmailTaken(email)) {
                ToastUtil.setToast(
                        session,
                        "error",
                        "Đăng ký",
                        "Email đã được sử dụng!"
                );
                request.getRequestDispatcher("/WEB-INF/views/auth/Register.jsp").forward(request, response);
                return;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            ToastUtil.setToast(
                    session,
                    "error",
                    "Hệ thống",
                    "Lỗi kết nối cơ sở dữ liệu!"
            );
            request.getRequestDispatcher("/WEB-INF/views/auth/Register.jsp").forward(request, response);
        }

        String otp = String.valueOf(new Random().nextInt(900000) + 100000); //otp

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
            MimeMessage message = new MimeMessage(sessionmail);
            message.setFrom(new InternetAddress(email));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Xin chào, Chúng tôi đã nhận được yêu cầu đổi mật khẩu","UTF-8");
            message.setText("1 bước cuối để tạo tài khoản của bạn!\n" + otp + " là mã OTP\nNếu không phải bạn, đừng tiết lộ mã OTP!","UTF-8");

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("otp", otp);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/RegAuth/EnterOTP.jsp");
        rd.forward(request, response);
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
