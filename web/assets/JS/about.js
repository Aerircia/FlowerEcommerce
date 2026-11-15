const hiddenElements = document.querySelectorAll('.hidden');
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if(entry.isIntersecting){
            entry.target.classList.add('show');
        }
    });
});

hiddenElements.forEach(el => observer.observe(el));
const counters = document.querySelectorAll('.counter');
counters.forEach(counter => {
    counter.innerText = '0';
    const updateCounter = () => {
        const target = +counter.getAttribute('data-target');
        const current = +counter.innerText;
        const increment = target / 100;
        if(current < target){
            counter.innerText = `${Math.ceil(current + increment)}`;
            setTimeout(updateCounter, 20);
        }else{
            counter.innerText = target;
        }
    };
    updateCounter();
});

const testimonials = document.querySelectorAll('.testimonial-item');
let index = 0;
function showTestimonials(){
    testimonials.forEach(item => {
        item.classList.remove('active');
    });
    testimonials[index].classList.add('active');
    index++;
    if(index >= testimonials.length){
        index = 0;
    }
}
setInterval(showTestimonials, 3000);