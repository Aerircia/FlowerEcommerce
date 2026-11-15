//swiper
var swiper = new Swiper(".mySwiper", {
    slidesPerView: 1,
    //grabCursor: true,
    spaceBetween: 30,
    loop: true,
    pagination: {
        el: ".swiper-pagination",
        clickable: true
    },
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev"
    }
});

var swiper = new Swiper(".TopSaleSwiper", {
    slidesPerView: "auto",
    spaceBetween: 20,
    loop: true,
    watchOverflow: true,
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev"
    }
});

const swiper1 = new Swiper(".product-swiper", {
    slidesPerView: 1,
    spaceBetween: 30,

    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },

    breakpoints: {
        600: {
            slidesPerView: 3
        },
        900: {
            slidesPerView: 4
        },
        1200: {
            slidesPerView: 5   // max 4 items visible
        }
    }
});

const tabs = document.querySelectorAll(".tab");
const wrappers = document.querySelectorAll(".product-wrapper");

tabs.forEach(tab => {
    tab.onclick = () => {

        tabs.forEach(t => t.classList.remove("active"));
        tab.classList.add("active");

        let id = tab.dataset.id;

        let active = document.querySelector(`.product-wrapper[data-category="${id}"]`);

        if (!active) {
            wrappers.forEach(w => w.style.display = "none");

            document.querySelector(".product-wrapper-empty").style.display = "block";
            return;
        }

        wrappers.forEach(w => w.style.display = "none");
        active.style.display = "grid";
    };
});