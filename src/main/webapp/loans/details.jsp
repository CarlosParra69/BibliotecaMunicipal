<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroFiccion"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroNoFiccion"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroReferencia"%>
<%@page import="sena.adso.sistema_gestion_libros.model.Libro"%>
<%@page import="sena.adso.sistema_gestion_libros.model.Loan"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Detalles del Préstamo - Sistema de Biblioteca</title>
    <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
    <link rel="stylesheet" href="../css/styles.css">
    <%-- Incluir scripts y estilos para tema --%>
    <%@ include file="/includes/theme-script.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Biblioteca</h1>
        <p>Detalles del Préstamo</p>
    </header>

    <nav class="text-center">
        <ul class="mb-4">
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="../books/list.jsp">Libros</a></li>
            <li><a href="list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <%
            // Obtener el gestor de libros
            LibroManager manager = LibroManager.getInstance();
            
            // Obtener el ID del préstamo de la solicitud
            int loanId = 0;
            try {
                loanId = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                // ID inválido, redirigir a la página de lista
                response.sendRedirect("list.jsp");
                return;
            }
            
            // Obtener el préstamo del gestor
            Loan prestamo = manager.getPrestamoPorId(loanId);
            
            // Verificar si el préstamo existe
            if (prestamo == null) {
                // Préstamo no encontrado, redirigir a la página de lista
                response.sendRedirect("list.jsp");
                return;
            }
            
            // Formatear las fechas
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            String fechaPrestamo = sdf.format(prestamo.getFechaPrestamo());
            String fechaLimite = sdf.format(prestamo.getFechaLimite());
            String fechaDevolucion = prestamo.getFechaDevolucion() != null ? sdf.format(prestamo.getFechaDevolucion()) : "No devuelto";
            
            // Obtener el libro
            Libro libro = prestamo.getLibro();
            
            // Calcular días restantes o días de retraso
            long diasRestantes = 0;
            long diasRetraso = 0;
            
            if (prestamo.isActivo()) {
                Date hoy = new Date();
                if (hoy.before(prestamo.getFechaLimite())) {
                    // Días restantes
                    diasRestantes = Math.round((prestamo.getFechaLimite().getTime() - hoy.getTime()) / (1000.0 * 60 * 60 * 24));
                } else {
                    // Días de retraso
                    diasRetraso = Math.round((hoy.getTime() - prestamo.getFechaLimite().getTime()) / (1000.0 * 60 * 60 * 24));
                }
            }
        %>
        
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Detalles del Préstamo #<%= prestamo.getId() %></h3>
                    </div>
                    <div class="card-body">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h4>Información del Préstamo</h4>
                                <p><strong>ID del Préstamo:</strong> <%= prestamo.getId() %></p>
                                <p>
                                    <strong>Estado:</strong> 
                                    <% if (prestamo.isActivo()) { %>
                                        <% if (prestamo.estaVencido()) { %>
                                            <span class="badge bg-danger">Vencido (<%=diasRetraso%> días de retraso)</span>
                                        <% } else { %>
                                            <span class="badge bg-success">Activo (<%=diasRestantes%> días restantes)</span>
                                        <% } %>
                                    <% } else { %>
                                        <span class="badge bg-secondary">Devuelto</span>
                                    <% } %>
                                </p>
                                <p><strong>Fecha de Préstamo:</strong> <%= fechaPrestamo %></p>
                                <p><strong>Fecha Límite:</strong> <%= fechaLimite %></p>
                                <p><strong>Fecha de Devolución:</strong> <%= fechaDevolucion %></p>
                            </div>
                            <div class="col-md-6">
                                <h4>Información del Prestatario</h4>
                                <p><strong>Nombre:</strong> <%= prestamo.getNombrePrestatario() %></p>
                                <p><strong>ID:</strong> <%= prestamo.getIdPrestatario() %></p>
                            </div>
                        </div>
                        
                        <div class="card mb-4">
                            <div class="card-header bg-light">
                                <h4 class="mb-0">Información del Libro</h4>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>ISBN:</strong> <%= libro.getIsbn() %></p>
                                        <p><strong>Título:</strong> <%= libro.getTitulo() %></p>
                                        <p><strong>Autor:</strong> <%= libro.getAutor() %></p>
                                        <p><strong>Tipo:</strong> <%= libro.getTipo() %></p>
                                        <p><strong>Año de Publicación:</strong> <%= libro.getAñoPublicacion() %></p>
                                    </div>
                                    <div class="col-md-6">
                                        <% if (libro instanceof LibroFiccion) { %>
                                            <% LibroFiccion libroFiccion = (LibroFiccion) libro; %>
                                            <p><strong>Género:</strong> <%= libroFiccion.getGenero() %></p>
                                            <p><strong>Parte de una serie:</strong> <%= libroFiccion.isEsSerie() ? "Sí" : "No" %></p>
                                        <% } else if (libro instanceof LibroNoFiccion) { %>
                                            <% LibroNoFiccion libroNoFiccion = (LibroNoFiccion) libro; %>
                                            <p><strong>Tema:</strong> <%= libroNoFiccion.getTema() %></p>
                                            <p><strong>Nivel Académico:</strong> <%= libroNoFiccion.getNivelAcademico() %></p>
                                        <% } else if (libro instanceof LibroReferencia) { %>
                                            <% LibroReferencia libroReferencia = (LibroReferencia) libro; %>
                                            <p><strong>Tipo de Referencia:</strong> <%= libroReferencia.getTipoReferencia() %></p>
                                            <p><strong>Actualizaciones:</strong> <%= libroReferencia.getActualizaciones() %></p>
                                        <% } %>
                                        <p><strong>Descripción:</strong> <%= libro.getDescripcion() %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-center mt-4">
                            <img src="../img/loan.png" alt="Imagen de préstamo" class="img-fluid rounded" style="max-height: 200px;">
                        </div>
                        
                        <div class="text-center mt-4">
                            <a href="list.jsp" class="btn btn-secondary">Volver a la Lista</a>
                            
                            <% if (prestamo.isActivo()) { %>
                                <a href="return.jsp?id=<%= prestamo.getId() %>" class="btn btn-success">Marcar como Devuelto</a>
                                <% if (prestamo.estaVencido()) { %>
                                    <div class="alert alert-danger mt-3">
                                        <strong>¡Atención!</strong> Este préstamo está vencido por <%= diasRetraso %> días.
                                    </div>
                                <% } %>
                            <% } else { %>
                                <div class="alert alert-success mt-3">
                                    <strong>Información:</strong> Este libro fue devuelto el <%= fechaDevolucion %>.
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html>
