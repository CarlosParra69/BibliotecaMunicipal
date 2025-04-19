<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Biblioteca - Sistema de Gestión de Libros</title>
        <link rel="icon" href="img/book-closed-svgrepo-com.svg" type="image/svg+xml">
        <%-- Incluir scripts y estilos para tema --%>
        <%@ include file="/includes/theme-script.jsp" %>
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!-- Animate.css para animaciones -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <style>
            /* Estilos adicionales para la landing page */
            .hero-section {
                background: linear-gradient(135deg, var(--header-bg) 0%, var(--btn-primary-hover) 100%);
                color: var(--header-text);
                border-radius: 12px;
                padding: 3rem 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 8px 20px var(--shadow-color);
                position: relative;
                overflow: hidden;
            }
            
            .hero-section::after {
                content: "";
                position: absolute;
                top: 0;
                right: 0;
                width: 100%;
                height: 100%;
                background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHZpZXdCb3g9IjAgMCAxMDAgMTAwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJub25lIj48cGF0aCBkPSJNMCwwIEwxMDAsMTAwIiBzdHJva2U9InJnYmEoMjU1LDI1NSwyNTUsMC4xKSIgc3Ryb2tlLXdpZHRoPSIyIj48L3BhdGg+PC9zdmc+');
                opacity: 0.2;
                z-index: 0;
            }
            
            .hero-content {
                position: relative;
                z-index: 1;
            }
            
            .feature-card {
                border-radius: 12px;
                padding: 1.5rem;
                height: 100%;
                transition: all 0.3s ease;
                border: 1px solid var(--table-border);
                background-color: var(--container-bg);
                box-shadow: 0 4px 12px var(--shadow-color);
            }
            
            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 24px var(--shadow-color);
            }
            
            .feature-icon {
                font-size: 2.5rem;
                margin-bottom: 1rem;
                color: var(--btn-primary-bg);
            }
            
            .stats-section {
                background-color: var(--dashboard-bg);
                border-radius: 12px;
                padding: 2rem;
                margin: 2rem 0;
            }
            
            .stat-item {
                text-align: center;
                padding: 1rem;
            }
            
            .stat-number {
                font-size: 2.5rem;
                font-weight: bold;
                color: var(--btn-primary-bg);
                margin-bottom: 0.5rem;
            }
            
            .stat-label {
                font-size: 1rem;
                color: var(--text-color);
            }
            
            .testimonial {
                background-color: var(--container-bg);
                border-radius: 12px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                border-left: 4px solid var(--btn-primary-bg);
                box-shadow: 0 4px 12px var(--shadow-color);
            }
            
            .cta-section {
                background: linear-gradient(135deg, var(--btn-primary-bg) 0%, var(--btn-primary-hover) 100%);
                color: var(--header-text);
                border-radius: 12px;
                padding: 3rem 2rem;
                margin: 2rem 0;
                text-align: center;
            }
            
            .nav-pills .nav-link {
                color: var(--text-color);
                border-radius: 50rem;
                padding: 0.5rem 1.5rem;
                margin: 0 0.25rem;
                transition: all 0.3s ease;
            }
            
            .nav-pills .nav-link.active {
                background-color: var(--btn-primary-bg);
                color: var(--header-text);
            }
            
            .nav-pills .nav-link:hover:not(.active) {
                background-color: var(--dashboard-hover);
            }
            
            .dashboard-item {
                height: 100%;
                display: flex;
                flex-direction: column;
            }
            
            .dashboard-item .btn {
                margin-top: auto;
            }
            
            footer {
                background-color: var(--container-bg);
                border-radius: 8px;
                padding: 2rem 0;
                margin-top: 3rem;
                box-shadow: 0 -4px 10px var(--shadow-color);
            }
            
            .book-animation {
                animation: float 6s ease-in-out infinite;
            }
            
            @keyframes float {
                0% { transform: translateY(0px); }
                50% { transform: translateY(-20px); }
                100% { transform: translateY(0px); }
            }
        </style>
    </head>
    <body>
        <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
        <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
        
        <!-- Navbar mejorado -->
        <nav class="navbar navbar-expand-lg" style="background-color: var(--header-bg); border-radius: 0 0 15px 15px; margin-bottom: 2rem; box-shadow: 0 4px 10px var(--shadow-color);">
            <div class="container">
                <a class="navbar-brand d-flex align-items-center" href="index.jsp" style="color: var(--header-text);">
                    <i class="bi bi-book me-2" style="font-size: 1.5rem;"></i>
                    <span class="fw-bold">Biblioteca</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"
                        style="border-color: var(--header-text); color: var(--header-text);">
                    <i class="bi bi-list" style="color: var(--header-text);"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp" style="color: var(--header-text);">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="books/list.jsp" style="color: var(--header-text);">Libros</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="loans/list.jsp" style="color: var(--header-text);">Préstamos</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <!-- Hero Section -->
            <div class="hero-section animate__animated animate__fadeIn">
                <div class="row align-items-center hero-content">
                    <div class="col-lg-7">
                        <h1 class="display-4 fw-bold mb-3">Biblioteca Municipal De Miraflores</h1>
                        <p class="lead mb-4">Bienvenido al sistema de gestion de bilioteca.</p>
                        <div class="d-flex flex-wrap gap-2">
                            <a href="books/list.jsp" class="btn btn-light btn-lg px-4 me-md-2">
                                <i class="bi bi-book me-2"></i>Explorar Libros
                            </a>
                            <a href="loans/list.jsp" class="btn btn-outline-light btn-lg px-4">
                                <i class="bi bi-arrow-left-right me-2"></i>Gestionar Préstamos
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-5 d-none d-lg-block text-center">
                        <div class="book-animation">
                            <i class="bi bi-book-half" style="font-size: 10rem; opacity: 0.8;"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Dashboard Section -->
            <div class="row g-4 mb-5">
                <div class="col-md-6">
                    <div class="dashboard-item feature-card animate__animated animate__fadeInLeft">
                        <div class="feature-icon">
                            <i class="bi bi-book"></i>
                        </div>
                        <h3>Gestión de Libros</h3>
                        <p class="mb-4">Administre el inventario completo de libros de la biblioteca. Agregue nuevos títulos, actualice información y mantenga un catálogo organizado.</p>
                        <a href="books/list.jsp" class="btn btn-primary">
                            <i class="bi bi-arrow-right-circle me-2"></i>Ver Libros
                        </a>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="dashboard-item feature-card animate__animated animate__fadeInRight">
                        <div class="feature-icon">
                            <i class="bi bi-arrow-left-right"></i>
                        </div>
                        <h3>Gestión de Préstamos</h3>
                        <p class="mb-4">Administre los préstamos de libros a los usuarios. Registre nuevos préstamos, controle devoluciones y mantenga un historial completo.</p>
                        <a href="loans/list.jsp" class="btn btn-primary">
                            <i class="bi bi-arrow-right-circle me-2"></i>Ver Préstamos
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Stats Section -->
            <div class="stats-section animate__animated animate__fadeIn">
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="stat-item">
                            <div class="stat-number">500+</div>
                            <div class="stat-label">Libros Disponibles</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-item">
                            <div class="stat-number">100+</div>
                            <div class="stat-label">Préstamos Mensuales</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-item">
                            <div class="stat-number">24/7</div>
                            <div class="stat-label">Acceso al Sistema</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Features Section -->
            <h2 class="text-center mb-4 mt-5">Características Principales</h2>
            <div class="row g-4 mb-5">
                <div class="col-md-4">
                    <div class="feature-card animate__animated animate__fadeInUp">
                        <div class="text-center mb-3">
                            <i class="bi bi-search feature-icon" style="font-size: 2rem;"></i>
                        </div>
                        <h4 class="text-center">Búsqueda Avanzada</h4>
                        <p class="text-center">Encuentre rápidamente cualquier libro en el inventario con nuestro sistema de búsqueda avanzada.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card animate__animated animate__fadeInUp" style="animation-delay: 0.2s;">
                        <div class="text-center mb-3">
                            <i class="bi bi-graph-up feature-icon" style="font-size: 2rem;"></i>
                        </div>
                        <h4 class="text-center">Reportes Detallados</h4>
                        <p class="text-center">Genere informes completos sobre el estado de su biblioteca y los préstamos realizados.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card animate__animated animate__fadeInUp" style="animation-delay: 0.4s;">
                        <div class="text-center mb-3">
                            <i class="bi bi-bell feature-icon" style="font-size: 2rem;"></i>
                        </div>
                        <h4 class="text-center">Notificaciones</h4>
                        <p class="text-center">Reciba alertas sobre devoluciones pendientes y nuevas adquisiciones de libros.</p>
                    </div>
                </div>
            </div>
            
            <!-- Testimonials -->
            <h2 class="text-center mb-4">Opiniones de Usuarios</h2>
            <div class="row g-4 mb-5">
                <div class="col-md-6">
                    <div class="testimonial animate__animated animate__fadeIn">
                        <p class="mb-3"><i class="bi bi-quote me-2"></i>Este sistema ha revolucionado la forma en que administramos nuestra biblioteca. Ahora todo es más rápido y eficiente.</p>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-person-circle me-2" style="font-size: 2rem;"></i>
                            <div>
                                <h5 class="mb-0">Carlos Parra</h5>
                                <small>Bibliotecario</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="testimonial animate__animated animate__fadeIn" style="animation-delay: 0.3s;">
                        <p class="mb-3"><i class="bi bi-quote me-2"></i>La gestión de préstamos nunca había sido tan sencilla. Recomiendo este sistema a todas las bibliotecas.</p>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-person-circle me-2" style="font-size: 2rem;"></i>
                            <div>
                                <h5 class="mb-0">Gustavo Petro</h5>
                                <small>Director de Biblioteca</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- CTA Section -->
            <div class="cta-section animate__animated animate__fadeIn">
                <h2 class="mb-4">¿Listo para comenzar?</h2>
                <p class="lead mb-4">Explore todas las funcionalidades que nuestro sistema de gestión de biblioteca tiene para ofrecer.</p>
                <div class="d-flex justify-content-center gap-3 flex-wrap">
                    <a href="books/list.jsp" class="btn btn-light btn-lg">Explorar Catálogo</a>
                    <a href="loans/list.jsp" class="btn btn-outline-light btn-lg">Gestionar Préstamos</a>
                </div>
            </div>
            
            <!-- About Section -->
            <div class="row mt-5 g-4 align-items-center">
                <div class="col-lg-6">
                    <h2>Acerca de la Biblioteca</h2>
                    <p class="lead">Nuestra misión es promover el conocimiento y la cultura a través del acceso a la información.</p>
                    <p>La biblioteca ofrece una amplia variedad de libros para préstamo a nuestros usuarios. Contamos con títulos de diversas categorías, desde literatura clásica hasta las últimas publicaciones científicas y tecnológicas.</p>
                    <p>Promovemos la lectura y el acceso a la información como pilares fundamentales para el desarrollo personal y profesional de nuestra comunidad.</p>
                </div>
                <div class="col-lg-6">
                    <div class="feature-card p-4 animate__animated animate__fadeInRight">
                        <h4 class="mb-3">Horario de Atención</h4>
                        <ul class="list-group list-group-flush" style="background-color: transparent;">
                            <li class="list-group-item d-flex justify-content-between align-items-center" style="background-color: transparent; border-color: var(--table-border);">
                                Lunes a Viernes
                                <span>8:00 AM - 8:00 PM</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center" style="background-color: transparent; border-color: var(--table-border);">
                                Sábados
                                <span>9:00 AM - 5:00 PM</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center" style="background-color: transparent; border-color: var(--table-border);">
                                Domingos
                                <span>Cerrado</span>
                            </li>
                        </ul>
                        <div class="mt-3">
                            <h4 class="mb-3">Contacto</h4>
                            <p><i class="bi bi-envelope me-2"></i> bibliotecamiraflores25@gmail.com</p>
                            <p><i class="bi bi-telephone me-2"></i>+57 3103915561</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Footer mejorado -->
        <footer class="mt-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-md-4">
                        <h5><i class="bi bi-book me-2"></i>Biblioteca</h5>
                        <p>Sistema de Gestión de Libros</p>
                    </div>
                    <div class="col-md-4">
                        <h5>Enlaces Rápidos</h5>
                        <ul class="list-unstyled">
                            <li><a href="index.jsp" style="color: var(--nav-link);">Inicio</a></li>
                            <li><a href="books/list.jsp" style="color: var(--nav-link);">Libros</a></li>
                            <li><a href="loans/list.jsp" style="color: var(--nav-link);">Préstamos</a></li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h5>Síguenos</h5>
                        <div class="d-flex gap-3 fs-4">
                            <a href="#" style="color: var(--nav-link);"><i class="bi bi-facebook"></i></a>
                            <a href="#" style="color: var(--nav-link);"><i class="bi bi-twitter"></i></a>
                            <a href="#" style="color: var(--nav-link);"><i class="bi bi-instagram"></i></a>
                        </div>
                    </div>
                </div>
                <hr style="border-color: var(--table-border);">
                <p class="text-center">&copy; 2025 Biblioteca Municipal De Miraflores - Sistema de Gestión</p>
            </div>
        </footer>
        
        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <!-- Script para animaciones al hacer scroll -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Función para verificar si un elemento está en el viewport
                function isInViewport(element) {
                    const rect = element.getBoundingClientRect();
                    return (
                        rect.top >= 0 &&
                        rect.left >= 0 &&
                        rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
                        rect.right <= (window.innerWidth || document.documentElement.clientWidth)
                    );
                }
                
                // Función para animar elementos cuando son visibles
                function animateOnScroll() {
                    const animatedElements = document.querySelectorAll('.animate__animated');
                    
                    animatedElements.forEach(element => {
                        if (isInViewport(element) && !element.classList.contains('animate__fadeIn')) {
                            element.classList.add('animate__fadeIn');
                        }
                    });
                }
                
                // Ejecutar al cargar la página y al hacer scroll
                animateOnScroll();
                window.addEventListener('scroll', animateOnScroll);
            });
        </script>
    </body>
</html>
