<%-- 
    Document   : header
    Created on : May 25, 2026, 9:18:06 AM
    Author     : pipo1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="assets/CSS/headnfoot.css">
    </head>
    <body>
        <header class="luxury-header">
            <!-- NavBar -->
            <nav class="navbar navbar-expand-lg luxury-navbar">
                <!-- LEFT : LOGO -->
                <a href="./HomePageServlet" class="brand-area">
                    <img src="assets/img/logo.jpg" class="brand-icon">

                    <div class="brand-text">
                        <h2>Fle<span>ur</span></h2>
                        <p>Luxury Flower Boutique</p>
                    </div>
                </a>
                <!-- RIGHT TOP ACTION -->
                <div class="top-action">
                    <form class="search-box" action="./SearchServlet" method="get">
                        <div class="search-box">
                            <input type="text" name="search" placeholder="Search flowers..." required/>
                            <button type="submit" class="search-btn">
                                <i class="bx bx-search"></i>
                            </button>
                            <span></span>
                        </div>
                    </form>
                    <%
                        String user = (String) session.getAttribute("userName");
                        if (user != null) {
                    %>
                    <span style="color: white">Welcome, <%= user%></span>
                    <%
                        }
                    %>
                    <div class="user-menu">
                        <i class="bx bx-user user-icon"></i>

                        <ul class="dropdown">
                            <a href="./ProfileServlet"><li>Trang thông tin</li></a>
                            <a href="./LoginServlet"><li>Đăng xuất</li></a>
                        </ul>
                    </div>
                    <div class="cart-menu cartOpenbtn">
                        <i class="bx bx-shopping-bag cart-icon"></i>

                        <span class="cart-quantity">
                            <c:choose>
                                <c:when test="${not empty sessionScope.cart}">
                                    ${sessionScope.cart.totalQuantity}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <i class="bx bx-menu menu-icon navOpen-btn"></i>
                </div>
            </nav>
            <!-- BOTTOM NAVIGATION -->
            <div class="bottom-nav">
                <ul class="menu-list">
                    <li class="menu-item">
                        <a href="CategoryServlet?id=1" class="nav-links">Bó Hoa</a>
                    </li>
                    <li class="menu-item">
                        <a href="CategoryServlet?id=5" class="nav-links">Giỏ Hoa</a>
                    </li>
                    <li class="menu-item">
                        <a href="CategoryServlet?id=9" class="nav-links">Bộ sưu tập</a>
                    </li>
                    <li class="menu-item">
                        <a href="CategoryServlet?id=15" class="nav-links">Hoa Dịp</a>
                    </li>
                    <li class="menu-item">
                        <a href="AboutServlet" class="nav-links">Về chúng tôi</a>
                    </li>
                    <li class="menu-item">
                        <a href="ContactServlet" class="nav-links">Liên hệ</a>
                    </li>
                </ul>
            </div>
            <!-- MobileMenu -->
            <div class="mobile-menu">
                <div class="mobile-header">
                    <a href="./HomePageServlet">
                        <i class="bx bx-leaf logo-icon"></i>
                        <h2 class="logo-text">Fle<span>ur</span></h2>
                    </a>
                    <i class="bx bx-x navClose-btn"></i>
                </div>
                <form class="mobile-search" action="./SearchServlet" method="get">
                    <input type="text" name="search" placeholder="Search flowers..." required/>
                    <button type="submit" class="search-btn">
                        <i class="bx bx-search"></i>
                    </button>
                </form>
                <ul class="mobile-list">
                    <li><a href="CategoryServlet?id=1">Bó hoa</a></li>
                    <li><a href="CategoryServlet?id=5">Giỏ hoa</a></li>
                    <li><a href="CategoryServlet?id=9">Bộ sưu tập</a></li>
                    <li><a href="CategoryServlet?id=15">Hoa Dịp</a></li>
                    <li><a href="AboutUsServlet">Về chúng tôi</a></li>
                    <li><a href="ContactServlet">Liên hệ</a></li>
                </ul>
            </div>
            <!-- CartMenu --> 
            <div class="cartTab">
                <div>
                    <h1>Giỏ hàng</h1>
                    <i class="bx bx-x cartClosebtn"></i>
                </div>
                <div class="listCart">
                </div>
                <div class="cartTotal">
                    <div class="line"></div>
                    Tổng: <span class="new" id="cartTotalPrice">0 đ</span>
                </div>
                <div class="btn">
                    <a href="Cart"><button class="CartPage" >GIỎ HÀNG</button></a>
                    <a href="CheckOut"><button class="CheckOut" >THANH TOÁN</button></a>
                </div>
            </div>
            <div class="overlay"></div>
        </header>      
        <script src="assets/JS/headnfoot.js" defer></script>
        <script src="assets/JS/Cart.js" defer></script>
    </body>
</html>
