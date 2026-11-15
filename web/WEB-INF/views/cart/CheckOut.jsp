<%-- 
    Document   : CheckOut
    Created on : May 10, 2026, 9:08:43 PM
    Author     : pipo1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <link rel="icon" href="assets/img/icon.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/CSS/CheckOut.css">
    </head>
    <body>
        <%
            if (session == null || session.getAttribute("userRole") == null) {
                response.sendRedirect("./LoginServlet");
                return;
            }
        %>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>

        <main>
            <section class="banner">
                <div class="banner-content">
                    <h2>Thanh toán</h2>
                    <p>
                        <a href="./HomePageServlet">Trang chủ</a>
                        <span class="x-icon">●</span>
                        <a href="./Cart">Giỏ hàng</a>
                        <span class="x-icon">●</span>
                        <a href="./CheckOut">Thanh toán</a>
                    </p>
                </div>
            </section>
            <form action="CheckOut" method="post">
                <div class="checkout-wrapper">
                    <!-- LEFT -->
                    <div class="checkout-box">
                        <h2 class="section-title">Thông tin Đặt hoa / Nhận hoa</h2>
                        <div class="form-grid">
                            <input type="hidden" name="user_id" value="${user_id}">
                            <input type="text" name="customer_name" value="${username}" class="form-control" placeholder="Họ tên người đặt" value="${user}" required>
                            <input type="text" name="customer_phone" value="${phone}" class="form-control" placeholder="SĐT người đặt" required>
                            <input type="email" name="customer_email" value="${email}" class="form-control" placeholder="Email người đặt" required>
                            <input type="text" name="receiver_name" class="form-control" placeholder="Họ tên người nhận" required>
                            <input type="text" name="receiver_phone" class="form-control" placeholder="SĐT người nhận" required>
                        </div>
                        <div class="delivery-section">
                            <select class="form-select mb-3" id="deliveryType" name="delivery_type">
                                <option value="delivery">Gửi đến địa chỉ của tôi</option>
                                <option value="pickup">Nhận tại cửa hàng</option>
                            </select>
                            <div id="addressBox">
                                <input type="text" name="address" value="${address}" class="form-control mb-3" placeholder="Địa chỉ cụ thể">
                            </div>
                            <div class="form-grid">
                                <input type="date" name="receive_date" class="form-control">
                            </div>
                            <textarea name="note" class="form-control mt-3" placeholder="Để lại lời nhắn trong quà"></textarea>
                        </div>
                    </div>
                    <!-- RIGHT -->
                    <div class="order-box">
                        <h2 class="section-title">Đơn hàng của bạn</h2>
                        <div id="checkoutCartList">
                        </div>
                        <div class="coupon-box">
                            <input type="text" id="couponCode" placeholder="Coupon code">
                            <button type="button" id="applyCoupon">Áp dụng</button>
                        </div>
                        <div class="summary-box">
                            <div class="summary-row">
                                <span>Tạm tính</span>
                                <span id="subtotal">0 đ</span>
                            </div>
                            <div class="summary-row">
                                <span>Phí vận chuyển</span>
                                <span id="shipping">30,000 đ</span>
                            </div>
                            <div class="summary-row">
                                <span>Voucher giảm giá</span>
                                <span id="discount">0 đ</span>
                            </div>
                            <div class="summary-row fw-bold fs-5">
                                <span>Tổng cộng</span>
                                <span id="total">0 đ</span>
                            </div>
                        </div>
                        <div class="mt-4">
                            <label class="payment-method d-flex align-items-center gap-3">
                                <input type="radio" name="payment_method" value="full" checked>
                                <span>Chuyển khoản 100%</span>
                            </label>
                            <label class="payment-method d-flex align-items-center gap-3">
                                <input type="radio" name="payment_method" value="deposit">
                                <span>Đặt cọc 50% và thanh toán khi nhận hoa 50%</span>
                            </label>
                        </div>
                        <button class="place-order-btn">
                            Đặt
                        </button>
                    </div>
                </div>
            </form>
        </main>

        <jsp:include page="/WEB-INF/views/shared/chatbox.jsp"/>
        <jsp:include page="/WEB-INF/views/shared/footer.jsp"/>

        <div class="toast-container position-fixed top-0 end-0 p-3"
             id="toastContainer"
             style="z-index:9999;">
        </div>
        <c:if test="${not empty type}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {

                    showToast(
                            "${type}",
                            "Đặt đơn hàng",
                            "${message}"
                            );

                });
            </script>
        </c:if>
        <c:if test="${type == 'success'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {

                    const cartQty = document.querySelector(".cart-quantity");

                    if (cartQty) {
                        cartQty.innerText = 0;
                    }

                });
            </script>
        </c:if>
        <script src="assets/JS/CheckOut.js" defer></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
    </body>
</html>
