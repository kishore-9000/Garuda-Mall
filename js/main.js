// Navbar Scroll Effect
window.addEventListener('scroll', () => {
    const nav = document.getElementById('navbar');
    if (window.scrollY > 50) {
        nav.classList.add('scrolled');
    } else {
        nav.classList.remove('scrolled');
    }
});

// Countdown Timer
function updateTimer() {
    const offerDate = new Date();
    offerDate.setDate(offerDate.getDate() + 3); // Set offer for 3 days from now

    function tick() {
        const now = new Date().getTime();
        const distance = offerDate - now;

        const days = Math.floor(distance / (1000 * 60 * 60 * 24));
        const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const mins = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        const secs = Math.floor((distance % (1000 * 60)) / 1000);

        document.getElementById('days').innerText = days.toString().padStart(2, '0');
        document.getElementById('hours').innerText = hours.toString().padStart(2, '0');
        document.getElementById('mins').innerText = mins.toString().padStart(2, '0');
        document.getElementById('secs').innerText = secs.toString().padStart(2, '0');

        if (distance < 0) {
            clearInterval(timerInterval);
            document.querySelector('.timer').innerHTML = "<h3>OFFER ENDED</h3>";
        }
    }

    const timerInterval = setInterval(tick, 1000);
    tick();
}

// Custom Cursor Logic
const cursor = document.createElement('div');
cursor.classList.add('custom-cursor');
document.body.appendChild(cursor);

document.addEventListener('mousemove', (e) => {
    cursor.style.left = e.clientX + 'px';
    cursor.style.top = e.clientY + 'px';
});

document.addEventListener('mousedown', () => cursor.style.transform = 'scale(0.8)');
document.addEventListener('mouseup', () => cursor.style.transform = 'scale(1)');

// Simple Intersection Observer for Animations (AOS Style)
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('aos-animate');
            observer.unobserve(entry.target);
        }
    });
}, observerOptions);

// Apply initial styles and observe elements
document.addEventListener('DOMContentLoaded', () => {
    updateTimer();

    const animatedElements = document.querySelectorAll('[data-aos], .category-card, .product-card, .section-title');
    animatedElements.forEach(el => {
        observer.observe(el);
    });

    // Chat Button Interaction
    const chatBtn = document.querySelector('.chat-btn');
    chatBtn.addEventListener('click', () => {
        alert('Welcome to Garuda Mall Support! How can we help you today?');
    });
});

// Smooth Scrolling for Nav Links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            window.scrollTo({
                top: target.offsetTop - 80,
                behavior: 'smooth'
            });
        }
    });
});
