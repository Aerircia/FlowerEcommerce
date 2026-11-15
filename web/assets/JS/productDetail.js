const tabs = document.querySelectorAll(".tab-btn");
const panels = document.querySelectorAll(".tab-panel");

tabs.forEach(tab => {
    tab.addEventListener("click", () => {
        tabs.forEach(t => t.classList.remove("active"));
        tab.classList.add("active");
        panels.forEach(p => p.classList.remove("active"));
        const id = tab.getAttribute("data-tab");
        document.getElementById(id).classList.add("active");
    });
});

const qtyInput = document.getElementById("quantity");
const plus = document.querySelector(".plus");
const minus = document.querySelector(".minus");
const btn = document.getElementById("addToCartBtn");

plus.onclick = () => {
    let val = parseInt(qtyInput.value) || 1;
    qtyInput.value = val + 1;
};

minus.onclick = () => {
    let val = parseInt(qtyInput.value) || 1;
    if (val > 1) qtyInput.value = val - 1;
};

qtyInput.addEventListener("input", () => {
    qtyInput.value = qtyInput.value.replace(/[^0-9]/g, '');
});
document.querySelectorAll('.star').forEach(star => {
    star.addEventListener('click', function() {
        const value = this.getAttribute('data-value');
        document.getElementById('rating').value = value;
        document.querySelectorAll('.star').forEach(s => {
            s.classList.remove('selected');
        });
        for (let i = 0; i < value; i++) {
            document.querySelectorAll('.star')[i].classList.add('selected');
        }
    });
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