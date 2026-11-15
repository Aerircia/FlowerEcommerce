//pre render
window.addEventListener("DOMContentLoaded", function () {
    fetch("CartServlet?action=get")
            .then(res => res.json())
            .then(data => {
                document.querySelector(".cart-quantity").innerText = data.total;
                renderCart(data.items);
                updateTotal(data.items);
            });
});
// render menu cart
function renderCart(items) {
    let html = "";
    items.forEach(item => {
        html += `
            <div class="cartItem">
                <img src="assets/img/${item.img_path}" width="50"/>
                <a class="itemName" href="productDetail?id=${item.product_id}">
                    ${item.product_name}
                </a>
                <input
                    type="number"
                    class="itemQuantity"
                    value="${item.quantity}"
                    data-id="${item.product_id}"
                    min="1"
                >
                <p class="itemMul">x</p>
                <p class="itemPrice new">
                    ${item.price.toLocaleString()} đ
                </p>
                <i class="bx bx-x removeItem"
                   data-id="${item.product_id}">
                </i>
            </div>
        `;
    });
    document.querySelector(".listCart").innerHTML = html;
    bindQuantityInput();
    bindRemoveButton();
}
//update gia trong menu cart
function updateTotal(items) {
    let total = 0;
    items.forEach(item => {
        total += item.price * item.quantity;
    });
    document.getElementById("cartTotalPrice").innerText = total.toLocaleString() + " đ";
}
//update so luong trong menu cart
function bindQuantityInput() {
    document.querySelectorAll(".itemQuantity")
            .forEach(input => {
                input.addEventListener("keydown", function (e) {
                    if (e.key === "Enter") {
                        e.preventDefault();
                        const id = this.dataset.id;
                        const qty = parseInt(this.value);
                        if (isNaN(qty) || qty < 1) {
                            return;
                        }
                        fetch(`CartServlet?action=update&id=${id}&qty=${qty}`)
                                .then(res => res.json())
                                .then(data => {
                                    document.querySelector(".cart-quantity").innerText = data.total;
                                    updateTotal(data.items);
                                    renderCart(data.items);
                                });
                    }
                });
            });
}
//remove trong menu cart
function bindRemoveButton() {
    document.querySelectorAll(".removeItem")
            .forEach(btn => {
                btn.addEventListener("click", function () {
                    const id = this.dataset.id;
                    fetch(`CartServlet?action=remove&id=${id}`)
                            .then(res => res.json())
                            .then(data => {
                                document.querySelector(".cart-quantity").innerText = data.total;
                                updateTotal(data.items);
                                renderCart(data.items);
                            });
                });
            });
}
//add san pham trong search
document.addEventListener("click", function (e) {
    const btn = e.target.closest(".add-to-cart");
    if (!btn) return;
    e.preventDefault();
    const id = btn.dataset.id;
    let qty = 1;

    // product detail page
    if (btn.dataset.detail === "true") {
        const qtyInput = document.getElementById("quantity");
        qty = parseInt(qtyInput.value) || 1;
    }
    fetch(`CartServlet?action=add&id=${id}&qty=${qty}`)
            .then(res => res.json())
            .then(data => {
                document.querySelector(".cart-quantity").innerText = data.total;
                renderCart(data.items);
                updateTotal(data.items);
            });
});
