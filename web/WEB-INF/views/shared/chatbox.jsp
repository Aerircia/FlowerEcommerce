<%-- 
    Document   : chatbox
    Created on : May 25, 2026, 10:47:51 AM
    Author     : pipo1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="assets/CSS/chatbox.css">
    </head>
    <body>
        <div class="chat-toggle" id="chatToggle">
            <i class="bx bx-message-dots"></i>
            <span>Chúng mình luôn sẵn sàng để tư vấn!</span>
        </div>
        <div class="chat-overlay" id="chatBox">
            <div class="chat-container">
                <div class="chat-header">
                    <h2>Fleur</h2>
                    <i class="bx bx-x" id="closeChat"></i>
                    <p>Chào mừng bạn đến với Fleur. Vui lòng nhập thông tin trước khi bắt đầu trò chuyện</p>
                </div>
                <form action="./ContactServlet" method="post" id="chatForm" class="chat-form">
                    <input type="text" name="name" placeholder="Tên của bạn" required>
                    <input type="text" name="phone" placeholder="Số điện thoại của bạn" required>
                    <input type="email" name="email" placeholder="Email của bạn" required>
                    <textarea name="message" placeholder="Nhập tin nhắn của bạn*" required></textarea>
                    <button type="submit">
                        <i class="bx bx-send"></i> Gửi tin nhắn
                    </button>
                </form>
            </div>
        </div>
        <script src="assets/JS/chatbox.js" defer></script>
    </body>
</html>
