<%-- 
    Document   : Category
    Created on : May 15, 2026, 8:32:59 AM
    Author     : pipo1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category</title>
        <!-- CSS -->
        <link rel="icon" href="assets/img/icon.jpg">
        <link rel="stylesheet" href="assets/CSS/Category.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>

        <main class="category-page">
            <!-- BANNER -->
            <section class="banner">
                <div class="banner-content">
                    <h2>Danh mục</h2>
                    <p>
                        <a href="./HomePageServlet">Trang chủ</a>
                        <span class="x-icon">●</span>
                        <a href="./CategoryServlet">Danh mục</a>
                    </p>
                </div>
            </section>
            <!-- CONTENT -->
            <section class="category-layout">
                <!-- FILTER -->
                <aside class="filter-sidebar">
                    <h2>Các Danh mục</h2>
                    <div class="category-list">
                        <a href="CategoryServlet?id=0" class="${currentCategory == 0 ? 'active' : ''}">
                            Tất cả sản phẩm
                        </a>
                        <c:forEach var="c" items="${categories}">
                            <a href="CategoryServlet?id=${c.getCategoryID()}" class="${currentCategory == c.getCategoryID() ? 'active' : ''}">
                                ${c.getCategoryName()}
                            </a>
                        </c:forEach>
                    </div>
                    <!-- PRICE -->
                    <div class="filter-box">
                        <h3>Giá</h3>
                        <div class="price-inputs">
                            <input type="number" id="minPrice" placeholder="Min" >
                            <input type="number" id="maxPrice" placeholder="Max">
                        </div>
                        <!-- PRICE RANGE -->
                        <div class="filter-price">
                            <h3>Giá</h3>
                            <div class="range-slider">
                                <div class="slider-track"></div>
                                <%
                                    String minParam = request.getParameter("min");
                                    String maxParam = request.getParameter("max");
                                    int minValue = 0;
                                    int maxValue = 5000000;
                                    try {
                                        if (minParam != null) {
                                            minValue = Integer.parseInt(minParam);
                                        }
                                        if (maxParam != null) {
                                            maxValue = Integer.parseInt(maxParam);
                                        }
                                    } catch (Exception e) {
                                        minValue = 0;
                                        maxValue = 5000000;
                                    }
                                %>
                                <input type="range" id="rangeMin" min="0" max="5000000" value="<%= minValue%>" step="10000">
                                <input type="range" id="rangeMax" min="0" max="5000000" value="<%= maxValue%>" step="10000">
                            </div>
                        </div>
                    </div>
                </aside>
                <!-- PRODUCTS -->
                <div class="products-section">
                    <!-- TOPBAR -->
                    <div class="products-topbar">
                        <h2>
                            Bộ sưu tập
                        </h2>
                        <select id="sortSelect">
                            <option value="default"
                                ${sort == 'default' ? 'selected' : ''}>Mặc định
                            </option>
                            <option value="az"
                                ${sort == 'az' ? 'selected' : ''}>A-Z
                            </option>
                            <option value="za"
                                ${sort == 'za' ? 'selected' : ''}>Z-A
                            </option>

                            <option value="low"
                                ${sort == 'low' ? 'selected' : ''}>Giá thấp đến cao
                            </option>

                            <option value="high"
                                ${sort == 'high' ? 'selected' : ''}>Giá cao đến thấp
                            </option>
                        </select>
                    </div>
                    <!-- GRID -->
                    <div class="product-grid">
                        <c:if test="${empty products}">
                            <p>Không tìm thấy sản phẩm</p>
                        </c:if>
                        <c:forEach var="p" items="${products}">
                            <div class="product-card">
                                <div class="product-img">
                                    <img src="assets/img/${p.img_path}">
                                    <c:if test="${p.discount_percent > 0}">
                                        <span class="discount">
                                            -${p.discount_percent}%
                                        </span>
                                    </c:if>
                                    <div class="overlay-icons">
                                        <a href="#" class="add-to-cart" data-id="${p.product_id}">
                                            <i class="bx bx-cart"></i>
                                        </a>
                                        <a href="productDetail?id=${p.product_id}">
                                            <i class="bx bx-link"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="product-info">
                                    <h4>
                                        ${p.product_name}
                                    </h4>
                                    <div class="price">
                                        <span class="new">
                                            <fmt:formatNumber value="${p.gia_sau}" type="number"/> đ
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <!-- PAGINATION -->
                    <div class="pagination">
                        <a href="?page=${currentPage - 1}&sort=${sort}">&lt;</a>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="active">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="?page=${i}&sort=${sort}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <a href="?page=${currentPage + 1}&sort=${sort}">&gt;</a>
                    </div>
                </div>
            </section>
        </main>

        <jsp:include page="/WEB-INF/views/shared/chatbox.jsp"/>
        <jsp:include page="/WEB-INF/views/shared/footer.jsp"/>
        <!-- Script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
        <script src="assets/JS/Category.js" defer></script>
    </body>
</html>
