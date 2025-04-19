<%@page import="sena.adso.sistema_gestion_libros.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Eliminar Libro - Sistema de Biblioteca</title>
    <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
    <link rel="stylesheet" href="../css/styles.css">
    <%-- Incluir scripts y estilos para tema --%>
    <%@ include file="/includes/theme-script.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../js/sweetalert-utils.js"></script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Eliminar Libro</h1>
        <p class="text-muted">Vivimos tiempos complejos, por eso leemos historias valientes.</p>
    </header>

    <nav class="text-center">
        <ul class="mb-4">
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="list.jsp">Libros</a></li>
            <li><a href="../loans/list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <%
                    // Obtener el gestor de libros
                    LibroManager manager = LibroManager.getInstance();
                    
                    // Obtener el ISBN del libro de la solicitud
                    String isbn = request.getParameter("isbn");
                    
                    if (isbn == null || isbn.trim().isEmpty()) {
                        // ISBN inválido, redirigir a la página de lista
                        response.sendRedirect("list.jsp");
                        return;
                    }
                    
                    // Obtener el libro del gestor
                    Libro libro = manager.getLibroPorISBN(isbn);
                    
                    // Verificar si el libro existe
                    if (libro == null) {
                        // Libro no encontrado, redirigir a la página de lista
                        response.sendRedirect("list.jsp");
                        return;
                    }
                    
                    // Verificar si se envió el formulario (confirmación)
                    if (request.getMethod().equals("POST")) {
                        // Intentar eliminar el libro
                        boolean eliminado = manager.eliminarLibro(isbn);
                        
                        if (eliminado) {
                            // Libro eliminado exitosamente, redirigir a la página de lista
                            response.sendRedirect("list.jsp?action=delete");
                        } else {
                            // El libro no se pudo eliminar (probablemente porque está en préstamo)
                %>
                            <div class="alert alert-danger mb-4 text-center">
                                <p>No se puede eliminar el libro porque está actualmente en préstamo.</p>                                
                            </div>
                            <div>
                                <img src="../img/book.png" alt="Eliminar libro" class="img-fluid rounded" style="max-height: 350px;">
                            </div>
                            <div class="text-center mb-4">
                                <a href="list.jsp" class="btn btn-primary">Volver a la lista</a>
                            </div>
                <%
                        }
                        return;
                    }
                %>

                <div class="card">
                    <div class="card-header bg-danger text-white">
                        <h3 class="mb-0">Confirmar Eliminación</h3>
                    </div>
                    <div class="card-body">
                        <p class="alert alert-warning">¿Está seguro que desea eliminar este libro?</p>
                        
                        <div class="mb-3">
                            <strong>ISBN:</strong> <%= libro.getIsbn() %>
                        </div>
                        <div class="mb-3">
                            <strong>Título:</strong> <%= libro.getTitulo() %>
                        </div>
                        <div class="mb-3">
                            <strong>Autor:</strong> <%= libro.getAutor() %>
                        </div>
                        <div class="mb-3">
                            <strong>Tipo:</strong> <%= libro.getTipo() %>
                        </div>
                        <div class="mb-3">
                            <strong>Año de Publicación:</strong> <%= libro.getAñoPublicacion() %>
                        </div>
                        <div class="mb-3">
                            <strong>Disponible:</strong> <%= libro.isDisponible() ? "Sí" : "No" %>
                        </div>
                        <div class="mb-3">
                            <strong>Descripción:</strong> <%= libro.getDescripcion() %>
                        </div>
                        
                        <form action="delete.jsp" method="post" class="mt-4">
                            <input type="hidden" name="isbn" value="<%= libro.getIsbn() %>">
                            
                            <div class="text-center">
                                <button type="submit" class="btn btn-danger">Confirmar Eliminación</button>
                                <a href="list.jsp" class="btn btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6 text-center">
                <img src="../img/book.png" alt="Eliminar libro" class="img-fluid rounded" style="max-height: 350px;">
                <div class="mt-3">
                    <div class="alert alert-info">
                        <p><strong>Nota:</strong> La eliminación de un libro es permanente y no se puede deshacer.</p>
                        <p>No se pueden eliminar libros que estén actualmente en préstamo.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Biblioteca Municipal De Miraflores - Sistema de Gestión</p>
    </footer>
</body>
</html>
