<%-- 
    Document   : Login
    Created on : Apr 27, 2026, 8:04:19 PM
    Author     : pipo1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <link href="assets/CSS/Login.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" href="assets/img/icon.jpg">
        <title>Fleur Login</title>
    </head>
    <body>
        <div class="auth-wrapper">
            <div class="auth-card">
                <!-- LEFT IMAGE -->
                <div class="auth-image">
                    <div class="overlay"></div>
                    <div class="image-content">
                        <h2>Chào mừng trở lại!</h2>
                        <p>
                            Khám phá những bó hoa sang trọng được chế tác tinh tế và đầy tình yêu thương.
                        </p>
                    </div>
                </div>
                <!-- RIGHT FORM -->
                <div class="form-container sign-in">
                    <form action="./LoginServlet" method="post">
                        <span class="auth-subtitle">
                            LUXURY FLOWER BOUTIQUE
                        </span>
                        <h1>Đăng nhập</h1>
                        <div class="input-group">
                            <i class="bx bx-envelope"></i>
                            <input
                                name="email"
                                type="text"
                                placeholder="Email Address"
                                >
                        </div>
                        <div class="input-group">
                            <i class="bx bx-lock-alt"></i>
                            <input
                                name="password"
                                type="password"
                                placeholder="Password"
                                >
                        </div>
                        <button type="submit" class="auth-btn">
                            ĐĂNG NHẬP
                        </button>
                        <div class="bottom-container">
                            <a href="./RegisterServlet">
                                Tạo tài khoản
                            </a>
                            <a href="./ForgotPassword">
                                Quên mật khẩu?
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
        <script src="assets/JS/loginregister.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
    </body>
</html>
