<%-- 
    Document   : Register
    Created on : May 11, 2026, 1:38:18 AM
    Author     : pipo1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/CSS/Register.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <link rel="icon" href="assets/img/icon.jpg">
        <title>Fleur Sign Up</title>
    </head>
    <body>
        <div class="auth-wrapper">
            <div class="auth-card register-card">
                <!-- LEFT SIDE -->
                <div class="auth-image">
                    <div class="overlay"></div>
                    <div class="image-content">
                        <span class="mini-title">
                            FLEUR LUXURY COLLECTION
                        </span>
                        <h2>Tạo tài khoản của bạn</h2>
                        <p>
                            Hãy cùng Fleur trải nghiệm nghệ thuật cắm hoa thanh lịch,
                            những bó hoa cao cấp và dịch vụ giao hoa sang trọng được tạo ra
                            với niềm đam mê và sự tinh tế.
                        </p>
                    </div>
                </div>
                <!-- RIGHT SIDE -->
                <div class="form-container sign-up">
                    <form action="./RegOTPGenerator" method="post">
                        <span class="auth-subtitle">
                            TẠO TÀI KHOẢN
                        </span>
                        <h1>Đăng ký</h1>
                        <!-- USERNAME -->
                        <div class="input-group">
                            <i class="bx bx-user"></i>
                            <input
                                type="text"
                                name="username"
                                placeholder="Enter Your Username"
                                required
                                >
                        </div>
                        <!-- NICKNAME -->
                        <div class="input-group">
                            <i class="bx bx-smile"></i>
                            <input
                                type="text"
                                name="nickname"
                                placeholder="Enter Your Nickname"
                                required
                                >
                        </div>
                        <!-- EMAIL -->
                        <div class="input-group">
                            <i class="bx bx-envelope"></i>
                            <input
                                type="email"
                                name="email"
                                placeholder="Enter Your Email"
                                required
                                >
                        </div>
                        <!-- PHONE -->
                        <div class="input-group">
                            <i class="bx bx-phone"></i>
                            <input
                                type="tel"
                                name="phone"
                                placeholder="Enter Your Phone"
                                required
                                >
                        </div>
                        <!-- PASSWORD -->
                        <div class="input-group">
                            <i class="bx bx-lock-alt"></i>
                            <input
                                type="password"
                                name="password"
                                pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                                title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
                                placeholder="Enter Password"
                                required
                                >
                        </div>
                        <!-- CONFIRM PASSWORD -->
                        <div class="input-group">
                            <i class="bx bx-check-shield"></i>
                            <input
                                type="password"
                                name="confirmPassword"
                                placeholder="Confirm Password"
                                required
                                >
                        </div>
                        <!-- BUTTON -->
                        <button type="submit" class="auth-btn">
                            TẠO TÀI KHOẢN
                        </button>
                        <!-- LOGIN -->
                        <div class="bottom-container">
                            <p>
                                Đã có tài khoản?
                            </p>
                            <a href="./LoginServlet">
                                Đăng nhập
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="toast-container position-fixed top-0 end-0 p-3"
             id="toastContainer"
             style="z-index:9999;">
        </div>
        <c:if test="${not empty sessionScope.type}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    showToast(
                            "${sessionScope.type}",
                            "${sessionScope.title}",
                            "${sessionScope.message}"
                            );
                });
            </script>
            <c:remove var="type" scope="session"/>
            <c:remove var="title" scope="session"/>
            <c:remove var="message" scope="session"/>
        </c:if>
        <script src="assets/JS/loginregister.js" defer></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
    </body>
</html>
