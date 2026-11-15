function showSection(sectionId) {
    document.querySelectorAll('.admin_dashboard_section').forEach(sec => {
        sec.style.display = 'none';
    });
    const target = document.getElementById(sectionId);
    if (target) {
        target.style.display = 'block';
    }
    document.querySelectorAll('.admin_dashboard_function a').forEach(link => {
        link.classList.remove('active');
    });
    const activeLink = document.querySelector(`.admin_dashboard_function a[data-section="${sectionId}"]`);
    if (activeLink) {
        activeLink.classList.add('active');
    }
}

function showModal(id) {
    const modal = document.getElementById(id);
    if (!modal) return;
    modal.style.display = "flex";
    document.body.style.overflow = "hidden";
}

function hideModal(id) {
    const modal = document.getElementById(id);
    if (!modal) return;
    modal.style.display = "none";
    document.body.style.overflow = "auto";
}
function openAdd() {
    showModal("addModal");
}

function openEdit(id, name, price, sold, desc, img, dis, catIds) {
    showModal("editModal");
    document.getElementById("edit_id").value = id;
    document.getElementById("edit_name").value = name;
    document.getElementById("edit_price").value = price;
    document.getElementById("edit_sold").value = sold;
    document.getElementById("edit_desc").value = desc;
    document.getElementById("edit_img").value = img;
    document.getElementById("edit_dis").value = dis;
    let textarea = document.getElementById("edit_desc");
    textarea.value = desc;
    autoResize(textarea);
    let checkboxes = document.querySelectorAll(".edit-category");
    checkboxes.forEach(cb => cb.checked = false);
    let arr = catIds.split(",");
    checkboxes.forEach(cb => {
        if (arr.includes(cb.value)) {
            cb.checked = true;
        }
    });
}
function openAddRoleModal() {
    showModal("addRoleModal");
}

function closeAddRoleModal() {
    hideModal("addRoleModal");
}
function openEditRole(
        id,
        avatar,
        username,
        nickname,
        email,
        phone,
        password,
        address,
        role
        ) {
    showModal("editRoleModal");
    document.getElementById("edit_idacc").value = id;
    document.getElementById("edit_avatar").value = avatar;
    document.getElementById("edit_username").value = username;
    document.getElementById("edit_nickname").value = nickname;
    document.getElementById("edit_email").value = email;
    document.getElementById("edit_phone").value = phone;
    document.getElementById("edit_address").value = address;
    document.getElementById("edit_role").value = role;
}
function closeEditRoleModal() {
    hideModal("editRoleModal");
}
function openAddOrderModal() {
    showModal("addOrderModal");
}
function closeAddOrderModal() {
    hideModal("addOrderModal");
}
function closeEditOrderModal() {
    hideModal("editOrderModal");
}
function closeModal(id) {
    hideModal(id);
}
window.addEventListener("click", function (event) {
    const modals = document.querySelectorAll(".modal");
    modals.forEach(modal => {
        if (event.target === modal) {
            modal.style.display = "none";
            document.body.style.overflow = "auto";
        }
    });
});
window.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
        const modals = document.querySelectorAll(".modal");
        modals.forEach(modal => {
            if (modal.style.display === "flex") {
                modal.style.display = "none";
            }
        });
        document.body.style.overflow = "auto";
    }
});
function autoResize(textarea) {
    textarea.style.height = "auto";
    textarea.style.height = textarea.scrollHeight + "px";
}
document.querySelectorAll("textarea").forEach(textarea => {
    autoResize(textarea);
    textarea.addEventListener("input", function () {
        autoResize(this);
    });
});
function openCompleteModal(id){
    document.getElementById("complete_order_id").value = id;
    document.getElementById("completeOrderModal")
            .style.display = "flex";
}
function closeCompleteModal(){
    document.getElementById("completeOrderModal")
            .style.display = "none";
}
window.addEventListener("load", function () {
    createRevenueChart();
});

function createRevenueChart() {
    const chartCanvas = document.getElementById("revenueChart");
    if (!chartCanvas) {
        return;
    }
    new Chart(chartCanvas, {
        type: "line",
        data: {
            labels: [
                "Jan",
                "Feb",
                "Mar",
                "Apr",
                "May",
                "Jun",
                "Jul",
                "Aug",
                "Sep",
                "Oct",
                "Nov",
                "Dec"
            ],
            datasets: [{
                label: "Revenue",
                data: revenueData,
                borderColor: "#4a6cf7",
                backgroundColor: "rgba(74,108,247,0.15)",
                fill: true,
                tension: 0.4,
                borderWidth: 3,
                pointBackgroundColor: "#4a6cf7",
                pointRadius: 5,
                pointHoverRadius: 7
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    labels: {
                        color: "#333",
                        font: {
                            size: 14
                        }
                    }
                }
            },
            scales: {
                x: {
                    ticks: {
                        color: "#666"
                    },
                    grid: {
                        display: false
                    }
                },
                y: {
                    beginAtZero: true,
                    ticks: {
                        color: "#666"
                    },
                    grid: {
                        color: "rgba(0,0,0,0.06)"
                    }
                }
            }
        }
    });
}