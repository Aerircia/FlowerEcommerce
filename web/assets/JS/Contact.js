const form = document.getElementById("contactForm");
const wrapper = document.getElementById("contactWrapper");
const spinner = document.getElementById("loadingSpinner");
const btn = form.querySelector(".submit-btn");
const btnText = form.querySelector(".btn-text");
form.addEventListener("submit", function (e) {
    e.preventDefault();
    const name = form.name.value.trim();
    const phone = form.phone.value.trim();
    const email = form.email.value.trim();
    const message = form.message.value.trim();

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

    btn.classList.add("loading");
    spinner.classList.remove("d-none");
    btnText.textContent = "Đang gửi...";

    fetch("ContactServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: new URLSearchParams({
            name,
            phone,
            email,
            message
        })
    })
    .then(res => res.text())
    .then(data => {
        data = data.trim();
        if (data === "success") {
            wrapper.classList.add("success-state");
            wrapper.innerHTML = `
                <div class="response-box success">
                    <i class='bx bx-check-circle'></i>
                    <h3>Gửi thành công!</h3>
                    <p>
                        Cảm ơn bạn đã liên hệ với Fleur.<br>
                        Chúng tôi sẽ phản hồi sớm nhất có thể.
                    </p>
                </div>
            `;
        }
        else {
            wrapper.classList.add("error-state");
            wrapper.innerHTML = `
                <div class="response-box error">
                    <i class='bx bx-x-circle'></i>
                    <h3>Gửi thất bại</h3>
                    <p>
                        Có lỗi xảy ra khi gửi liên hệ.<br>
                        Vui lòng thử lại sau.
                    </p>
                </div>
            `;
        }
    })

    .catch(() => {
        wrapper.classList.add("error-state");
        wrapper.innerHTML = `
            <div class="response-box error">
                <i class='bx bx-error-circle'></i>
                <h3>Kết nối thất bại</h3>
                <p>
                    Không thể kết nối tới máy chủ.<br>
                    Vui lòng kiểm tra mạng và thử lại.
                </p>
            </div>
        `;
    });
});