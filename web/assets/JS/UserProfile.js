const profileTabs = document.querySelectorAll(".profile-tab");
const panels = document.querySelectorAll(".tab-panel");

profileTabs.forEach(tab => {
    tab.addEventListener("click", () => {
        profileTabs.forEach(t =>
            t.classList.remove("active")
        );
        panels.forEach(p =>
            p.classList.remove("active")
        );
        tab.classList.add("active");
        const target = tab.dataset.tab;
        document.getElementById(target).classList.add("active");
    });
});

function openModal(id) {
    document.getElementById(id).classList.add("show");
    document.body.style.overflow = "hidden";
}

function closeModal(id) {
    document.getElementById(id).classList.remove("show");
    document.body.style.overflow = "auto";
}

window.addEventListener("click", function (e) {
    document.querySelectorAll(".modal")
            .forEach(modal => {
                if (e.target === modal) {
                    modal.classList.remove("show");
                    document.body.style.overflow = "auto";
                }
            });
});

function openOrderEdit(
        id,
        buyerName,
        receiverName,
        buyerPhone,
        receiverPhone,
        buyerEmail,
        deliveryDate,
        shippingAddress,
        note
        ) {
    document.getElementById("order_id").value = id;
    document.getElementById("buyer_name").value = buyerName;
    document.getElementById("receiver_name").value = receiverName;
    document.getElementById("buyer_phone").value = buyerPhone;
    document.getElementById("receiver_phone").value = receiverPhone;
    document.getElementById("buyer_email").value = buyerEmail;
    document.getElementById("delivery_date").value = deliveryDate;
    document.getElementById("shipping_address").value = shippingAddress;
    document.getElementById("note").value = note;
    document.getElementById("editOrderModal").style.display = "flex";
}

function closeModal(id) {
    document.getElementById(id).style.display = "none";
}

window.onclick = function (event) {
    const modal = document.getElementById("editOrderModal");
    if (event.target === modal) {
        modal.style.display = "none";
    }
};

const deliveryType = document.getElementById("deliveryType");
const addressBox = document.getElementById("addressBox");
deliveryType.addEventListener("change", function () {
    if (this.value === "pickup") {
        addressBox.style.display = "none";
    } else {
        addressBox.style.display = "block";
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