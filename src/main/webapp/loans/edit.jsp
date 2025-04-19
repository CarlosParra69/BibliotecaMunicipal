<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroManager"%>
<%@page import="sena.adso.sistema_gestion_libros.model.Loan"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Editar Préstamo - Sistema de Biblioteca</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
    <%-- Incluir scripts y estilos para tema --%>
    <%@ include file="/includes/theme-script.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../js/sweetalert-utils.js"></script>
    <script>
        function validateForm() {
            return true;
        }
    </script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Editar el Prestamo</h1>
        <i class="text-muted">En tiempos de cambio, las palabras son nuestra revolución más silenciosa.</i>
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
                    
                    // Formatear las fechas para mostrar
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    String fechaPrestamo = sdf.format(prestamo.getFechaPrestamo());
                    String fechaLimite = sdf.format(prestamo.getFechaLimite());
                    
                    // Verificar si se envió el formulario (actualización)
                    if (request.getMethod().equals("POST")) {
                        String nombrePrestatario = request.getParameter("nombrePrestatario");
                        String idPrestatario = request.getParameter("idPrestatario");
                        
                        // Actualizar los campos del préstamo
                        prestamo.setNombrePrestatario(nombrePrestatario);
                        prestamo.setIdPrestatario(idPrestatario);
                        
                        // Redirigir a la página de lista con mensaje de éxito
                        response.sendRedirect("list.jsp?action=edit");
                        return;
                    }
                %>

                <div class="card">
                    <div class="card-header bg-warning text-dark">
                        <h3 class="mb-0">Editar Préstamo Id: <%= prestamo.getId() %></h3>
                    </div>
                    <div class="card-body">
                        <form action="edit.jsp" method="post" onsubmit="return validateForm();">
                            <input type="hidden" name="id" value="<%= prestamo.getId() %>">

                            <div class="mb-3">
                                <label for="bookTitle" class="form-label">Libro:</label>
                                <input type="text" class="form-control" id="bookTitle" value="<%= prestamo.getLibro().getTitulo() %>" readonly>
                                <small class="text-muted">No se puede cambiar el libro del préstamo.</small>
                            </div>

                            <div class="mb-3">
                                <label for="nombrePrestatario" class="form-label">Nombre del Prestatario:</label>
                                <input type="text" class="form-control" id="nombrePrestatario" name="nombrePrestatario" value="<%= prestamo.getNombrePrestatario() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="idPrestatario" class="form-label">Cedula del Prestatario:</label>
                                <input type="text" class="form-control" id="idPrestatario" name="idPrestatario" value="<%= prestamo.getIdPrestatario() %>" required>
                            </div>

                            <div class="mb-3">
                                <label for="loanDate" class="form-label">Fecha de Préstamo:</label>
                                <input type="date" class="form-control" id="loanDate" name="loanDate" value="<%= fechaPrestamo %>" readonly>
                                <small class="text-muted">No se puede cambiar la fecha de préstamo.</small>
                            </div>

                            <div class="mb-3">
                                <label for="returnDate" class="form-label">Fecha de Devolución:</label>
                                <input type="date" class="form-control" id="returnDate" name="returnDate" value="<%= fechaLimite %>" readonly>
                                <small class="text-muted">No se puede cambiar la fecha de devolución.</small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="estado" class="form-label">Estado:</label>
                                <div>
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
                                <small class="text-muted">Para cambiar el estado use las opciones "Devolver" o "Detalles".</small>
                            </div>

                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-warning">Actualizar Préstamo</button>
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
                        <p><strong>Nota:</strong> Solo se pueden editar los datos del prestatario.</p>
                        <p>Para cambiar el estado del préstamo, use las opciones "Devolver" en la lista de préstamos.</p>
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