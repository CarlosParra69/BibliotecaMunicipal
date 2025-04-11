<%@page import="sena.adso.sistema_gestion_libros.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Libros - Sistema de Biblioteca</title>
        <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
        <link rel="stylesheet" href="../css/styles.css">
        <%-- Incluir scripts y estilos para tema --%>
        <%@ include file="/includes/theme-script.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="../js/sweetalert-utils.js"></script>
        <script>
            function showAlert(action) {
                switch (action) {
                    case 'add':
                        showSuccessAlert('¡Éxito!', 'Libro agregado exitosamente', '#28a745');
                        break;
                    case 'edit':
                        showSuccessAlert('¡Éxito!', 'Libro actualizado exitosamente', '#ffc107');
                        break;
                    case 'delete':
                        showSuccessAlert('¡Éxito!', 'Libro eliminado exitosamente', '#dc3545');
                        break;
                    default:
                        break;
                }
            }
            
            // Verificar si hay un parámetro de acción en la URL
            window.onload = function() {
                const urlParams = new URLSearchParams(window.location.search);
                const action = urlParams.get('action');
                if (action) {
                    showAlert(action);
                }
            };
        </script>
    </head>
    <body>
        <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
        <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
        <header>
            <h1>Biblioteca</h1>
            <p>Gestión de Libros</p>
        </header>

        <nav class="text-center">
            <ul class="mb-4">
                <li><a href="../index.jsp">Inicio</a></li>
                <li><a href="list.jsp">Libros</a></li>
                <li><a href="../loans/list.jsp">Préstamos</a></li>
            </ul>
        </nav>

        <div class="container">
            <%
                // Obtener el gestor de libros
                LibroManager manager = LibroManager.getInstance();
                
                // Obtener todos los libros
                ArrayList<Libro> todosLosLibros = manager.getTodosLosLibros();
                
                // Obtener libros disponibles
                ArrayList<Libro> librosDisponibles = manager.getLibrosDisponibles();
                
                // Calcular el número de libros disponibles
                int numLibrosDisponibles = librosDisponibles.size();
                
                // Obtener los últimos 3 libros agregados (o menos si no hay suficientes)
                ArrayList<Libro> ultimosLibros = new ArrayList<>();
                int numUltimosLibros = Math.min(todosLosLibros.size(), 3);
                for (int i = 0; i < numUltimosLibros; i++) {
                    ultimosLibros.add(todosLosLibros.get(todosLosLibros.size() - 1 - i));
                }
            %>
            
            <h2>Gestión de Libros</h2>
            <div class="alert alert-info" role="alert">
                <strong>Total de Libros Disponibles:</strong> <%= numLibrosDisponibles %>
            </div>

            <div class="container mt-4">
                <div class="row align-items-center">
                    <!-- Columna del formulario -->
                    <div class="col-md-6">
                        <!-- Historial de libro -->
                        <div class="mt-2">
                            <h4>Últimos Libros Agregados</h4>
                            <div class="table-responsive">
                                <table class="table table-sm table-bordered">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Libro</th>
                                            <th>Autor</th>
                                            <th>Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (ultimosLibros.isEmpty()) { %>
                                            <tr>
                                                <td colspan="3" class="text-center">No hay libros registrados</td>
                                            </tr>
                                        <% } else { %>
                                            <% for (Libro libro : ultimosLibros) { %>
                                                <tr>
                                                    <td><%= libro.getTitulo() %></td>
                                                    <td><%= libro.getAutor() %></td>
                                                    <td>
                                                        <% if (libro.isDisponible()) { %>
                                                            <span class="badge bg-success">Disponible</span>
                                                        <% } else { %>
                                                            <% 
                                                                // Verificar si el libro está en préstamo o simplemente no disponible
                                                                boolean estaEnPrestamo = false;
                                                                for (Loan prestamo : manager.getPrestamosActivos()) {
                                                                    if (prestamo.getLibro().getIsbn().equals(libro.getIsbn())) {
                                                                        estaEnPrestamo = true;
                                                                        break;
                                                                    }
                                                                }
                                                                
                                                                if (estaEnPrestamo) {
                                                            %>
                                                                <span class="badge bg-warning">Prestado</span>
                                                            <% } else { %>
                                                                <span class="badge bg-danger">No Disponible</span>
                                                            <% } %>
                                                        <% } %>
                                                    </td>
                                                </tr>
                                            <% } %>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <div class="text-muted small">
                                <em>Total de libros: <%= todosLosLibros.size() %></em>
                            </div>
                        </div>
                        <div class="mt-3">
                            <a href="add.jsp" class="btn btn-success">Agregar Nuevo Libro</a>
                        </div>
                        <br>
                    </div>
                    <!-- Columna de la imagen -->
                    <div class="col-md-6 text-center">
                        <img src="../img/book.png" alt="Imagen descriptiva" class="img-fluid rounded" style="max-height: 350px;">
                        <div class="mt-3">
                            <div class="alert alert-light">
                                <p><strong>Gestión de Biblioteca</strong></p>
                                <p>Administre su colección de libros de manera eficiente.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <h2>Lista de Libros</h2>
            
            <% if (todosLosLibros.isEmpty()) { %>
                <div class="alert alert-warning">
                    <p>No hay libros registrados en el sistema.</p>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ISBN</th>
                                <th>Título</th>
                                <th>Autor</th>
                                <th>Tipo</th>
                                <th>Año de Publicacion</th>
                                <th>Estado</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Libro libro : todosLosLibros) { %>
                                <tr>
                                    <td><%= libro.getIsbn() %></td>
                                    <td><%= libro.getTitulo() %></td>
                                    <td><%= libro.getAutor() %></td>  
                                    <td><%= libro.getTipo() %></td>
                                    <td class="text-center">
                                        <% if (libro.getAñoPublicacion() != null && !libro.getAñoPublicacion().equals("Sin información") && !libro.getAñoPublicacion().equals("null")) { %>
                                            <%= libro.getAñoPublicacion() %>
                                        <% } else { %>
                                            <span class="text-muted">Sin información</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (libro.isDisponible()) { %>
                                            <span class="badge bg-success">Disponible</span>
                                        <% } else { %>
                                            <% 
                                                // Verificar si el libro está en préstamo o simplemente no disponible
                                                boolean estaEnPrestamo = false;
                                                for (Loan prestamo : manager.getPrestamosActivos()) {
                                                    if (prestamo.getLibro().getIsbn().equals(libro.getIsbn())) {
                                                        estaEnPrestamo = true;
                                                        break;
                                                    }
                                                }
                                                
                                                if (estaEnPrestamo) {
                                            %>
                                                <span class="badge bg-warning">Prestado</span>
                                            <% } else { %>
                                                <span class="badge bg-danger">No Disponible</span>
                                            <% } %>
                                        <% } %>
                                    </td>
                                    <td>
                                        <div class="text-center" role="group">
                                            <% if (libro.isDisponible()) { %>
                                                <a href="../loans/add.jsp?isbn=<%= libro.getIsbn() %>" class="btn btn-primary btn-sm">Prestar</a>
                                            <% } %>
                                            <a href="edit.jsp?isbn=<%= libro.getIsbn() %>" class="btn btn-warning btn-sm">Editar</a>
                                            <a href="delete.jsp?isbn=<%= libro.getIsbn() %>" class="btn btn-danger btn-sm">Eliminar</a>
                                           
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>

        <footer>
            <p>&copy; 2025 Sistema de Biblioteca</p>
        </footer>
    </body>
</html>
