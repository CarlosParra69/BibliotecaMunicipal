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
            <h2>Agregar Nuevo Libro</h2>

            <div class="container mt-4">
                <div class="row align-items-center">
                    <!-- Columna del formulario -->
                    <div class="col-md-6">
                        <form action="edit.jsp?id=" method="post" onsubmit="showAlert('add');">
                            <input type="hidden" name="id" value="">

                            <div class="mb-3">
                                <label for="title" class="form-label">ISBN:</label>
                                <input type="text" class="form-control" id="title" name="title" required style="width: 300px;">
                            </div>

                            <div class="mb-3">
                                <label for="author" class="form-label">Titulo:</label>
                                <input type="text" class="form-control" id="author" name="author" required style="width: 300px;">
                            </div>

                            <div class="mb-3">
                                <label for="isbn" class="form-label">Autor:</label>
                                <input type="text" class="form-control" id="isbn" name="isbn" required style="width: 300px;">
                            </div>

                            
                            
                            <div class="mb-3">
                                <label for="title" class="form-label">Tipo:</label>
                                <input type="text" class="form-control" id="title" name="title" required style="width: 300px;">
                            </div>
                            
                            <div class="mb-3">
                                <label for="title" class="form-label">Fecha de Publicacion:</label>
                                <input type="text" class="form-control" id="title" name="title" required style="width: 300px;">
                            </div>
                            
                            <div>
                                <button type="submit" class="btn btn-success">Guardar</button>
                            </div>
                        </form>
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
                        <td>Si</td>
                        <td>En los años 1600</td>
                        <td>
                            <a href="edit.jsp?id=1" class="btn btn-success" onclick="showAlert('edit'); return false;">Prestar</a>
                            <a href="edit.jsp?id=1" class="btn btn-warning" onclick="showAlert('edit'); return false;">Editar</a>
                            <a href="delete.jsp?id=1" class="btn btn-danger" onclick="showAlert('delete'); return false;">Eliminar</a>
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