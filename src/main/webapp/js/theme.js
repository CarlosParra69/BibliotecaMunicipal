// Función para establecer el tema
function setTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    
    // Sincronizar con Bootstrap 5
    if (theme === 'dark') {
        document.documentElement.setAttribute('data-bs-theme', 'dark');
        if (document.body) {
            document.body.classList.add('dark-theme');
        }
    } else {
        document.documentElement.removeAttribute('data-bs-theme');
        if (document.body) {
            document.body.classList.remove('dark-theme');
        }
    }
    
    localStorage.setItem('theme', theme);
    updateThemeIcon(theme);
}

// Función para actualizar el icono según el tema
function updateThemeIcon(theme) {
    const icon = document.querySelector('.theme-selector .icon');
    if (icon) {
        icon.innerHTML = theme === 'dark' ? '🌙' : '☀️';
    }
}

// Función para inicializar el tema
function initTheme() {
    // Aplicar tema inmediatamente antes de que se cargue el DOM completo
    const savedTheme = localStorage.getItem('theme') || 'light';
    setTheme(savedTheme);
    
    // Actualizar selector si existe
    const themeSelect = document.querySelector('#themeSelect');
    if (themeSelect) {
        themeSelect.value = savedTheme;
    }
}

// Agregar el selector de tema al DOM
function addThemeSelector() {
    if (!document.body) return;
    
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
    if (themeSelect) {
        themeSelect.addEventListener('change', (e) => setTheme(e.target.value));
    }
}

// Aplicar tema inmediatamente para evitar parpadeo
(function() {
    const savedTheme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', savedTheme);
    
    // Sincronizar con Bootstrap
    if (savedTheme === 'dark') {
        document.documentElement.setAttribute('data-bs-theme', 'dark');
        // No modificar document.body aquí, se hará después de que esté disponible
    }
})();

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    // Ahora document.body ya está disponible
    const savedTheme = localStorage.getItem('theme') || 'light';
    if (savedTheme === 'dark' && document.body) {
        document.body.classList.add('dark-theme');
    }
    
    addThemeSelector();
    initTheme();
    
    // Observar cambios al tema en caso de que otra parte de la aplicación lo modifique
    const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
            if (mutation.attributeName === 'data-theme') {
                const theme = document.documentElement.getAttribute('data-theme');
                updateThemeIcon(theme);
                
                // Actualizar selector si existe
                const themeSelect = document.querySelector('#themeSelect');
                if (themeSelect && theme) {
                    themeSelect.value = theme;
                }
            }
        });
    });
    
    observer.observe(document.documentElement, { attributes: true });
});