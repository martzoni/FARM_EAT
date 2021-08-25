const initHowItWorks = () => {
  const imageClick = document.getElementById('image-click');
  if (imageClick) {
    imageClick.addEventListener('click', () => window.scrollTo({ left: 0, top: document.body.scrollHeight, behavior: 'smooth'}),
    )};
};

export { initHowItWorks };
