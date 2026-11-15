<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About Us</title>
        <link rel="icon" href="assets/img/icon.jpg">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" href="assets/CSS/about.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>

        <!-- HERO SECTION -->
        <section class="banner">
            <div class="banner-content">
                <h2>Về chúng tôi</h2>
                <p>
                    <a href="./HomePageServlet">Trang chủ</a>
                    <span class="x-icon">●</span>
                    <a href="./AboutServlet">Về chúng tôi</a>
                </p>
            </div>
        </section>
        <!-- ABOUT -->
        <section class="about hidden">
            <div class="about-image">
                <img src="assets/img/gioi_thieu_tiem_hoa.jpg" alt="">
            </div>
            <div class="about-content">
                <h2>Giới Thiệu Tiệm Hoa</h2>
                <p>
                    Fleur được tạo nên từ tình yêu dành cho thiên nhiên và vẻ đẹp tinh tế của những đóa hoa tươi.
                    Chúng tôi tin rằng mỗi bó hoa không chỉ là một món quà,
                    mà còn là cách để gửi gắm cảm xúc và những khoảnh khắc ý nghĩa trong cuộc sống.
                </p>
                <p>
                    Với mong muốn mang đến cho khách hàng những sản phẩm chất lượng và chỉn chu nhất,
                    Fleur luôn lựa chọn những loại hoa tươi mới mỗi ngày
                    và chăm chút trong từng thiết kế.
                </p>
            </div>
        </section>
        <!-- STYLE SECTION -->
        <section class="style-section hidden">
            <!-- RIGHT GALLERY -->
            <div class="style-gallery">
                <div class="gallery-item item1">
                    <img src="assets/img/hoa1.jpg" alt="">
                </div>
                <div class="gallery-item item2">
                    <img src="assets/img/hoa2.jpg" alt="">
                </div>
                <div class="gallery-item item3">
                    <img src="assets/img/hoa3.jpg" alt="">
                </div>
                <div class="gallery-item item4">
                    <img src="assets/img/hoa4.jpg" alt="">
                </div>
                <div class="gallery-item item5">
                    <img src="assets/img/hoa5.jpg" alt="">
                </div>
            </div>
            <div class="style-left">
                <h2>Phong Cách Theo Đuổi</h2>
                <p>
                    Fleur theo đuổi phong cách hiện đại, nhẹ nhàng và tinh tế.
                    Chúng tôi ưu tiên những thiết kế tối giản nhưng vẫn giữ được sự sang trọng
                    và cảm xúc riêng trong từng bó hoa.
                </p>
                <p>
                    Mỗi sản phẩm đều được phối màu hài hòa,
                    kết hợp cùng giấy gói và phụ kiện cao cấp
                    để tạo nên tổng thể thanh lịch và độc đáo.
                </p>
            </div>
        </section>
        <!-- BRAND DIRECTION -->
        <section class="brand-section hidden">
            <div class="brand-image">
                <img src="assets/img/dinh_huong_thuong_hieu.jpg" alt="">
            </div>
            <div class="brand-content">
                <h2>Định Hướng Thương Hiệu</h2>
                <p>
                    Trong tương lai, Fleur hướng đến việc trở thành một thương hiệu hoa uy tín
                    với phong cách sáng tạo, chất lượng và dịch vụ tận tâm.
                </p>
                <p>
                    Chúng tôi mong muốn mở rộng thêm các bộ sưu tập hoa,
                    nâng cao trải nghiệm mua sắm trực tuyến
                    và phát triển nhiều dịch vụ hoa theo chủ đề,
                    hoa sự kiện và quà tặng cao cấp.
                </p>
            </div>
        </section>
        <!-- SERVICES -->
        <section class="services hidden">
            <div class="section-title">
                <h2>Dịch Vụ Của Chúng Tôi</h2>
            </div>
            <div class="services-container">
                <div class="service-card">
                    <i class="fa-solid fa-gift"></i>
                    <h3>Hoa Sinh Nhật</h3>
                    <p>Thiết kế hoa tươi dành cho những dịp sinh nhật đặc biệt.</p>
                </div>
                <div class="service-card">
                    <i class="fa-solid fa-ring"></i>
                    <h3>Hoa Cưới</h3>
                    <p>Trang trí hoa cưới sang trọng và tinh tế.</p>
                </div>
                <div class="service-card">
                    <i class="fa-solid fa-truck-fast"></i>
                    <h3>Giao Hoa Tận Nơi</h3>
                    <p>Dịch vụ giao hoa nhanh chóng và chuyên nghiệp.</p>
                </div>
                <div class="service-card">
                    <i class="fa-solid fa-star"></i>
                    <h3>Thiết Kế Theo Yêu Cầu</h3>
                    <p>Tạo nên những bó hoa độc đáo theo phong cách riêng.</p>
                </div>
            </div>
        </section>
        <!-- STATISTICS -->
        <section class="stats">
            <div class="stat-box hidden">
                <h2 class="counter" data-target="${totalOrders}">
                    ${totalOrders}
                </h2>
                <p>Đơn hàng hoàn thành</p>
            </div>
            <div class="stat-box hidden">
                <h2 class="counter" data-target="${totalUsers}">
                    ${totalUsers}
                </h2>
                <p>Khách hàng</p>
            </div>
            <div class="stat-box hidden">
                <h2 class="counter" data-target="${totalProducts}">
                    ${totalProducts}
                </h2>
                <p>Sản phẩm</p>
            </div>
        </section>
        <!-- TEAM -->
        <section class="team">
            <div class="section-title hidden">
                <h2>Thành viên nhóm</h2>
            </div>
            <div class="team-container">
                <div class="team-card hidden">
                    <img src="assets/img/founder2.jpg" alt="">
                    <h3>Nguyễn Hữu Tuấn</h3>
                    <p>Founder</p>
                </div>
                <div class="team-card hidden">
                    <img src="assets/img/founder1.jpg" alt="">
                    <h3>Lại Anh Quân</h3>
                    <p>Founder</p>
                </div>
                <div class="team-card hidden">
                    <img src="assets/img/founder3.jpg" alt="">
                    <h3>Vũ Tiến Thành</h3>
                    <p>Founder</p>
                </div>
            </div>
        </section>
        <!-- TESTIMONIAL -->
        <section class="testimonial">
            <div class="section-title hidden">
                <h2>Nhận xét từ khách hàng</h2>
            </div>
            <div class="testimonial-slider hidden">
                <div class="testimonial-item active">
                    <p>
                        “Hoa rất tươi và được gói cực kỳ đẹp. Mình đặt tặng sinh nhật bạn và ai cũng khen.”
                    </p>
                    <h4>- Minh Anh</h4>
                </div>
                <div class="testimonial-item">
                    <p>
                        “Dịch vụ giao hàng nhanh, đúng giờ và bó hoa thực tế còn đẹp hơn cả hình.”
                    </p>
                    <h4>- Hoàng Nam</h4>
                </div>
                <div class="testimonial-item">
                    <p>
                        “Mình rất thích phong cách cắm hoa ở đây, nhẹ nhàng nhưng vẫn sang trọng.”
                    </p>
                    <h4>- Thu Phương</h4>
                </div>
                <div class="testimonial-item">
                    <p>
                        “Shop tư vấn rất nhiệt tình và hỗ trợ thiết kế bó hoa theo yêu cầu cực kỳ tinh tế.”
                    </p>
                    <h4>- Gia Hân</h4>
                </div>
                <div class="testimonial-item">
                    <p>
                        “Đây là tiệm hoa mình tin tưởng mỗi khi cần quà tặng cho những dịp đặc biệt.”
                    </p>
                    <h4>- Nhật Minh</h4>
                </div>
            </div>
        </section>
        <jsp:include page="/WEB-INF/views/shared/chatbox.jsp"/>
        <jsp:include page="/WEB-INF/views/shared/footer.jsp"/>

        <!-- Script -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <script src="assets/JS/about.js"></script>
    </body>
</html>