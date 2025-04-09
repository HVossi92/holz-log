// Dark mode functionality
export function initDarkMode() {
  // Check for saved theme preference or prefer-color-scheme
  if (localStorage.getItem('theme') === 'dark' ||
    (!localStorage.getItem('theme') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
    document.documentElement.classList.add('dark');
  } else {
    document.documentElement.classList.remove('dark');
  }
}

export function toggleDarkMode() {
  document.documentElement.classList.toggle('dark');

  // Save preference to localStorage
  if (document.documentElement.classList.contains('dark')) {
    localStorage.setItem('theme', 'dark');
  } else {
    localStorage.setItem('theme', 'light');
  }
}

// Initialize dark mode when the DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  initDarkMode();

  // Add event listener to theme toggle button if it exists
  const themeToggle = document.getElementById('theme-toggle');
  if (themeToggle) {
    themeToggle.addEventListener('click', toggleDarkMode);
  }
});

// Also initialize on page load for immediate effect
initDarkMode(); 