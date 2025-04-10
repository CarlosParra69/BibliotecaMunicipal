<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sena.adso.sistema_gestion_libros.model.Libro"%>
<%@page import="sena.adso.sistema_gestion_libros.model.Loan"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Agregar Préstamo - Sistema de Biblioteca</title>
    <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
    <link rel="stylesheet" href="../css/styles.css">
    <%-- Incluir scripts y estilos para tema --%>
    <%@ include file="/includes/theme-script.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../js/sweetalert-utils.js"></script>
    <script>
        function validateForm() {
            var returnDate = new Date(document.getElementById('returnDate').value);
            var loanDate = new Date(document.getElementById('loanDate').value);
            
            if (returnDate < loanDate) {
                showErrorAlert('Error en fechas', 'La fecha de devolución debe ser posterior a la fecha de préstamo.');
                return false;
            }
            
            // Validar que la fecha de préstamo no sea anterior a hoy
            var today = new Date();
            today.setHours(0, 0, 0, 0); // Resetear la hora para comparar solo fechas
            
            if (loanDate < today) {
                showErrorAlert('Error en fechas', 'La fecha de préstamo no puede ser anterior a hoy.');
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Biblioteca</h1>
        <p>Agregar Nuevo Préstamo</p>
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
            
            // Verificar si se envió el formulario
            if (request.getMethod().equals("POST")) {
                try {
                    // Obtener datos del formulario
                    String isbn = request.getParameter("isbn");
                    String nombrePrestatario = request.getParameter("nombrePrestatario");
                    String idPrestatario = request.getParameter("idPrestatario");
                    
                    // Calcular días de préstamo
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date fechaPrestamo = sdf.parse(request.getParameter("loanDate"));
                    Date fechaDevolucion = sdf.parse(request.getParameter("returnDate"));
                    
                    long diferencia = fechaDevolucion.getTime() - fechaPrestamo.getTime();
                    int diasPrestamo = (int) (diferencia / (1000 * 60 * 60 * 24));
                    
                    // Crear el préstamo
                    Loan prestamo = manager.crearPrestamo(isbn, nombrePrestatario, idPrestatario, diasPrestamo);
                    
                    if (prestamo != null) {
                        // Préstamo creado exitosamente, redirigir a la página de lista
                        response.sendRedirect("list.jsp?action=add");
                        return;
                    } else {
                        // Error al crear el préstamo (libro no disponible)
        %>
                    <div class="alert alert-danger mb-4">
                        <p>No se pudo crear el préstamo. El libro no está disponible o no existe.</p>
                    </div>
        <%
                    }
                } catch (Exception e) {
        %>
                    <div class="alert alert-danger mb-4">
                        <p>Error al procesar el préstamo: <%= e.getMessage() %></p>
                    </div>
        <%
                }
            }
            
            // Obtener libros disponibles
            ArrayList<Libro> librosDisponibles = manager.getLibrosDisponibles();
            
            // Verificar si hay libros disponibles
            if (librosDisponibles.isEmpty()) {
        %>
                <div class="alert alert-warning mb-4">
                    <p>No hay libros disponibles para préstamo en este momento.</p>
                </div>
                <div class="text-center mb-4">
                    <a href="list.jsp" class="btn btn-primary">Volver a la lista de préstamos</a>
                </div>
        <%
            } else {
                // Verificar si se proporcionó un ISBN en la solicitud (desde la lista de libros)
                String isbnParam = request.getParameter("isbn");
                String selectedIsbn = "";
                
                if (isbnParam != null && !isbnParam.isEmpty()) {
                    selectedIsbn = isbnParam;
                }
                
                // Obtener la fecha actual para los campos de fecha
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String fechaHoy = sdf.format(new Date());
                
                // Calcular fecha predeterminada de devolución (7 días después)
                Calendar cal = Calendar.getInstance();
                cal.add(Calendar.DAY_OF_MONTH, 7);
                String fechaDevolucion = sdf.format(cal.getTime());
        %>
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header bg-success text-white">
                                <h3 class="mb-0">Nuevo Préstamo</h3>
                            </div>
                            <div class="card-body">
                                <form action="add.jsp" method="post" onsubmit="return validateForm();">
                                    <div class="mb-3">
                                        <label for="isbn" class="form-label">Libro:</label>
                                        <select class="form-select" id="isbn" name="isbn" required>
                                            <option value="">Seleccione un libro</option>
                                            <% for (Libro libro : librosDisponibles) { %>
                                                <option value="<%= libro.getIsbn() %>" <%= libro.getIsbn().equals(selectedIsbn) ? "selected" : "" %>>
                                                    <%= libro.getTitulo() %> (<%= libro.getAutor() %>, <%= libro.getTipo() %>)
                                                </option>
                                            <% } %>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="nombrePrestatario" class="form-label">Nombre del Prestatario:</label>
                                        <input type="text" class="form-control" id="nombrePrestatario" name="nombrePrestatario" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="idPrestatario" class="form-label">ID del Prestatario:</label>
                                        <input type="text" class="form-control" id="idPrestatario" name="idPrestatario" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="loanDate" class="form-label">Fecha de Préstamo:</label>
                                        <input type="date" class="form-control" id="loanDate" name="loanDate" value="<%= fechaHoy %>" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="returnDate" class="form-label">Fecha de Devolución:</label>
                                        <input type="date" class="form-control" id="returnDate" name="returnDate" value="<%= fechaDevolucion %>" required>
                                        <small class="text-muted">Fecha límite para devolver el libro (predeterminado: 7 días).</small>
                                    </div>
                                    
                                    <div class="text-center mt-4">
                                        <button type="submit" class="btn btn-success">Crear Préstamo</button>
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
                                <p><strong>Nota:</strong> Los préstamos se registran con la fecha actual por defecto.</p>
                                <p>La fecha de devolución predeterminada es de 7 días a partir de hoy.</p>
                            </div>
                        </div>
                    </div>
                </div>
        <% } %>
    </div>

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html>
