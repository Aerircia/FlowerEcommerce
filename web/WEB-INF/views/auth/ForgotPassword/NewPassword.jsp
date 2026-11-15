<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Recover</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <link href="assets/CSS/Login.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" href="assets/img/icon.jpg">
        <style>
            @import "STYLE.css";
            .reset-card{
                min-height: 720px;
            }
            .reset-description{
                color: #777;
                font-size: 14px;
                line-height: 1.8;
                margin-bottom: 32px;
            }
            .error-box{
                width: 100%;
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 16px 18px;
                border-radius: 16px;
                margin-bottom: 20px;
                background: rgba(255, 77, 77, 0.08);
                border: 1px solid rgba(255, 77, 77, 0.15);
                color: #d62828;
                font-size: 14px;
            }
            .error-box i{
                font-size: 18px;
            }
            @media(max-width: 992px){
                .reset-card{
                    grid-template-columns: 1fr;
                }
            }
            @media(max-width: 576px){
                .reset-description{
                    font-size: 13px;
                }
                .error-box{
                    font-size: 13px;
                }
            }
        </style>
    </head>

    <body>
        <div class="auth-wrapper">
            <div class="auth-card reset-card">
                <!-- LEFT IMAGE -->
                <div class="auth-image">
                    <div class="overlay"></div>
                    <div class="image-content">
                        <h2>Create New Password</h2>
                        <p>
                            Thông tin của bạn đã được xác minh thành công.
                            Hãy tạo mật khẩu mới mạnh để bảo mật tài khoản của bạn.
                        </p>
                    </div>
                </div>
                <!-- RIGHT FORM -->
                <div class="form-container reset-form">
                    <form action="./NewPassword" method="post">
                        <span class="auth-subtitle">
                            KHÔI PHỤC MẬT KHẨU
                        </span>
                        <h1>Đặt lại mật khẩu</h1>
                        <p class="reset-description">
                            Vui lòng nhập mật khẩu mới của bạn và xác nhận bên dưới.
                        </p>
                        <!-- NEW PASSWORD -->
                        <div class="input-group">
                            <i class='bx bx-lock-alt'></i>
                            <input
                                type="password"
                                name="newpass"
                                placeholder="New Password"
                                pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                                title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
                                required
                                >
                        </div>
                        <!-- CONFIRM PASSWORD -->
                        <div class="input-group">
                            <i class='bx bx-check-shield'></i>
                            <input
                                type="password"
                                name="confirm"
                                placeholder="Confirm Password"
                                required
                                >
                        </div>
                        <% String error = (String) request.getAttribute("msg3");

                            if (error != null) {
                        %>
                        <div class="error-box">
                            <i class='bx bx-error-circle'></i>
                            <span><%= error%></span>
                        </div>
                        <% }%>
                        <!-- BUTTON -->
                        <button type="submit" class="auth-btn">
                            ĐẶT LẠI MẬT KHẨU
                        </button>
                        <!-- BOTTOM -->
                        <div class="bottom-container">
                            <a href="./LoginServlet">
                                Quay lại trang đăng nhập
                            </a>
                            <a href="./RegisterServlet">
                                Tạo tài khoản
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
