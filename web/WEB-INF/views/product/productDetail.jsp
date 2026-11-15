<%-- 
    Document   : page2
    Created on : Apr 3, 2026, 8:25:51 PM
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
        <title>Fleur - ${product.product_name}</title>
        <link rel="icon" href="assets/img/icon.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/CSS/productDetail.css">
    </head>

    <body>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>

        <main>
            <!-- Banner -->
            <section class="banner">
                <div class="banner-content">
                    <h2>${product.product_name}</h2>
                    <p>
                        <a href="./ProductServlet">Home</a>
                        <c:forEach var="c" items="${categories}" varStatus="s">
                            <span class="x-icon">●</span>
                            <a href="CategoryServlet?id=${c.getCategoryID()}">
                                ${c.getCategoryName()}
                            </a>
                        </c:forEach>
                    </p>
                </div>
            </section>
            <section>
                <div class="product-detail">
                    <!-- TOP -->
                    <div class="product-main">
                        <!-- LEFT: gallery -->
                        <div class="product-gallery">
                            <div class="thumbs">
                            </div>
                            <div class="main-image">
                                <img src="assets/img/${product.img_path}" />
                            </div>
                        </div>
                        <!-- RIGHT: info -->
                        <div class="product-info">
                            <h1>${product.product_name}</h1>
                            <div class="price">
                                <c:choose>
                                    <c:when test="${product.price != product.gia_sau}">
                                        <span class="new">
                                            <fmt:formatNumber value="${product.gia_sau}" type="number"/> đ
                                        </span>
                                        <span class="old">
                                            <fmt:formatNumber value="${product.price}" type="number"/> đ
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="new">
                                            <fmt:formatNumber value="${product.price}" type="number"/> đ
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="product-action">
                                <div class="quantity-box">
                                    <button type="button" class="qty-btn minus">-</button>
                                    <input type="text" value="1" id="quantity">
                                    <button type="button" class="qty-btn plus">+</button>
                                </div>
                                <!-- Add to cart -->
                                <a href="#" class="add-to-cart" data-id="${product.product_id}" data-detail="true">
                                    Thêm vào giỏ
                                </a>
                            </div>
                            <p>SKU: ${product.product_id}</p>
                            <p>Đã bán: ${product.sold}</p>
                            <p>
                                Categories:
                                <c:forEach var="c" items="${categories}" varStatus="s">
                                    <a href="CategoryServlet?id=${c.getCategoryID()}">
                                        ${c.getCategoryName()}
                                    </a>
                                    <c:if test="${!s.last}">, </c:if>
                                </c:forEach>
                            </p>
                        </div>
                    </div>
                    <!-- BOTTOM -->
                    <div class="product-tabs">
                        <!-- LEFT: menu -->
                        <div class="tab-menu">
                            <button class="tab-btn active" data-tab="desc">MÔ TẢ SẢN PHẨM</button>
                            <button class="tab-btn" data-tab="info">THÔNG TIN KHÁC</button>
                            <button class="tab-btn" data-tab="review">Đánh giá</button>
                        </div>
                        <!-- RIGHT: content -->
                        <div class="tab-content">
                            <div class="tab-panel active" id="desc">
                                ${product.description}
                            </div>
                            <div id="info" class="tab-panel">
                                <div class="info-table">
                                    <div class="row">
                                        <div class="label">Tên sản phẩm</div>
                                        <div class="value">${product.product_name}</div>
                                    </div>
                                    <div class="row">
                                        <div class="label">Tag sản phẩm</div>
                                        <div class="value">
                                            <c:forEach var="c" items="${categories}" varStatus="s">
                                                <a href="CategoryServlet?id=${c.getCategoryID()}">
                                                    ${c.getCategoryName()}
                                                </a>
                                                <c:if test="${!s.last}">, </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="label">Độ bền</div>
                                        <div class="value">
                                            Độ bền hoa tươi rơi vào từ 3-7 ngày...
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="label">Cách chăm sóc</div>
                                        <div class="value">
                                            Cắm hoa vào nước và thay nước thường xuyên...
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="label">Giao hàng</div>
                                        <div class="value">
                                            Chuẩn bị từ 2-3h sau khi chốt đơn...
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-panel" id="review">
                                <!-- Phần 1: Form nhập đánh giá -->
                                <div class="review-form">
                                    <h3>Viết đánh giá của bạn</h3>
                                    <form action="ReviewServlet" method="post">
                                        <input type="hidden" name="product_id" value="${product.product_id}" />
                                        <label for="rating">Đánh giá (1-5 sao):</label>
                                        <div class="star-rating">
                                            <input type="hidden" name="rating" id="rating" value="0" />
                                            <span class="star" data-value="1">&#9733;</span>
                                            <span class="star" data-value="2">&#9733;</span>
                                            <span class="star" data-value="3">&#9733;</span>
                                            <span class="star" data-value="4">&#9733;</span>
                                            <span class="star" data-value="5">&#9733;</span>
                                        </div>
                                        <label for="comment">Nhận xét:</label>
                                        <textarea name="comment" id="comment" rows="5"></textarea>
                                        <button type="submit">Gửi đánh giá</button>
                                    </form>
                                </div>
                                <!-- Phần hiển thị danh sách review -->
                                <div class="review-list">
                                    <h3>Đánh giá sản phẩm</h3>
                                    <!-- Nếu chưa có review -->
                                    <c:if test="${empty reviews}">
                                        <p>Chưa có đánh giá nào.</p>
                                    </c:if>
                                    <!-- Hiển thị review -->
                                    <c:forEach var="review" items="${reviews}">
                                        <div class="review-card">
                                            <div class="review-header">
                                                <!-- Username -->
                                                <b>${review.username}</b>

                                                <!-- Rating -->
                                                <span class="stars">
                                                    ${review.rating} &#9733
                                                </span>
                                            </div>
                                            <!-- Comment -->
                                            <p class="comment">
                                                ${review.comment}
                                            </p>
                                            <!-- Date -->
                                            <span class="date">
                                                <fmt:formatDate
                                                    value="${review.review_date}"
                                                    pattern="dd/MM/yyyy HH:mm"/>
                                            </span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
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
                            "${sessionScope.title}",
                            "${sessionScope.message}"
                            );
                });
            </script>
            <c:remove var="type" scope="session"/>
            <c:remove var="title" scope="session"/>
            <c:remove var="message" scope="session"/>
        </c:if>
        <script src="assets/JS/productDetail.js" defer></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
    </body>
</html>
