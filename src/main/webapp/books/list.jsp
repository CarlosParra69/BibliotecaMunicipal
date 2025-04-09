<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Libros - Sistema de Biblioteca</title>
        <link rel="stylesheet" href="../css/styles.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
        <script>
            function showAlert(action) {
                switch (action) {
                    case 'add':
                        alert('Libro agregado exitosamente.');
                        break;
                    case 'edit':
                        alert('Libro actualizado exitosamente.');
                        break;
                    case 'delete':
                        alert('Libro eliminado exitosamente.');
                        break;
                    default:
                        break;
                }
            }
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
            <h2>Gestion de Libros</h2>
            <div class="alert alert-info" role="alert">
                <strong>Total de Libros Disponibles:</strong> 2
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
                                            <th>Fecha</th>
                                            <th>Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Don Quijote</td>
                                            <td>2025-01-01</td>
                                            <td><span class="badge bg-warning">Prestado</span></td>
                                        </tr>
                                        <tr>
                                            <td>Cien años de soledad</td>
                                            <td>2024-12-28</td>
                                            <td><span class="badge bg-secondary">No Disponible</span></td>
                                        </tr>
                                        <tr>
                                            <td>La Odisea</td>
                                            <td>2024-12-25</td>
                                            <td><span class="badge bg-success">Disponible</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="text-muted small">
                                <em>Total de libros históricos: 15</em>
                            </div>
                        </div>
                        <div>
                            <a href="add.jsp" class="btn btn-success">Agregar Nuevo Libro</a>
                        </div>
                        <br>
                    </div>
                    <!-- Columna de la imagen -->
                    <div class="col-md-6 text-center">
                        <img src="../img/book.png" alt="Imagen descriptiva" class="img-fluid rounded" style="max-height: 350px;">
                        <!-- Cambia la URL por tu imagen real -->
                    </div>
                </div>
            </div>

            <h2>Lista de Libros</h2>
            <table>
                <thead>
                    <tr>
                        <th>ISBN</th>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Tipo</th>
                        <th>Disponible</th> 
                        <th>Fecha de Publicacion</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Aquí se mostrarían los libros -->
                    <tr>
                        <td>1</td>
                        <td>Ejemplo de Libro</td>
                        <td>Autor Ejemplo</td>  
                        <td>Novela</td>
                        <td>Si</td>
                        <td>En los años 1600</td>
                        <td class="text-center">
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