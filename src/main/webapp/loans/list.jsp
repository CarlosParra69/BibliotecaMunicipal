<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="sena.adso.sistema_gestion_libros.model.Loan"%>
<%@page import="sena.adso.sistema_gestion_libros.model.Libro"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroManager"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Préstamos - Sistema de Biblioteca</title>
    <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/styles.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.bootstrap5.min.css">
    <%-- Incluir scripts y estilos para tema --%>
    <%@ include file="/includes/theme-script.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    <!-- jQuery, requerido para DataTables -->
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
    <!-- DataTables Buttons -->
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.colVis.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../js/sweetalert-utils.js"></script>
    <script>
        function showAlert(action) {
            switch (action) {
                case 'add':
                    showSuccessAlert('¡Éxito!', 'Préstamo registrado exitosamente', '#28a745');
                    break;
                case 'edit':
                    showSuccessAlert('¡Éxito!', 'Préstamo actualizado exitosamente', '#ffc107');
                    break;
                case 'delete':
                    showSuccessAlert('¡Éxito!', 'Préstamo eliminado exitosamente', '#dc3545');
                    break;
                case 'return':
                    showSuccessAlert('¡Éxito!', 'Libro devuelto exitosamente', '#17a2b8');
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
            
            // Inicializar DataTables con botones de exportación
            $('#tablaPrestamos').DataTable({
                responsive: true,
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'collection',
                        text: 'Exportar',
                        className: 'btn-sm btn-outline-primary',
                        buttons: [
                            {
                                extend: 'copy',
                                text: 'Copiar',
                                className: 'btn-sm'
                            },
                            {
                                extend: 'excel',
                                text: 'Excel',
                                className: 'btn-sm'
                            },
                            {
                                extend: 'pdf',
                                text: 'PDF',
                                className: 'btn-sm'
                            },
                            {
                                extend: 'print',
                                text: 'Imprimir',
                                className: 'btn-sm'
                            }
                        ]
                    },
                    {
                        extend: 'colvis',
                        text: 'Columnas',
                        className: 'btn-sm btn-outline-secondary'
                    }
                ],
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.13.7/i18n/es-ES.json'
                }
            });
        };
    </script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Gestion de Prestamos</h1>
        <i class="text-muted">Lee lo que el mundo siente, escribe lo que el mundo calla.</i>
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
            
            // Obtener todos los préstamos
            ArrayList<Loan> todosLosPrestamos = manager.getTodosLosPrestamos();
            
            // Obtener préstamos activos
            ArrayList<Loan> prestamosActivos = manager.getPrestamosActivos();
            
            // Calcular el número de préstamos pendientes
            int numPrestamosPendientes = prestamosActivos.size();
            
            // Obtener los últimos 3 préstamos (o menos si no hay suficientes)
            ArrayList<Loan> ultimosPrestamos = new ArrayList<>();
            int numUltimosPrestamos = Math.min(todosLosPrestamos.size(), 3);
            for (int i = 0; i < numUltimosPrestamos; i++) {
                ultimosPrestamos.add(todosLosPrestamos.get(todosLosPrestamos.size() - 1 - i));
            }
            
            // Formatear las fechas
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        %>
        
        <h2>Gestión de Préstamos</h2>
        <div class="alert alert-info" role="alert">
            <strong>Total de préstamos pendientes:</strong> <%= numPrestamosPendientes %>
        </div>

        <div class="container mt-4">
            <div class="row align-items-center">
                <!-- Columna del historial -->
                <div class="col-md-6">
                    <!-- Historial de préstamos -->
                    <div class="mt-2">
                        <h4>Últimos Préstamos</h4>
                        <div class="table-responsive">
                            <table class="table table-sm table-bordered">
                                <thead class="table-light">
                                    <tr>
                                        <th>Libro</th>
                                        <th>Fecha</th>
                                        <th>Estado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (ultimosPrestamos.isEmpty()) { %>
                                        <tr>
                                            <td colspan="3" class="text-center">No hay préstamos registrados</td>
                                        </tr>
                                    <% } else { %>
                                        <% for (Loan prestamo : ultimosPrestamos) { %>
                                            <tr>
                                                <td><%= prestamo.getLibro().getTitulo() %></td>
                                                <td><%= sdf.format(prestamo.getFechaPrestamo()) %></td>
                                                <td>
                                                    <% if (prestamo.isActivo()) { %>
                                                        <% if (prestamo.estaVencido()) { %>
                                                            <span class="badge bg-danger">Vencido</span>
                                                        <% } else { %>
                                                            <span class="badge bg-warning">Pendiente</span>
                                                        <% } %>
                                                    <% } else { %>
                                                        <span class="badge bg-success">Devuelto</span>
                                                    <% } %>
                                                </td>
                                            </tr>
                                        <% } %>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                        <div class="text-muted small">
                            <em>Total de préstamos históricos: <%= todosLosPrestamos.size() %></em>
                        </div>
                    </div>                  
                    <div class="mt-3">
                        <a href="add.jsp" class="btn btn-success">Realizar Préstamo</a>
                    </div>
                    <br>
                </div>

                <!-- Columna de la imagen -->
                <div class="col-md-6 text-center">
                    <img src="../img/loan.png" alt="Imagen de préstamo" class="img-fluid rounded" style="max-height: 350px;">
                    <div class="mt-3">
                        <div class="alert alert-light">
                            <p><strong>Gestión de Préstamos</strong></p>
                            <p>Administre los préstamos de libros de manera eficiente.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>            
        <% if (todosLosPrestamos.isEmpty()) { %>
            <div class="alert alert-warning">
                <p>No hay préstamos registrados en el sistema.</p>
            </div>
        <% } else { %>
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h3 class="card-title mb-0">Registro de Préstamos</h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="tablaPrestamos" class="table table-striped table-hover" style="width:100%">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>ISBN</th>
                                    <th>Título</th>
                                    <th>Prestatario</th>
                                    <th>Fecha Préstamo</th>
                                    <th>Fecha Límite</th>
                                    <th>Estado</th>
                                    <th class="text-center">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Loan prestamo : todosLosPrestamos) { %>
                                    <tr>
                                        <td><%= prestamo.getId() %></td>
                                        <td><%= prestamo.getLibro().getIsbn() %></td>
                                        <td><%= prestamo.getLibro().getTitulo() %></td>
                                        <td><%= prestamo.getNombrePrestatario() %></td>
                                        <td><%= sdf.format(prestamo.getFechaPrestamo()) %></td>
                                        <td><%= sdf.format(prestamo.getFechaLimite()) %></td>
                                        <td>
                                            <% if (prestamo.isActivo()) { %>
                                                <% if (prestamo.estaVencido()) { %>
                                                    <span class="badge bg-danger">Vencido</span>
                                                <% } else { %>
                                                    <span class="badge bg-warning">Pendiente</span>
                                                <% } %>
                                            <% } else { %>
                                                <span class="badge bg-success">Devuelto</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div class="text-center" role="group">
                                                <a href="details.jsp?id=<%= prestamo.getId() %>" class="btn btn-primary btn-sm">Detalles</a>
                                                
                                                <% if (prestamo.isActivo()) { %>
                                                    <a href="return.jsp?id=<%= prestamo.getId() %>" class="btn btn-success btn-sm">Devolver</a>
                                                <% } %>
                                                
                                                <a href="edit.jsp?id=<%= prestamo.getId() %>" class="btn btn-warning btn-sm">Editar</a>
                                                <a href="delete.jsp?id=<%= prestamo.getId() %>" class="btn btn-danger btn-sm">Eliminar</a>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <footer>
        <p>&copy; 2025 Biblioteca Municipal De Miraflores - Sistema de Gestión</p>
    </footer>
</body>
</html>