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
    <title>Devolución de Libro - Sistema de Biblioteca</title>
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
        <h1>Biblioteca</h1>
        <p>Devolución de Libro</p>
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
                    
                    // Obtener el ID del préstamo
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
                    
                    // Verificar si el préstamo existe y está activo
                    if (prestamo == null || !prestamo.isActivo()) {
                        // Préstamo no encontrado o ya devuelto, redirigir a la página de lista
                        response.sendRedirect("list.jsp");
                        return;
                    }
                    
                    // Formatear las fechas
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    String fechaPrestamo = sdf.format(prestamo.getFechaPrestamo());
                    String fechaLimite = sdf.format(prestamo.getFechaLimite());
                    
                    // Fecha actual para la devolución
                    Date fechaActual = new Date();
                    SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
                    String fechaActualStr = sdfInput.format(fechaActual);
                    
                    // Verificar si se envió el formulario
                    if (request.getMethod().equals("POST")) {
                        // Obtener estado del libro y observaciones
                        String estadoLibro = request.getParameter("bookCondition");
                        String observaciones = request.getParameter("observations");
                        
                        // Valor predeterminado para observaciones
                        if (observaciones == null || observaciones.trim().isEmpty()) {
                            observaciones = "Sin observaciones";
                        }
                        
                        // Usar la versión completa de devolverLibro que guarda el estado y las observaciones
                        boolean devuelto = manager.devolverLibro(loanId, estadoLibro, observaciones);
                        
                        if (devuelto) {
                            // Redirigir a la página de lista con mensaje de éxito
                            response.sendRedirect("list.jsp?action=return");
                        } else {
                            // Error al devolver el libro
                %>
                            <div class="alert alert-danger mb-4">
                                <p>Error al devolver el libro. Por favor, inténtelo de nuevo.</p>
                            </div>
                <%
                        }
                        return;
                    }
                %>

                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h3 class="mb-0">Confirmar Devolución</h3>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <strong>ID del Préstamo:</strong> <%= prestamo.getId() %>
                        </div>
                        <div class="mb-3">
                            <strong>Libro:</strong> <%= prestamo.getLibro().getTitulo() %>
                        </div>
                        <div class="mb-3">
                            <strong>Prestatario:</strong> <%= prestamo.getNombrePrestatario() %>
                        </div>
                        <div class="mb-3">
                            <strong>Fecha de Préstamo:</strong> <%= fechaPrestamo %>
                        </div>
                        <div class="mb-3">
                            <strong>Fecha de Devolución Prevista:</strong> <%= fechaLimite %>
                        </div>

                        <form action="return.jsp" method="post" class="mt-4">
                            <input type="hidden" name="id" value="<%= prestamo.getId() %>">
                            
                            <div class="mb-3">
                                <label for="actualReturnDate" class="form-label">Fecha de Devolución Real:</label>
                                <input type="date" class="form-control" id="actualReturnDate" name="actualReturnDate" value="<%= fechaActualStr %>" readonly>
                                <small class="text-muted">La fecha de devolución será la fecha actual.</small>
                            </div>

                            <div class="mb-3">
                                <label for="bookCondition" class="form-label">Estado del Libro:</label>
                                <select class="form-select" id="bookCondition" name="bookCondition" required>
                                    <option value="bueno" selected>Bueno</option>
                                    <option value="dañado">Dañado</option>
                                    <option value="perdido">Perdido</option>
                                </select>
                                <small class="text-muted">(Esta información se guardará cuando el sistema sea actualizado)</small>
                            </div>

                            <div class="mb-3">
                                <label for="observations" class="form-label">Observaciones:</label>
                                <textarea class="form-control" id="observations" name="observations" rows="3"></textarea>
                                <small class="text-muted">(Esta información se guardará cuando el sistema sea actualizado)</small>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-info text-white">Confirmar Devolución</button>
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
                        <p><strong>Nota:</strong> Al confirmar la devolución, el libro estará disponible para nuevos préstamos.</p>
                        <% if (prestamo.estaVencido()) { %>
                            <p class="text-danger"><strong>¡Atención!</strong> Este préstamo está vencido.</p>
                        <% } %>
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