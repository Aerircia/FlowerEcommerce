const sortSelect = document.getElementById("sortSelect");
sortSelect.addEventListener("change", () => {
    const url = new URL(window.location.href);
    url.searchParams.set(
            "sort",
            sortSelect.value
            );
    window.location.href = url.toString();
});

const rangeMin = document.getElementById("rangeMin");
const rangeMax = document.getElementById("rangeMax");
const minPrice = document.getElementById("minPrice");
const maxPrice = document.getElementById("maxPrice");
const track = document.querySelector(".slider-track");
const minGap = 50000;
function updateSlider() {
    let minVal = parseInt(rangeMin.value);
    let maxVal = parseInt(rangeMax.value);
    if (maxVal - minVal < minGap) {
        if (event.target === rangeMin) {
            rangeMin.value = maxVal - minGap;
        } else {
            rangeMax.value = minVal + minGap;
        }
        minVal = parseInt(rangeMin.value);
        maxVal = parseInt(rangeMax.value);
    }
    minPrice.value = minVal;
    maxPrice.value = maxVal;
    const percent1 = (minVal / rangeMin.max) * 100;
    const percent2 = (maxVal / rangeMax.max) * 100;
    track.style.left = percent1 + "%";
    track.style.width = (percent2 - percent1) + "%";
}
rangeMin.addEventListener("input", updateSlider);
rangeMax.addEventListener("input", updateSlider);
minPrice.addEventListener("change", () => {
    rangeMin.value = minPrice.value;
    updateSlider();
});
maxPrice.addEventListener("change", () => {
    rangeMax.value = maxPrice.value;
    updateSlider();
});
updateSlider();
function applyFilter() {
    const min = minPrice.value;
    const max = maxPrice.value;
    const url = new URL(window.location.href);
    url.searchParams.set("min", min);
    url.searchParams.set("max", max);
    url.searchParams.set("page", 1);
    window.location.href = url.toString();
}
rangeMin.addEventListener("input", updateSlider);
rangeMax.addEventListener("input", updateSlider);
let timeout;
function delayedApply() {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
        applyFilter();
    }, 400);
}
rangeMin.addEventListener("change", delayedApply);
rangeMax.addEventListener("change", delayedApply);
minPrice.addEventListener("change", () => {
    rangeMin.value = minPrice.value;
    updateSlider();
    applyFilter();
});

maxPrice.addEventListener("change", () => {
    rangeMax.value = maxPrice.value;
    updateSlider();
    applyFilter();
});
window.addEventListener("load", updateSlider);