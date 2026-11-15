<%-- 
    Document   : Cart
    Created on : May 7, 2026, 1:31:24 AM
    Author     : pipo1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Cart</title>
        <link rel="icon" href="assets/img/icon.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" href="assets/CSS/Cart.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>
                    
        <main>
            <section class="banner">
                <div class="banner-content">
                    <h2>Giỏ hàng</h2>
                    <p>
                        <a href="./HomePageServlet">Trang chủ</a>
                        <span class="x-icon">●</span>
                        <a href="./Cart">Giỏ hàng</a>
                    </p>
                </div>
            </section>
            <section class="cart-container">
                <div class="cart-table">
                    <div class="cart-header">
                        <div>Ảnh</div>
                        <div>Sản phẩm</div>
                        <div>Giá</div>
                        <div>Số lượng</div>
                        <div>Tổng</div>
                        <div>Xóa</div>
                    </div>
                    <div class="CartTab">
                    </div>
                </div>

                <div class="cart-summary">
                    <div class="coupon-box">
                        <input type="text" id="couponCode" placeholder="Coupon code">
                        <button id="applyCoupon">Áp dụng</button>
                    </div>
                    <h4 class="mb-4">Tổng giỏ hàng</h4>
                    <div class="summary-row">
                        <span>Tổng phụ</span>
                        <span id="subtotal">0 đ</span>
                    </div>
                    <div class="summary-row">
                        <span>Giảm giá</span>
                        <span id="discount">0 đ</span>
                    </div>
                    <div class="summary-row total">
                        <span>Tổng</span>
                        <span id="total">0 đ</span>
                    </div>
                    <button class="checkout-btn w-100 mt-3">
                        <a href="CheckOut">Tiến hành thanh toán</a>
                    </button>
                </div>
            </section>
        </main>
        <jsp:include page="/WEB-INF/views/shared/chatbox.jsp"/>
        <jsp:include page="/WEB-INF/views/shared/footer.jsp"/>
        
        <div class="toast-container position-fixed top-0 end-0 p-3"
             id="toastContainer"
             style="z-index:9999;">
        </div>
        <!-- Script -->
        <script src="assets/JS/CartPage.js" defer></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
    </body>
</html>
