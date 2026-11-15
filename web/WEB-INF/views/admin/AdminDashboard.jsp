<%-- 
    Document   : AdminDashboard
    Created on : Apr 14, 2026, 11:45:02 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%// chưa login
    if (session == null || session.getAttribute("userRole") == null) {
        response.sendRedirect("./LoginServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <!-- CSS -->
        <link rel="icon" href="assets/img/icon.jpg">
        <link rel="stylesheet" href="assets/CSS/AdminDashboard.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    </head>

    <body>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>
        
        <div class="admin_dashboard_wrapper">
            <aside class="admin_dashboard_function">
                <h2>Function</h2>
                <ul>
                    <li><a href="AdminServlet?section=dashboardHome" data-section="dashboardHome" >Trang chủ Admin</a></li>
                    <li><a href="AdminServlet?section=productSection" data-section="productSection" >Sản phẩm</a></li>
                    <li><a href="AdminServlet?section=roleSection" data-section="roleSection">Tài khoản</a></li>
                    <li><a href="AdminServlet?section=orderSection" data-section="orderSection">Đơn hàng</a></li>
                    <li><a href="AdminServlet?section=contactSection" data-section="contactSection">Liên hệ</a></li>
                </ul>
            </aside>

            <section class="admin_dashboard_content">
                <div id="dashboardHome" class="admin_dashboard_section" style="display:block;">
                    <h2 class="dashboard-title">
                        Tổng quan
                    </h2>
                    <div class="dashboard-summary">
                        <div class="dashboard-card">
                            <div class="card-icon">
                                <i class="fa-solid fa-box"></i>
                            </div>
                            <div class="card-info">
                                <h3>${totalProducts}</h3>
                                <p>Tổng sản phẩm</p>
                            </div>
                        </div>
                        <div class="dashboard-card">
                            <div class="card-icon">
                                <i class="fa-solid fa-users"></i>
                            </div>
                            <div class="card-info">
                                <h3>${totalUsers}</h3>
                                <p>Total Users</p>
                            </div>
                        </div>
                        <div class="dashboard-card">
                            <div class="card-icon">
                                <i class="fa-solid fa-cart-shopping"></i>
                            </div>
                            <div class="card-info">
                                <h3>${totalOrders}</h3>
                                <p>Tổng số người dùng</p>
                            </div>
                        </div>
                        <div class="dashboard-card">
                            <div class="card-icon">
                                <i class="fa-solid fa-dollar-sign"></i>
                            </div>
                            <div class="card-info">
                                <h3>
                                    <fmt:formatNumber value="${totalRevenue}" type="number"/> đ
                                </h3>
                                <p>Tổng doanh thu</p>
                            </div>
                        </div>
                    </div>
                    <div class="dashboard-chart-grid">
                        <div class="chart-box">
                            <div class="chart-header">
                                <h3>Doanh thu theo tháng</h3>
                            </div>
                            <div><canvas id="revenueChart"></canvas></div>
                        </div>
                    </div>  
                </div>
                <div id="productSection" class="admin_dashboard_section" style="display:none;">
                    <h2>Sản phẩm</h2>
                    <div class="product-top-bar">
                        <div style="margin-bottom:12px;">
                            <button class="admin-action-button add"onclick="openAdd()">Thêm sản phẩm</button>
                        </div>
                        <form action="./ProductServlet" method="get">
                            <input type="hidden" name="section" value="productSection">
                            <input type="hidden" name="action" value="filterpd">
                            <div class="filter-box">
                                <i class="fa-solid fa-filter"></i>
                                <select name="categoryId" onchange="this.form.submit()">
                                    <option value="">-- Tất cả danh mục --</option>
                                    <c:forEach var="c" items="${allCategories}">
                                        <option value="${c.categoryID}"
                                                ${param.categoryId == c.categoryID ? "selected" : ""}>
                                            ${c.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div id="addModal" class="modal">
                        <div class="modal-content">
                            <span class="close" onclick="closeModal('addModal')">&times;</span>
                            <h3>Thêm sản phẩm</h3>
                            <form action="./ProductServlet" method="post">
                                <%request.setCharacterEncoding("UTF-8");%>
                                <input type="hidden" name="action" value="addProduct">
                                <div class="form-group">
                                    <label>Tên sản phẩm</label>
                                    <input type="text" name="ten_sp" placeholder="Product Name" required>
                                </div>
                                <div class="form-group">
                                    <label>Giá gốc</label>
                                    <input type="number" name="gia_goc" placeholder="Price" required>
                                </div>
                                <div class="form-group">
                                    <label>Mô tả</label>
                                    <textarea type="text" name="mo_ta" placeholder="Description" oninput="autoResize(this)"required></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Số lượng bán</label>
                                    <input type="text" name="sold" placeholder="Sold" required>
                                </div>
                                <div class="form-group">
                                    <label>Giảm giá</label>
                                    <input type="number" name="discount_percent" placeholder="Discount" required>
                                </div>
                                <div class="form-group">
                                    <label>Ảnh</label>
                                    <input type="file" name="img_path" placeholder="Image URL">
                                </div>
                                <label>Categories:</label><br>
                                <div class="category-box">
                                    <c:forEach var="c" items="${allCategories}">
                                        <input type="checkbox" name="categoryIds" value="${c.categoryID} ${param.categoryId == c.categoryID ? "selected" : ""}">
                                        ${c.categoryName}<br>
                                    </c:forEach>
                                </div>
                                <br><br>
                                <button type="submit">Thêm sản phẩm</button>
                            </form>
                        </div>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th>Mã Sản Phẩm</th>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Danh mục</th>
                                <th>Giá</th>
                                <th>Mô tả</th>
                                <th>Số lượng bán</th>
                                <th>Giảm giá%</th>
                                <th>Chức năng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td>${p.product_id}</td>
                                    <td><img src="assets/img/${p.img_path}" alt="${p.product_name}"></td>
                                    <td>${p.product_name}</td>
                                    <td style="width: 150px">
                                        <c:forEach var="c" items="${p.categories}">
                                            ${c.categoryName}<br>
                                        </c:forEach>
                                    </td>
                                    <td>${p.price}</td>
                                    <td>${p.description}</td>
                                    <td>${p.sold}</td>
                                    <td>${p.discount_percent}</td>
                                    <c:set var="catIds" value="" />
                                    <c:forEach var="c" items="${p.categories}">
                                        <c:set var="catIds" value="${catIds}${c.categoryID}," />
                                    </c:forEach>
                                    <td>
                                        <button class="admin-action-button edit" onclick="openEdit('${p.product_id}', '${p.product_name}', '${p.price}', '${p.sold}', '${p.description}', '${p.img_path}', '${p.discount_percent}', '${catIds}')">Sửa</button>
                                        <a class="admin-action-button delete" href="./ProductServlet?action=deleteProduct&id=${p.product_id}">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id="editModal" class="modal">
                        <div class="modal-content">
                            <span class="close" onclick="closeModal('editModal')">&times;</span>
                            <h3>Sửa sản phẩm</h3>
                            <form action="./ProductServlet" method="post">
                                <%request.setCharacterEncoding("UTF-8");%>
                                <input type="hidden" name="action" value="editProduct">
                                <input type="hidden" id="edit_id" name="ma_sp" >
                                <div class="form-group">
                                    <label>Tên sản phẩm</label>
                                    <input type="text" id="edit_name" name="ten_sp">
                                </div>
                                <div class="form-group">
                                    <label>Giá bán</label>
                                    <input type="number" id="edit_price" name="gia_goc">
                                </div>
                                <div class="form-group">
                                    <label>Mô tả</label>
                                    <textarea id="edit_desc" name="mo_ta" oninput="autoResize(this)"></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Số lượng</label>
                                    <input type="text" id="edit_sold" name="sold" >
                                </div>
                                <div class="form-group">
                                    <label>Ảnh</label>
                                    <input type="text" id="edit_img" name="img_path">
                                </div>
                                <div class="form-group">
                                    <label>Giảm giá</label>
                                    <input type="number" id="edit_dis" name="discount_percent" >
                                </div>
                                <div>
                                    <label>Danh mục:</label><br>
                                    <div class="category-box">
                                        <c:forEach var="c" items="${allCategories}">
                                            <input type="checkbox"
                                                   name="categoryIds"
                                                   value="${c.categoryID}"
                                                   class="edit-category">
                                            ${c.categoryName}<br>
                                        </c:forEach>
                                    </div>
                                </div>
                                <br><br>
                                <button type="submit">Cập nhật</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div id="roleSection" class="admin_dashboard_section" style="display:none;">
                    <h2>Tài Khoản</h2>
                    <div class="product-top-bar">
                        <div style="margin-bottom:12px;">
                            <button class="admin-action-button add"onclick="openAddRoleModal()">Thêm tài khoản</button>
                        </div>
                        <form action="./AccountServlet" method="get">
                            <input type="hidden" name="section" value="roleSection">
                            <input type="hidden" name="action" value="filter">
                            <div class="filter-box">
                                <i class="fa-solid fa-filter"></i>
                                <select name="role" onchange="this.form.submit()">
                                    <option value="">-- Tất cả vai trò --</option>
                                    <option value="admin" ${param.role == 'admin' ? "selected" : ""}>
                                        Admin
                                    </option>
                                    <option value="user" ${param.role == 'user' ? "selected" : ""}>
                                        User
                                    </option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div id="addRoleModal" class="modal">
                        <div class="modal-content">
                            <span class="close" onclick="closeAddRoleModal()"> &times; </span>

                            <h2>Thêm tài khoản</h2>
                            <form action="./AccountServlet" method="post">
                                <input type="hidden" name="action" value="addAccount">
                                <div class="form-group">
                                    <label>Ảnh đại diện</label>
                                    <input type="text" name="avatar" required>
                                </div>
                                <div class="form-group">
                                    <label>Tên đăng nhập</label>
                                    <input type="text" name="username" required>
                                </div>
                                <div class="form-group">
                                    <label>Tên tài khoản</label>
                                    <input type="text" name="nickname" required>
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" name="email" required>
                                </div>
                                <div class="form-group">
                                    <label>Số điện thoại</label>
                                    <input type="number" name="phone" required>
                                </div>
                                <div class="form-group">
                                    <label>Mật khẩu</label>
                                    <input type="text" name="password" required>
                                </div>
                                <div class="form-group">
                                    <label>Địa chỉ</label>
                                    <input type="text" name="address" required>
                                </div>
                                <label>Vai trò</label>
                                <select name="role">
                                    <option value="admin">Admin</option>
                                    <option value="user">User</option>
                                </select><br>
                                <button type="submit">
                                    Thêm
                                </button>
                            </form>
                        </div>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Avatar</th>
                                <th>Tên tài khoản</th>
                                <th>Biệt danh</th>
                                <th>Email</th>
                                <th>SĐT</th>
                                <th>Mật khẩu</th>
                                <th>Địa chỉ</th>
                                <th>Vai trò</th>
                                <th>Chức năng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="acc" items="${accounts}">
                                <tr>
                                    <td>${acc.userID}</td>
                                    <td><img src="assets/img/${acc.avatar}" alt=""></td>
                                    <td>${acc.username}</td>
                                    <td>${acc.nickname}</td>
                                    <td>${acc.email}</td>
                                    <td>${acc.phone}</td>
                                    <td></td>
                                    <td>${acc.address}</td>
                                    <td>${acc.role}</td>
                                    <td>
                                        <button class="admin-action-button edit" onclick="openEditRole('${acc.userID}', '${acc.avatar}', '${acc.username}', '${acc.nickname}', '${acc.email}', '${acc.phone}', '${acc.password}', '${acc.address}', '${acc.role}')">
                                            Sửa
                                        </button>
                                        <a class="admin-action-button delete"href="./AccountServlet?action=deleteAccount&id=${acc.userID}">Xóa </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty accounts}">
                                <tr><td colspan="2">Không có tài khoản admin/user trong hệ thống.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                    <div id="editRoleModal" class="modal">
                        <div class="modal-content">
                            <span class="close"onclick="closeEditRoleModal()">&times;</span>
                            <h2>Sửa tài khoản</h2>
                            <form action="./AccountServlet" method="post">
                                <input type="hidden" name="action" value="editAccount">
                                <input type="hidden" id="edit_idacc" name="idacc">
                                <div class="form-group">
                                    <label>Ảnh đại diện</label>
                                    <input type="text" id="edit_avatar" name="avatar">
                                </div>
                                <div class="form-group">
                                    <label>Tên đăng nhập</label>
                                    <input type="text" id="edit_username" name="username" required>
                                </div>
                                <div class="form-group">
                                    <label>Tên tài khoản</label>
                                    <input type="text" id="edit_nickname" name="nickname" required>
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="text" id="edit_email" name="email" required>
                                </div>
                                <div class="form-group">
                                    <label>Số điện thoại</label>
                                    <input type="text" id="edit_phone" name="phone" required>
                                </div>
                                <div class="form-group">
                                    <label>Mật Khẩu</label>
                                    <input type="text" id="edit_password" name="password" required>
                                </div>
                                <div class="form-group">
                                    <label>Địa chỉ</label>
                                    <input type="text" id="edit_address" name="address" required>
                                </div>
                                <div class="form-group">
                                    <label>Vai trò</label>
                                    <select id="edit_role"name="role">
                                        <option value="admin">Admin</option>
                                        <option value="user">User</option>
                                    </select>
                                </div>
                                <button type="submit">
                                    Lưu
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div id="orderSection" class="admin_dashboard_section" style="display:none;">
                    <h2>Đơn hàng</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người mua</th>
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
                            <c:forEach var="o"items="${orders}">
                                <tr>
                                    <td>${o.order_id}</td>
                                    <td>${o.buyer_name}</td>
                                    <td>${o.receiver_name}</td>
                                    <td>${o.receiver_phone}</td>
                                    <td>${o.buyer_email}</td>
                                    <td>${o.shipping_address}</td>
                                    <td>${o.delivery_date}</td>
                                    <td>
                                        <fmt:formatNumber value="${o.total}" type="number"/> đ
                                    </td>
                                    <td>
                                        <c:if test="${o.status != 'completed'}">
                                            <button
                                                class="admin-action-button complete"
                                                onclick="openCompleteModal('${o.order_id}')">
                                                Hoàn thành
                                            </button>
                                        </c:if>
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
                                        <a class="admin-action-button delete"href="./OrderServlet?action=deleteOrder&id=${o.order_id}">
                                            Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="9">
                                        Không có đơn hàng nào.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <div id="completeOrderModal"
                         class="modal">
                        <div class="modal-content small-modal">
                            <span class="close"
                                  onclick="closeCompleteModal()">
                                &times;
                            </span>
                            <h3>Xác nhận đơn hàng</h3>
                            <p>
                                Bạn có chắc muốn hoàn thành đơn hàng này?
                            </p>
                            <form action="./OrderServlet" method="post">
                                <input type="hidden"
                                       name="action"
                                       value="completeOrder">
                                <input type="hidden"
                                       id="complete_order_id"
                                       name="order_id">
                                <div class="confirm-buttons">
                                    <button type="submit"
                                            class="confirm-btn">
                                        OK
                                    </button>
                                    <button type="button"
                                            class="cancel-btn"
                                            onclick="closeCompleteModal()">
                                        Hủy
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div id="contactSection" class="admin_dashboard_section" style="display:none;">
                    <h2>Liên hệ</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Tên</th>
                                <th>SĐT</th>
                                <th>Email</th>
                                <th>Tin nhắn</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${contactList}" var="c">
                                <tr>
                                    <td>${c.name}</td>
                                    <td>${c.phone}</td>
                                    <td>${c.email}</td>
                                    <td>${c.message}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            window.onload = function () {
            let section = "<c:out value='${section}' />";
            console.log(section);
            if (section) {
                showSection(section);
            } else {
                showSection("dashboardSection");
                }
            };
            const revenueData = [
            <c:forEach var="r" items="${revenueByMonth}">
                ${r},
            </c:forEach>
                                                ];
        </script>
        <script src="assets/JS/AdminDashboard.js" defer></script>
    </body>
</html>
