<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroManager"%>
<%@page import="sena.adso.sistema_gestion_libros.model.Loan"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Eliminar Préstamo - Sistema de Biblioteca</title>
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
        <h1>Eliminar Prestamos</h1>
        <i class="text-muted">Un mundo hiperconectado necesita historias que nos vuelvan humanos.</i>
    </header>

    <nav class="text-center">
        <ul class="mb-4">
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="../books/list.jsp">Libros</a></li>
            <li><a href="list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
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
                    
                    // Verificar si se envió el formulario (confirmación)
                    if (request.getMethod().equals("POST")) {
                        // Implementación directa de la eliminación del préstamo
                        boolean eliminado = false;
                        
                        // Si el préstamo está activo, devolverlo primero
                        if (prestamo.isActivo()) {
                            manager.devolverLibro(loanId);
                        }
                        
                        // Eliminar el préstamo manualmente de la lista
                        ArrayList<Loan> prestamos = manager.getTodosLosPrestamos();
                        for (int i = 0; i < prestamos.size(); i++) {
                            if (prestamos.get(i).getId() == loanId) {
                                prestamos.remove(i);
                                eliminado = true;
                                break;
                            }
                        }
                        
                        if (eliminado) {
                            // Préstamo eliminado exitosamente, redirigir a la página de lista
                            response.sendRedirect("list.jsp?action=delete");
                        } else {
                            // Error al eliminar el préstamo
                            %>
                            <div class="alert alert-danger mb-4">
                                <p>Error al eliminar el préstamo. Por favor, inténtelo de nuevo.</p>
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
                        <p class="alert alert-warning">¿Está seguro que desea eliminar este préstamo?</p>
                        
                        <div class="mb-3">
                            <strong>ID del Préstamo:</strong> <%= prestamo.getId() %>
                        </div>
                        <div class="mb-3">
                            <strong>Libro:</strong> <%= prestamo.getLibro().getTitulo() %>
                        </div>
                        <div class="mb-3">
                            <strong>Prestatario:</strong> <%= prestamo.getNombrePrestatario() %> (<%= prestamo.getIdPrestatario() %>)
                        </div>
                        <div class="mb-3">
                            <strong>Fecha de Préstamo:</strong> <%= fechaPrestamo %>
                        </div>
                        <div class="mb-3">
                            <strong>Fecha Límite:</strong> <%= fechaLimite %>
                        </div>
                        <div class="mb-3">
                            <strong>Fecha de Devolución:</strong> <%= fechaDevolucion %>
                        </div>
                        <div class="mb-3">
                            <strong>Estado:</strong> 
                            <% if (prestamo.isActivo()) { %>
                                <% if (prestamo.estaVencido()) { %>
                                    <span class="badge bg-danger">Vencido</span>
                                <% } else { %>
                                    <span class="badge bg-warning">Activo</span>
                                <% } %>
                            <% } else { %>
                                <span class="badge bg-success">Devuelto</span>
                            <% } %>
                        </div>

                        <form action="delete.jsp" method="post" class="mt-4">
                            <input type="hidden" name="id" value="<%= prestamo.getId() %>">
                            
                            <div class="text-center">
                                <button type="submit" class="btn btn-danger">Confirmar Eliminación</button>
                                <a href="list.jsp" class="btn btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6 text-center">
                <img src="../img/loan.png" alt="Imagen de préstamo" class="img-fluid rounded" style="max-height: 350px;">
                <div class="mt-3">
                    <div class="alert alert-info">
                        <p><strong>Nota:</strong> Si el préstamo está activo, el libro será devuelto automáticamente antes de eliminar el registro.</p>
                        <p>Esta acción no se puede deshacer.</p>
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
