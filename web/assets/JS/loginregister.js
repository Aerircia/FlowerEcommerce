form.addEventListener("submit", function (e) {
    e.preventDefault();
    const phone = form.phone.value.trim();
    const email = form.email.value.trim();
    if (!/^[0-9]{9,11}$/.test(phone)) {
        alert("Số điện thoại không hợp lệ");
        return;
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        alert("Email không hợp lệ");
        return;
    }
});

function showToast(type, title, message) {
    const container = document.getElementById("toastContainer");
    const toast = document.createElement("div");
    toast.className = `toast custom-toast ${type}`;
    toast.setAttribute("role", "alert");
    toast.setAttribute("aria-live", "assertive");
    toast.setAttribute("aria-atomic", "true");
    const icon =
            type === "success"
            ? "bx-check-circle"
            : "bx-x-circle";
    toast.innerHTML = `
        <div class="toast-body">
            <div class="toast-icon">
                <i class='bx ${icon}'></i>
            </div>
            <div>
                <div class="toast-title">
                    ${title}
                </div>
                <div class="toast-message">
                    ${message}
                </div>
            </div>
        </div>
    `;
    container.appendChild(toast);
    const bsToast = new bootstrap.Toast(toast, {
        delay: 5000
    });
    bsToast.show();
    toast.addEventListener("hidden.bs.toast", () => {
        toast.remove();
    });
}
        