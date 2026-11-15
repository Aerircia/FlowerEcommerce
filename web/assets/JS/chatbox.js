/*chatbox*/
const toggle = document.getElementById("chatToggle");
const chat = document.getElementById("chatBox");
const closechatboxBtn = document.getElementById("closeChat");

toggle.onclick = () => chat.classList.add("show");
closechatboxBtn.onclick = () => chat.classList.remove("show");

const form = document.getElementById("chatForm");

form.addEventListener("submit", function (e) {
    e.preventDefault();

    const name = form.name.value.trim();
    const phone = form.phone.value.trim();
    const email = form.email.value.trim();
    const message = form.message.value.trim();

    // validation
    if (name.length < 2) {
        alert("Tên phải ít nhất 2 ký tự");
        return;
    }
    if (!/^[0-9]{9,11}$/.test(phone)) {
        alert("Số điện thoại không hợp lệ");
        return;
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        alert("Email không hợp lệ");
        return;
    }
    if (message.length < 5) {
        alert("Tin nhắn quá ngắn");
        return;
    }
    // send to servlet
    fetch("ContactServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: new URLSearchParams({
            name, phone, email, message
        })
    })
            .then(res => res.text())
            .then(data => {
                // success UI
                form.innerHTML = `
            <div class="success-msg">
                <i class="bx bx-check-circle"></i>
                <h3>Gửi thành công!</h3>
                <p>Chúng tôi sẽ liên hệ sớm nhất.</p>
            </div>
        `;
            })
            .catch(() => {
                alert("Có lỗi xảy ra, thử lại!");
            });
});