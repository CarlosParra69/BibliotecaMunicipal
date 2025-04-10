// Función para establecer el tema
function setTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);
    updateThemeIcon(theme);
}

// Función para actualizar el icono según el tema
function updateThemeIcon(theme) {
    const icon = document.querySelector('.theme-selector .icon');
    icon.innerHTML = theme === 'dark' ? '🌙' : '☀️';
}

// Función para inicializar el tema
function initTheme() {
    const savedTheme = localStorage.getItem('theme') || 'light';
    setTheme(savedTheme);
    const themeSelect = document.querySelector('#themeSelect');
    if (themeSelect) {
        themeSelect.value = savedTheme;
    }
}

// Agregar el selector de tema al DOM
function addThemeSelector() {
    const themeSelector = document.createElement('div');
    themeSelector.className = 'theme-selector';
    themeSelector.innerHTML = `
        <span class="icon">☀️</span>
        <select id="themeSelect">
            <option value="light">Modo Claro</option>
            <option value="dark">Modo Oscuro</option>
        </select>
    `;

    document.body.appendChild(themeSelector);

    // Evento para cambio de tema
    const themeSelect = document.querySelector('#themeSelect');
    themeSelect.addEventListener('change', (e) => setTheme(e.target.value));
}

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    addThemeSelector();
    initTheme();
});