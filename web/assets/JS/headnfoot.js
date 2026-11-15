// MOBILE MENU
const menuBtn = document.querySelector(".navOpen-btn");
const mobileMenu = document.querySelector(".mobile-menu");
const navCloseBtn = document.querySelector(".navClose-btn");

// CART
const cartBtn = document.querySelector(".cartOpenbtn");
const cartTab = document.querySelector(".cartTab");
const cartCloseBtn = document.querySelector(".cartClosebtn");

// OVERLAY
const overlay = document.querySelector(".overlay");

// OPEN MOBILE MENU
menuBtn.addEventListener("click", () => {
    mobileMenu.classList.add("open");
    overlay.classList.add("show");

});

// CLOSE MOBILE MENU
navCloseBtn.addEventListener("click", closeAll);

// OPEN CART
cartBtn.addEventListener("click", () => {
    cartTab.classList.add("open");
    overlay.classList.add("show");

});

// CLOSE CART
cartCloseBtn.addEventListener("click", closeAll);

// CLICK OVERLAY
overlay.addEventListener("click", closeAll);

// CLOSE FUNCTION
function closeAll(){
    mobileMenu.classList.remove("open");
    cartTab.classList.remove("open");
    overlay.classList.remove("show");

}

//scroll btn
const scrollBtn = document.querySelector('.scrollUp-btn');

window.addEventListener('scroll', () => {
    if (window.scrollY > 200) { // adjust threshold as needed
        scrollBtn.classList.add('show');
    } else {
        scrollBtn.classList.remove('show');
    }
});

/*to top button*/
scrollBtn.addEventListener('click', (event) => {
    event.preventDefault();
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});
