document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
  anchor.addEventListener('click', (event) => {
    const href = anchor.getAttribute('href');
    if (!href || href === '#') return;
    const target = document.querySelector(href);
    if (!target) return;
    event.preventDefault();
    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
  });
});

const header = document.querySelector('.header');
const syncHeaderState = () => {
  if (!header) return;
  header.style.boxShadow = window.scrollY > 12 ? '0 10px 30px rgba(0,0,0,0.18)' : 'none';
};

window.addEventListener('scroll', syncHeaderState, { passive: true });
syncHeaderState();
