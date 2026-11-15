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
            .otp-card{
                min-height: 680px;
            }
            .otp-description{
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
                .otp-card{
                    grid-template-columns: 1fr;
                }
            }
            @media(max-width: 576px){
                .otp-description{
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
            <div class="auth-card otp-card">
                <!-- LEFT IMAGE -->
                <div class="auth-image">
                    <div class="overlay"></div>
                    <div class="image-content">
                        <h2>Xác nhận Email</h2>
                        <p>
                            Chúng tôi đã gửi mã OTP bảo mật đến email bạn đã đăng ký.
                            Nhập mã xác minh để tiếp tục đặt lại mật khẩu.
                        </p>
                    </div>
                </div>
                <!-- RIGHT FORM -->
                <div class="form-container otp-form">
                    <form action="./VerifyOTP" method="post">
                        <span class="auth-subtitle">
                            XÁC MINH BẢO MẬT
                        </span>
                        <h1>Verify OTP</h1>
                        <p class="otp-description">
                            Vui lòng nhập mật khẩu dùng một lần đã được gửi đến địa chỉ email của bạn.
                        </p>
                        <!-- OTP INPUT -->
                        <div class="input-group">
                            <i class='bx bx-shield-quarter'></i>
                            <input
                                type="text"
                                name="enteredotp"
                                placeholder="Enter OTP Code"
                                required
                                >
                        </div>
                        <% String error = (String) request.getAttribute("msg2");

                            if (error != null) {
                        %>
                        <div class="error-box">
                            <i class='bx bx-error-circle'></i>
                            <span><%= error%></span>
                        </div>
                        <% }%>
                        <!-- BUTTON -->
                        <button type="submit" class="auth-btn">
                            XÁC MINH MÃ OTP
                        </button>
                        <!-- BOTTOM -->
                        <div class="bottom-container">
                            <a href="./ForgotPassword">
                                Quay Lại
                            </a>
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
        <script src="assets/JS/loginregister.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
    </body>
</html>