<%-- Script para aplicar tema oscuro inmediatamente --%>
<script>
    // Verificar tema guardado
    const savedTheme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', savedTheme);
    if (savedTheme === 'dark') {
        document.documentElement.setAttribute('data-bs-theme', 'dark');
        // Esperar a que el body esté disponible
        document.addEventListener('DOMContentLoaded', function() {
            if (document.body) {
                document.body.classList.add('dark-theme');
            }
        });
    }
</script>

<%-- Incluir los estilos y scripts necesarios --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/theme.js"></script> 