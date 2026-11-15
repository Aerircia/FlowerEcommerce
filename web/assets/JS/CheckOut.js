const deliveryType = document.getElementById("deliveryType");
const addressBox = document.getElementById("addressBox");

deliveryType.addEventListener("change", function () {
    if (this.value === "pickup") {
        addressBox.style.display = "none";
    } else {
        addressBox.style.display = "block";
    }

});

let currentDiscount = 0;
let currentCoupon = null;
function fetchCartAndUpdate() {
    fetch("CartServlet?action=get")
            .then(res => res.json())
            .then(data => {
                renderCheckoutCart(data.items);
                updateCartSummary(data.items);
            });
}
document.getElementById("applyCoupon").addEventListener("click", function () {
    const code = document.getElementById("couponCode")
            .value
            .trim();
    if (!code)
        return;
    fetch(`CouponServlet?code=${code}`)
            .then(res => res.json())
            .then(data => {
                if (!data.success) {
                    currentCoupon = null;
                    currentDiscount = 0;
                    showToast(
                            "error",
                            "Coupon",
                            data.message
                            );
                    fetchCartAndUpdate();
                    return;
                }
                currentCoupon = {
                    type: data.type,
                    value: data.value
                };
                showToast(
                        "success",
                        "Coupon",
                        "Áp dụng mã thành công"
                        );
                fetchCartAndUpdate();
            });
});
// toast thong bao
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
//render
window.addEventListener("DOMContentLoaded", function () {
    fetch("CartServlet?action=get")
            .then(res => res.json())
            .then(data => {
                document.querySelector(".cart-quantity").innerText = data.total;
                renderCheckoutCart(data.items);
                updateCartSummary(data.items);
            });
});
function updateCartSummary(items) {
    let subtotal = 0;
    let count = 0;
    items.forEach(item => {
        subtotal += item.price * item.quantity;
        count += 1 * item.quantity;
    });
    // SHIPPING
    let shipping = (count >= 10 || subtotal >= 2000000)
            ? 0
            : count * 20000;
    // DISCOUNT
    if (currentCoupon) {
        if (currentCoupon.type === "fixed")
            currentDiscount = currentCoupon.value;
        else if (currentCoupon.type === "percent") {
            currentDiscount =
                    subtotal
                    * currentCoupon.value / 100;
        }
    }
    // TOTAL
    let total =
            subtotal
            + shipping
            - currentDiscount;
    if (total < 0)
        total = 0;
    // RENDER
    document.getElementById("subtotal").innerText =
            subtotal.toLocaleString() + " đ";
    document.getElementById("shipping").innerText =
            shipping.toLocaleString() + " đ";
    document.getElementById("discount").innerText =
            currentDiscount.toLocaleString() + " đ";
    document.getElementById("total").innerText =
            total.toLocaleString() + " đ";
}
function updateCart(id, qty) {
    fetch(`CartServlet?action=update&id=${id}&qty=${qty}`)
            .then(res => res.json())
            .then(data => {
                document.querySelector(".cart-quantity").innerText = data.total;
                renderCheckoutCart(data.items);
            });
}
function bindCheckoutEvents() {

// PLUS
    document.querySelectorAll(".plus").forEach(btn => {
        btn.onclick = function () {
            const id = this.dataset.id;
            const input = document.querySelector(
                    `.qty-input[data-id="${id}"]`
                    );
            let qty = parseInt(input.value) || 1;
            qty++;
            updateCart(id, qty);
        };
    });
    // MINUS
    document.querySelectorAll(".minus").forEach(btn => {
        btn.onclick = function () {
            const id = this.dataset.id;
            const input = document.querySelector(
                    `.qty-input[data-id="${id}"]`
                    );
            let qty = parseInt(input.value) || 1;
            qty--;
            if (qty < 1)
                qty = 1;
            updateCart(id, qty);
        };
    });
    // INPUT ENTER
    document.querySelectorAll(".qty-input").forEach(input => {
        input.addEventListener("keydown", function (e) {
            if (e.key === "Enter") {
                const id = this.dataset.id;
                let qty = parseInt(this.value) || 1;
                if (qty < 1)
                    qty = 1;
                updateCart(id, qty);
            }
        });
    });
    // REMOVE
    document.querySelectorAll(".remove-btn").forEach(btn => {
        btn.onclick = function () {
            const id = this.dataset.id;
            fetch(`CartServlet?action=remove&id=${id}`)
                    .then(res => res.json())
                    .then(data => {
                        document.querySelector(".cart-quantity").innerText = data.total;
                        renderCheckoutCart(data.items);
                    });
        };
    });
}
function renderCheckoutCart(items) {
    let html = "";
    items.forEach(item => {
        html += `
        <div class="cart-item">
            <img src="assets/img/${item.img_path}">
            <a class="product-name"
               href="productDetail?id=${item.product_id}">
                ${item.product_name}
            </a>
            <div class="qty-box">
                <button type="button"
                        class="qty-btn minus"
                        data-id="${item.product_id}">
                    -
                </button>
                <input type="number"
                       class="qty-input"
                       value="${item.quantity}"
                       data-id="${item.product_id}"
                       min="1">
                <button type="button"
                        class="qty-btn plus"
                        data-id="${item.product_id}">
                    +
                </button>
            </div>
            <div class="item-total">
                ${(item.price * item.quantity).toLocaleString()} đ
            </div>
            <button class="remove-btn"
                    data-id="${item.product_id}">
                <i class='bx bx-x'></i>
            </button>
        </div>
        `;
    });
    document.getElementById("checkoutCartList").innerHTML = html;
    bindCheckoutEvents();
    updateCartSummary(items);
}