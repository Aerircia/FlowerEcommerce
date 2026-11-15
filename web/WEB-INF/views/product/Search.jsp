<%-- 
    Document   : Search
    Created on : May 17, 2026, 7:33:51 PM
    Author     : pipo1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kết quả tìm kiếm</title>
        <link rel="icon" href="assets/img/icon.jpg">
        <link rel="stylesheet" href="assets/CSS/Search.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>

        <main class="search-page">
            <!-- BANNER -->
            <section class="banner">
                <div class="banner-content">
                    <h2>Kết quả tìm kiếm</h2>
                    <p>
                        <a href="./HomePageServlet">Trang chủ</a>
                        <span class="x-icon">●</span>
                        <a href="./Search">Tìm kiếm</a>
                    </p>
                </div>
            </section>
            <!-- SEARCH SECTION -->
            <section class="search-section container">
                <!-- RESULT TEXT -->
                <div class="result-text">
                    Kết quả được truy xuất từ
                    <span>"${search}"</span>
                </div>
                <!-- FILTER FORM -->
                <form class="search-filter-form" action="SearchServlet" method="get">
                    <!-- CATEGORY -->
                    <select name="categoryId" onchange="this.form.submit()">
                        <option value="0">
                            Tất cả các danh mục
                        </option>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.categoryID}"
                                    ${selectedCategory == c.categoryID ? "selected" : ""}>
                                ${c.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                    <!-- SEARCH -->
                    <div class="search-bar">
                        <input type="text" name="search" placeholder="Search flowers..." value="${search}">
                        <button type="submit">
                            <i class='bx bx-search'></i>
                        </button>
                    </div>
                </form>
                <!-- PRODUCT GRID -->
                <div class="product-grid">
                    <c:forEach var="p" items="${products}">
                        <div class="product-card">
                            <!-- IMAGE -->
                            <div class="product-img">
                                <img src="assets/img/${p.img_path}" alt="">
                                <!-- DISCOUNT -->
                                <c:if test="${p.discount_percent > 0}">
                                    <span class="discount">
                                        -${p.discount_percent}%
                                    </span>
                                </c:if>
                                <!-- OVERLAY -->
                                <div class="overlay-icons">
                                    <a href="#">
                                        <i class='bx bx-cart'></i>
                                    </a>
                                    <a href="productDetail?id=${p.product_id}">
                                        <i class='bx bx-link'></i>
                                    </a>
                                </div>
                            </div>
                            <!-- INFO -->
                            <div class="product-info">
                                <h3>
                                    ${p.product_name}
                                </h3>
                                <p>
                                    ${p.description}
                                </p>
                                <!-- PRICE -->
                                <div class="price">
                                    <c:choose>
                                        <c:when test="${p.discount_percent > 0}">
                                            <span class="new">
                                                <fmt:formatNumber value="${p.gia_sau}" type="number"/> đ
                                            </span>
                                            <span class="old">
                                                <fmt:formatNumber value="${p.price}" type="number"/> đ
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="new">
                                                <fmt:formatNumber value="${p.price}" type="number"/> đ
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- EMPTY -->
                <c:if test="${empty products}">
                    <div class="empty-product">
                        <h3>Không tìm thấy sản phẩm</h3>
                        <p>
                            Thử từ khóa khác
                        </p>
                    </div>
                </c:if>
                <!-- PAGINATION -->
                <div class="pagination-area">
                    <!-- PREV -->
                    <c:if test="${currentPage > 1}">
                        <a href="SearchServlet?search=${search}&categoryId=${selectedCategory}&page=${currentPage - 1}">
                            <<
                        </a>
                    </c:if>
                    <!-- PAGE -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="SearchServlet?search=${search}&categoryId=${selectedCategory}&page=${i}"
                           class="${i == currentPage ? 'active-page' : ''}">
                            ${i}
                        </a>
                    </c:forEach>
                    <!-- NEXT -->
                    <c:if test="${currentPage < totalPages}">
                        <a href="SearchServlet?search=${search}&categoryId=${selectedCategory}&page=${currentPage + 1}">
                            >>
                        </a>
                    </c:if>
                </div>
            </section>
        </main>
        
        <jsp:include page="/WEB-INF/views/shared/chatbox.jsp"/>
        <jsp:include page="/WEB-INF/views/shared/footer.jsp"/>
        <!-- Script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
    </body>
</html>
