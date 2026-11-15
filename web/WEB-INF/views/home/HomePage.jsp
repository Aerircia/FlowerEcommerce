<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport">
        <title>Home</title>
        <link rel="icon" href="assets/img/icon.jpg">
        <link rel="stylesheet" href="assets/CSS/HomePage.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>

        <main>
            <!-- BannerSwiper -->
            <section class="section home" id="home">
                <div class="home-content">
                    <div class="swiper mySwiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <img src="assets/img/Swiper1.jpg" class="home-img"/>
                                <div class="home-details">
                                    <h2 class="homeTitle left">Bó hoa</h2>
                                    <h4 class="homeSubtitle left">Bó hoa mang phong cách thiết kế hiện đại, kết hợp tinh tế giữa những đóa hoa chủ đạo rực rỡ và các loại lá phụ mềm mại để tạo nên một tổng thể hài hòa, sang trọng.</h4>
                                    <a href="CategoryServlet?id=1" class="left"><button>Tham khảo</button></a>
                                </div>
                            </div>

                            <div class="swiper-slide">
                                <img src="assets/img/Swiper2.jpg" class="home-img"/>
                                <div class="home-details">
                                    <h2 class="homeTitle right">Hoa cưới</h2>
                                    <h4 class="homeSubtitle right">Hoa cưới không chỉ là món phụ kiện tôn vinh vẻ đẹp duyên dáng của cô dâu mà còn là biểu tượng cho tình yêu nở rộ và những lời chúc phúc tốt đẹp nhất.</h4>
                                    <a href="CategoryServlet?id=16" class="right"><button>Tham khảo</button></a>
                                </div>
                            </div>

                            <div class="swiper-slide">
                                <img src="assets/img/Swiper3.jpg" class="home-img"/>
                                <div class="home-details">
                                    <h2 class="homeTitle left">Valentine</h2>
                                    <h4 class="homeSubtitle left">Hoa Valentine là biểu tượng của tình yêu và sự lãng mạn, thường được lựa chọn để gửi gắm những cảm xúc chân thành trong ngày đặc biệt. Với đa dạng màu sắc và kiểu dáng, mỗi bó hoa mang một thông điệp riêng, giúp bạn dễ dàng trao gửi yêu thương đến người mình trân trọng.</h4>
                                    <a href="CategoryServlet?id=17" class="left"><button>Tham khảo</button></a>
                                </div>
                            </div>

                            <div class="swiper-slide">
                                <img src="assets/img/banner4.jpg" class="home-img"/>
                                <div class="home-details">
                                    <h2 class="homeTitle right">Flower Box</h2>
                                    <h4 class="homeSubtitle right">Trao gửi tâm ý qua những hộp hoa thiết kế sang trọng, là sự kết hợp hoàn mỹ giữa phom dáng hiện đại và sắc hoa tươi thắm để mọi món quà đều trở nên khó quên.</h4>
                                    <a href="CategoryServlet?id=5" class="right"><button>Tham khảo</button></a>
                                </div>
                            </div>

                            <div class="swiper-slide">
                                <img src="assets/img/banner5.jpg" class="home-img"/>
                                <div class="home-details">
                                    <h2 class="homeTitle left">Hoa Vĩnh Cửu</h2>
                                    <h4 class="homeSubtitle left">Những dịp đặc biệt xứng đáng với những đóa hoa vĩnh cửu. Các thiết kế hoa khô và hoa bảo quản được chế tác bằng cả tình yêu để cùng bạn kỷ niệm mọi khoảng khắc</h4>
                                    <a href="CategoryServlet?id=5" class="left"><button>Tham khảo</button></a>
                                </div>
                            </div>

                            <div class="swiper-slide">
                                <img src="assets/img/banner6.jpg" class="home-img"/>
                                <div class="home-details">
                                    <h2 class="homeTitle right">Quạt hoa</h2>
                                    <h4 class="homeSubtitle right">Sự kết hợp tinh tế giữa nét đẹp truyền thống và nghệ thuật sắp đặt hoa hiện đại, mang đến làn gió thanh tao và tạo điểm nhấn sang trọng cho mọi không gian sống.</h4>
                                    <a href="CategoryServlet?id=5" class="right"><button>Tham khảo</button></a>
                                </div>
                            </div>

                        </div>
                        <div class="swiper-button-next swiper-navBtn"></div>
                        <div class="swiper-button-prev swiper-navBtn"></div>
                        <div class="swiper-pagination"></div>
                    </div>
                </div>
            </section>
            <!-- TopSaleSwiper -->
            <section class="top-sale">
                <div class="section-title">
                    <img src="https://www.petitefleursg.com/catalog/view/theme/default/stylesheet/img/header-icon.png" class="why-icon"><br>
                    <span class="tag">TOP SALE</span>
                    <h2>GIẢM GIÁ HÔM NAY</h2>
                </div>
                <div class="swiper TopSaleSwiper">
                    <div class="swiper-wrapper">
                        <c:forEach var="p" items="${products}">
                            <div class="swiper-slide product-card">
                                <div class="product-img">
                                    <img src="assets/img/${p.img_path}" />
                                    <span class="discount">-${p.discount_percent}%</span>
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
                                    <h4>${p.product_name}</h4>
                                    <div class="price">
                                        <span class="new">
                                            <fmt:formatNumber value="${p.gia_sau}" type="number"/> đ
                                        </span>
                                        <span class="old">
                                            <fmt:formatNumber value="${p.price}" type="number"/> đ
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="swiper-button-next swiper-navBtn"></div>
                    <div class="swiper-button-prev swiper-navBtn"></div>
                </div>
                <div class="see-more">
                    <a href="SearchServlet?action=onsale">THAM KHẢO NGAY</a>
                </div>
            </section>
            <!-- Featured -->
            <section class="featured-section">
                <div class="featured-heading">
                    <img src="https://www.petitefleursg.com/catalog/view/theme/default/stylesheet/img/header-icon.png" class="featured-icon">
                    <h2>DANH MỤC NỔI BẬT</h2>
                </div>
                <div class="featured-grid">
                    <a href="CategoryServlet?id=0" class="featured-card small">
                        <img src="https://www.petitefleursg.com/image/catalog/@dried.jpg">
                        <div class="featured-overlay"></div>
                        <div class="featured-content">
                            <h3>Hoa Khô</h3>
                            <p>Những dịp đặc biệt xứng đáng với những đóa hoa vĩnh cửu. Các thiết kế hoa khô và hoa bảo quản của chúng tôi được chế tác bằng cả tình yêu để cùng bạn kỷ niệm ngày cưới, sinh nhật và nhiều cột mốc đáng nhớ khác.</p>
                        </div>
                        <div class="featured-border"></div>
                    </a>

                    <a href="CategoryServlet?id=1" class="featured-card large">
                        <img src="https://www.petitefleursg.com/image/catalog/_________a.jpg">
                        <div class="featured-overlay"></div>
                        <div class="featured-content">
                            <h3>Bó hoa</h3>
                            <p>Được chế tác bằng cả tâm huyết và sự tỉ mỉ, mỗi bó hoa của chúng tôi không chỉ đơn thuần là một món quà. Đó là cách chúng tôi tôn vinh niềm vui, tình yêu và những khoảnh khắc đặc biệt trong cuộc sống.</p>
                        </div>
                        <div class="featured-border"></div>
                    </a>
                    <a href="CategoryServlet?id=5" class="featured-card wide">
                        <img src="https://www.petitefleursg.com/image/catalog/@flowerbox.jpg">
                        <div class="featured-overlay"></div>
                        <div class="featured-content">
                            <h3>Hộp Hoa</h3>
                            <p>Những hộp hoa thiết kế của chúng tôi không chỉ đơn thuần là hoa. Đó là món quà ý nghĩa cho những khoảnh khắc tươi đẹp nhất của cuộc sống.</p>
                        </div>
                        <div class="featured-border"></div>
                    </a>

                    <a href="CategoryServlet?id=9" class="featured-card small">
                        <img src="https://www.petitefleursg.com/image/catalog/@newflower.jpg">
                        <div class="featured-overlay"></div>
                        <div class="featured-content">
                            <h3>Bộ sưu tập hoa mới</h3>
                            <p>Khám phá bộ sưu tập hoa mới nhất với thiết kế hiện đại, sang trọng, được kết tinh từ những đóa hoa tươi thắm nhất.</p>
                        </div>
                        <div class="featured-border"></div>
                    </a>
                </div>
            </section>
            <!-- TrendyCollection -->
            <section class="Trendy">
                <div class="section-title">
                    <img src="https://www.petitefleursg.com/catalog/view/theme/default/stylesheet/img/header-icon.png" class="why-icon"><br>
                    <span class="tag">This month</span>
                    <div class="title-row">
                        <h2>NỔI BẬT TRONG THÁNG</h2>
                        <div class="trendy-tabs">
                            <span class="tab active" data-id="1">Bó hoa Size S</span>
                            <span class="tab" data-id="7">Giỏ hộp hoa Size M</span>
                            <span class="tab" data-id="16">Hoa cưới</span>
                            <span class="tab" data-id="17">Valentine</span>
                        </div>
                    </div>
                </div>
                <div class="tabs" style="max-width: 70%; justify-self: center;">
                    <c:forEach var="entry" items="${categoryProducts}">
                        <div class="product-wrapper" data-category="${entry.key}" 
                             style="${entry.key == 1 ? 'display:grid;' : 'display:none;'}">
                            <c:forEach var="p" items="${entry.value}">
                                <div class="product-card">
                                    <div class="product-img">
                                        <img src="assets/img/${p.img_path}" />
                                        <c:if test="${p.price != p.gia_sau}">
                                            <span class="discount">-${p.discount_percent}%</span>
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
                                        <h4>${p.product_name}</h4>
                                        <div class="price">
                                            <c:choose>
                                                <c:when test="${p.price != p.gia_sau}">
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
                    </c:forEach>
                </div>
            </section>
            <!-- AboutUs -->
            <section class="section about-section">
                <div class="about-card">
                    <div class="about-image">
                        <img src="assets/img/aboutus.jpg" alt="">
                    </div>
                    <div class="about-content">
                        <h2 class="about-title">Về chúng tôi</h2>
                        <p class="about-text">
                            Tại Fleur, chúng tôi tin rằng hoa có sức mạnh làm bừng sáng ngày mới và khiến những khoảnh khắc đặc biệt trở nên đáng nhớ hơn. 
                            Đó là lý do chúng tôi tâm huyết mang đến cho bạn bạn những đóa hoa tươi thắm và rực rỡ nhất, đến mọi nơi bạn muốn. 
                            Đội ngũ chuyên gia của chúng tôi luôn cẩn thận tuyển chọn và tự tay thiết kế từng bó hoa...
                        </p>
                        <div class="read-more">
                            <a href="AboutServlet">Đọc thêm</a>
                        </div>
                    </div>
                </div>
            </section>
            <!-- WhyUs -->
            <section class="why-section">
                <div class="why-heading">
                    <img src="https://www.petitefleursg.com/catalog/view/theme/default/stylesheet/img/header-icon.png" class="why-icon">
                    <h2>Tại Sao Nên Chọn Fleur?</h2>
                </div>
                <div class="why-container">
                    <div class="why-item">
                        <div class="why-image">
                            <img src="https://www.petitefleursg.com/image/catalog/same-day-flower-islandwide-delivery.png" alt="">
                        </div>
                        <h3>Giao trong ngày</h3>
                        <p>Fleur cung cấp dịch vụ giao hỏa tốc trong ngày với những bó hoa thiết kế thủ công, đảm bảo độ tươi mới và sang trọng cho mọi dịp đặc biệt.</p>
                    </div>
                    <div class="why-flower">
                        <img src="https://www.petitefleursg.com/catalog/view/theme/default/stylesheet/img/flower.png" alt="alt"/>
                    </div>
                    <div class="why-item">
                        <div class="why-image">
                            <img src="https://www.petitefleursg.com/image/catalog/icon-2.png" alt="">
                        </div>
                        <h3>Mẫu hoa độc đáo</h3>
                        <p>Mỗi mẫu hoa đều được chăm chút tỉ mỉ từ những bông hoa cao cấp nhất, kết hợp giữa nét đẹp hiện đại và sự tinh tế vượt thời gian.</p>
                    </div>
                    <div class="why-flower">
                        <img src="https://www.petitefleursg.com/catalog/view/theme/default/stylesheet/img/flower.png" alt="alt"/>
                    </div>
                    <div class="why-item">
                        <div class="why-image">
                            <img src="https://www.petitefleursg.com/image/catalog/highly-skilled-florist.png" alt="">
                        </div>
                        <h3>Đội ngũ chuyên nghiệp</h3>
                        <p>Đội ngũ giàu kinh nghiệm chú trọng từng chi tiết nhỏ, biến mỗi bó hoa thành một tác phẩm nghệ thuật đầy ấn tượng.</p>
                    </div>
                </div>
            </section>
            <!-- Promo -->
            <section class="promo-section">
                <div class="promo-card blue">
                    <h3>TÍCH ĐIỂM mỗi đơn hàng</h3>
                    <p>Khách hàng mua hàng tại Fleur đều được tích điểm sau mỗi lượt mua và điểm thưởng được quy đổi thành tiền áp dụng giảm giá cho các đơn hàng sau</p>
                    <a href="RegisterServlet"><button class="btn-outline">ĐĂNG KÝ</button></a>
                </div>
                <div class="promo-card yellow">
                    <h3>THÀNH VIÊN</h3>
                    <p>Trở thành Member để sử dụng điểm thưởng và nhận thông tin cac chương trình ưu đãi tại Fleur</p>
                    <a href="RegisterServlet"><button class="btn-outline">THAM GIA</button></a>
                </div>
                <div class="promo-card pink">
                    <h3>ĐƠN HÀNG Doanh nghiệp</h3>
                    <p>Tùy chỉnh thiết kế theo màu sắc hoặc logo của doanh nghiệp - Hoá đơn VAT cho khách hàng doanh nghiệp - Ưu đãi/chiết khấu lớn cho khách hàng đặt mua sớm trước 1 tuần</p>
                    <a href="AboutServlet"><button class="btn-outline">ĐỌC THÊM</button></a>
                </div>
            </section>
            <!-- Services -->
            <section class="section service">
                <div class="service-container container">
                    <div class="service-item flex">
                        <i class="bx bxs-truck service-icon"></i>
                        <div>
                            <h3 class="service-title">Giao hoa tại Hà Nội</h3>
                            <p class="service-desc">
                                Shop giao hàng khu vực nội thành và ngoại thành Hà Nội với mức ưu đãi đặc biệt
                            </p>
                        </div>
                    </div>
                    <div class="service-item flex">
                        <i class="bx bx-wallet service-icon"></i>
                        <div>
                            <h3 class="service-title">Đổi trả và hoàn tiền</h3>
                            <p class="service-desc">
                                Nếu khách hàng không hài lòng với sản phẩm shop sẽ thu xếp để đổi trả hoặc hoàn lại tiền theo mong muốn của khách hàng
                            </p>
                        </div>
                    </div>
                    <div class="service-item flex">
                        <i class="bx bx-shield-quarter service-icon"></i>
                        <div>
                            <h3 class="service-title">Uy tín & chất lượng</h3>
                            <p class="service-desc">
                                Iris Florist luôn nỗ lực để mang lại những sản phẩm hoàn thiện nhất và tươi mới nhất đến tay khách hàng
                            </p>
                        </div>
                    </div>
                    <div class="service-item flex">
                        <i class="bx bx-star service-icon"></i>
                        <div>
                            <h3 class="service-title">Chương trình tích điểm</h3>
                            <p class="service-desc">
                                Khách hàng mua hàng tại Iris đều được tích điểm sau mỗi lượt mua và điểm thưởng được quy đổi thành tiền cho các đơn hàng sau
                            </p>
                        </div>
                    </div>
                </div>
            </section>
        </main>
        <jsp:include page="/WEB-INF/views/shared/chatbox.jsp"/>
        <jsp:include page="/WEB-INF/views/shared/footer.jsp"/>
        <!-- Script -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <script src="assets/JS/HomePage.js" defer></script>
    </body>
</html>
