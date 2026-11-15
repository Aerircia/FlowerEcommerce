<%-- 
    Document   : UserProfile
    Created on : May 12, 2026, 12:55:32 AM
    Author     : pipo1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport">
        <title>User</title>
        <link rel="icon" href="assets/img/icon.jpg">
        <link rel="stylesheet" href="assets/CSS/UserProfile.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>

        <main class="profile-page">
            <div class="profile-container">
                <!-- SIDEBAR -->
                <aside class="profile-sidebar">
                    <h2>Tài khoản của tôi</h2>
                    <button class="profile-tab active" data-tab="user-info">
                        <i class="bx bx-user"></i>
                        Thông tin người dùng
                    </button>
                    <button class="profile-tab" data-tab="order-history">
                        <i class="bx bx-package"></i>
                        Lịch sử đơn hàng
                    </button>
                </aside>
                <!-- CONTENT -->
                <section class="profile-content">
                    <!-- USER INFO -->
                    <div class="tab-panel active" id="user-info">
                        <div class="profile-card">
                            <div class="profile-header">
                                <!-- RIGHT -->
                                <div class="avatar-section">
                                    <img src="assets/img/${account.avatar}" alt="avatar">
                                    <form action="./UserServlet" method="post" >
                                        <input type="hidden" name="action" value="updateAvatar">
                                        <input type="hidden" name="id" value="${account.userID}">
                                        <input type="file" name="avatar" value="${account.avatar}">
                                        <button type="submit">
                                            Tải lên ảnh đại diện
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <!-- USER FORM -->
                            <form action="./UserServlet" method="post">
                                <input type="hidden" name="action" value="updateProfile">
                                <input type="hidden" name="id" value="${account.userID}">
                                <div class="profile-grid">
                                    <div class="form-group">
                                        <label>Tên người dùng</label>
                                        <input type="text" name="username" value="${account.username}">
                                    </div>
                                    <div class="form-group">
                                        <label>Biệt danh</label>
                                        <input type="text" name="nickname"value="${account.nickname}">
                                    </div>
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input type="email" name="email" value="${account.email}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>SĐT</label>
                                        <input type="text" name="phone" value="${account.phone}">
                                    </div>
                                    <div class="form-group full-width">
                                        <label>Địa chỉ</label>
                                        <input type="text" name="address" value="${account.address}">
                                    </div>
                                </div>
                                <button class="save-btn">
                                    LƯU THÔNG TIN
                                </button>
                            </form>
                        </div>
                        <!-- PASSWORD -->
                        <div class="password-card">
                            <h3>Thay đổi mật khẩu</h3>
                            <form action="./UserServlet" method="post">
                                <input type="hidden" name="action" value="updatePassword">
                                <input type="hidden" name="id" value="${account.userID}">
                                <div class="profile-grid">
                                    <div class="form-group">
                                        <label>Mật khẩu hiện tại</label>
                                        <input type="password" name="oldPassword" placeholder="********">
                                    </div>
                                    <div class="form-group">
                                        <label>Mật khẩu mới</label>
                                        <input type="password" name="newPassword" placeholder="********">
                                    </div>
                                    <div class="form-group full-width">
                                        <label>Xác nhận mật khẩu</label>
                                        <input type="password" name="confirmPassword" placeholder="********">
                                    </div>
                                </div>
                                <button class="save-btn">
                                    THAY ĐỔI MẬT KHẨU
                                </button>
                            </form>
                        </div>
                    </div>
                    <!-- ORDER HISTORY -->
                    <div class="tab-panel" id="order-history">
                        <div class="order-table-wrapper">
                            <table class="order-table">
                                <thead>
                                    <tr>
                                        <th>Người đặt</th>
                                        <th>Người nhận</th>
                                        <th>SĐT</th>
                                        <th>Email</th>
                                        <th>Địa chỉ</th>
                                        <th>Ngày nhận</th>
                                        <th>Tổng</th>
                                        <th>Trạng thái</th>
                                        <th>Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="o" items="${orders}">
                                        <tr>
                                            <td>${o.buyer_name}</td>
                                            <td>${o.receiver_name}</td>
                                            <td>${o.receiver_phone}</td>
                                            <td>${o.buyer_email}</td>
                                            <td>${o.shipping_address}</td>
                                            <td>${o.delivery_date}</td>
                                            <td>
                                                <fmt:formatNumber value="${o.total}" type="number" /> đ
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${o.status == 'completed'}">
                                                        <span class="status-completed">
                                                            Hoàn thành
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-pending">
                                                            Chưa hoàn thành
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${o.status == 'completed'}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="edit-order-btn" onclick="openOrderEdit('${o.order_id}', '${o.buyer_name}', '${o.receiver_name}', '${o.buyer_phone}', '${o.receiver_phone}', '${o.buyer_email}', '${o.delivery_date}', '${o.shipping_address}', '${o.note}')">
                                                            Sửa
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div id="editOrderModal" class="modal">
                            <div class="modal-content">
                                <i class="bx bx-x modal-close" onclick="closeModal('editOrderModal')"></i>
                                <h3>Chỉnh sửa đơn hàng</h3>
                                <form action="./UserServlet" method="post">
                                    <input type="hidden"
                                           name="action"
                                           value="updateOrder">
                                    <input type="hidden"
                                           id="order_id"
                                           name="orderId">
                                    <div class="profile-grid">
                                        <div class="form-group">
                                            <label>Tên Người đặt</label>
                                            <input type="text"
                                                   id="buyer_name"
                                                   name="buyer_name">
                                        </div>
                                        <div class="form-group">
                                            <label>Tên Người nhận</label>
                                            <input type="text"
                                                   id="receiver_name"
                                                   name="receiver_name">
                                        </div>
                                        <div class="form-group">
                                            <label>SĐT Người đặt</label>
                                            <input type="text"
                                                   id="buyer_phone"
                                                   name="buyer_phone">
                                        </div>
                                        <div class="form-group">
                                            <label>SĐT Người nhận</label>
                                            <input type="text"
                                                   id="receiver_phone"
                                                   name="receiver_phone">
                                        </div>
                                        <div class="form-group">
                                            <label>Email</label>
                                            <input type="email"
                                                   id="buyer_email"
                                                   name="buyer_email">
                                        </div>
                                        <div class="form-group">
                                            <label>Ngày gửi</label>
                                            <input type="date"
                                                   id="delivery_date"
                                                   name="delivery_date">
                                        </div>
                                        <div class="form-group full-width">
                                            <label>Địa chỉ giao hàng</label>
                                            <select class="form-select mb-3" id="deliveryType" name="delivery_type">
                                                <option value="delivery">Gửi đến địa chỉ của tôi</option>
                                                <option value="pickup">Nhận tại cửa hàng</option>
                                            </select>
                                            <div id="addressBox">
                                                <input type="text" id="shipping_address" value="" name="shipping_address" class="form-control mb-3" placeholder="Địa chỉ cụ thể">
                                            </div>
                                        </div>
                                        <div class="form-group full-width">
                                            <label>Note</label>
                                            <textarea id="note" name="note"></textarea>
                                        </div>
                                    </div>
                                    <button class="save-btn">
                                        LƯU
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </main>
        <jsp:include page="/WEB-INF/views/shared/chatbox.jsp"/>
        <jsp:include page="/WEB-INF/views/shared/footer.jsp"/>
        <div class="toast-container position-fixed top-0 end-0 p-3"
             id="toastContainer"
             style="z-index:9999;">
        </div>
        <c:if test="${not empty sessionScope.type}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {

                    showToast(
                            "${sessionScope.type}",
                            "Đổi mật khẩu",
                            "${sessionScope.message}"
                            );

                });
            </script>

            <c:remove var="type" scope="session"/>
            <c:remove var="message" scope="session"/>
        </c:if>
        <!-- Script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
        <script src="assets/JS/UserProfile.js" defer></script>
    </body>
</html>
