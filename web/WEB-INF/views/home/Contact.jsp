
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    request.setCharacterEncoding("UTF-8");
    if (session == null || session.getAttribute("userRole") == null) {
        response.sendRedirect("./LoginServlet");
        return;
    }
%>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contact Form</title>
        <link rel="icon" href="assets/img/icon.jpg">
        <link rel="stylesheet" href="assets/CSS/Contact.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/shared/header.jsp"/>

        <!-- CONTACT SECTION -->
        <section class="contact-section">
            <div class="contact-wrapper" id="contactWrapper">
                <!-- LEFT -->
                <div class="contact-header">
                    <h2>Fleur</h2>
                    <p>
                        Chào mừng bạn đến với Fleur.
                        Vui lòng nhập thông tin trước khi bắt đầu trò chuyện
                    </p>
                </div>
                <!-- RIGHT -->
                <form class="contact-form"
                      id="contactForm"
                      action="ContactServlet"
                      method="post">
                    <input type="text"
                           name="name"
                           placeholder="Tên của bạn"
                           value="${account.username}"
                           required>
                    <input type="text"
                           name="phone"
                           placeholder="Số điện thoại của bạn"
                           value="${account.phone}"
                           required>
                    <input type="email"
                           name="email"
                           placeholder="Email của bạn"
                           value="${account.email}"
                           required>
                    <textarea name="message"
                              placeholder="Nhập tin nhắn của bạn*"
                              required></textarea>
                    <button type="submit"
                            class="submit-btn">
                        <span class="btn-text">
                            ➤ Gửi tin nhắn
                        </span>
                        <span class="spinner-border spinner-border-sm d-none"
                              id="loadingSpinner">
                        </span>
                    </button>
                </form>
            </div>
        </section>
        <jsp:include page="/WEB-INF/views/shared/footer.jsp"/>

        <script src="assets/JS/Contact.js" defer></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" defer></script>
    </body>
</html>