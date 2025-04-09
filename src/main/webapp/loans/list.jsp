<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Préstamos - Sistema de Biblioteca</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    <script>
        function validateForm() {
            var returnDate = new Date(document.getElementById('returnDate').value);
            var loanDate = new Date(document.getElementById('loanDate').value);
            
            if (returnDate < loanDate) {
                alert('La fecha de devolución debe ser posterior a la fecha de préstamo.');
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <header>
        <h1>Biblioteca</h1>
        <p>Gestión de Préstamos</p>
    </header>

    <nav class="text-center">
        <ul class="mb-4">
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="../books/list.jsp">Libros</a></li>
            <li><a href="list.jsp">Préstamos</a></li>
        </ul>
    </nav>
    <%
                            // Aquí normalmente se obtendría el ID del préstamo y se buscarían los detalles en la base de datos
                            String loanId = request.getParameter("id");
                            // Por ahora usaremos datos de ejemplo
                            String bookTitle = "Ejemplo de Libro";
                            String borrowerName = "Juan Pérez";
                            String loanDate = "2025-01-01";
                            String returnDate = "2025-01-15";
                            String status = "Activo";
                        %>

    <div class="container">
        <h2>Gestion de Prestamos</h2>
        <div class="alert alert-info" role="alert">
            <strong>Total de préstamos pendientes:</strong> 2
        </div>
        <div class="container mt-4">
            <div class="row align-items-center">
                <!-- Columna del formulario -->
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
                                    <tr>
                                        <td>Don Quijote</td>
                                        <td>2025-01-01</td>
                                        <td><span class="badge bg-warning">Pendiente</span></td>
                                    </tr>
                                    <tr>
                                        <td>Cien años de soledad</td>
                                        <td>2024-12-28</td>
                                        <td><span class="badge bg-success">Devuelto</span></td>
                                    </tr>
                                    <tr>
                                        <td>La Odisea</td>
                                        <td>2024-12-25</td>
                                        <td><span class="badge bg-success">Devuelto</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="text-muted small">
                            <em>Total de préstamos históricos: 15</em>
                        </div>
                    </div>                  
                    <div>
                            <a href="add.jsp" class="btn btn-success">Realizar Prestamo</a>
                    </div>
                    <br>
                </div>

                <!-- Columna de la imagen -->
                <div class="col-md-6 text-center">
                    <img src="../img/loan.png" alt="Imagen de préstamo" class="img-fluid rounded" style="max-height: 350px;">
                </div>
            </div>
        </div>

        <h2>Lista de Préstamos</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>ISBN</th>
                    <th>Nombre del Prestatario</th>
                    <th>Fecha de Préstamo</th>
                    <th>Fecha de Devolución</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <!-- Aquí se mostrarían los préstamos -->
                <tr>
                    <td>1</td>
                    <td>1</td>
                    <td>Juan Pérez</td>
                    <td>2025-01-01</td>
                    <td>2025-01-15</td>
                    <td class="text-center">
                        <a href="return.jsp?id=1" class="btn btn-success text-white">Devolver</a>
                        <a href="edit.jsp?id=1" class="btn btn-warning">Editar</a>                     
                        <a href="delete.jsp?id=1" class="btn btn-danger">Eliminar</a>
                        
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html>