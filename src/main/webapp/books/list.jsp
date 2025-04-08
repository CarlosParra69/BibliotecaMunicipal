<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Libros - Sistema de Biblioteca</title>
    <link rel="stylesheet" href="../css/styles.css">
    <script>
        function showAlert(action) {
            switch(action) {
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
        <h1>Sistema de Biblioteca</h1>
        <p>Gestión de Libros</p>
    </header>

    <nav>
        <ul>
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="list.jsp">Libros</a></li>
            <li><a href="../loans/list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Agregar/Editar Libro</h2>

        <form action="BookController" method="post" class="form" onsubmit="showAlert('add');">
            <input type="hidden" name="id" value="">
            <div class="form-group">
                <label for="title">Título:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="author">Autor:</label>
                <input type="text" id="author" name="author" required>
            </div>
            <div class="form-group">
                <label for="isbn">ISBN:</label>
                <input type="text" id="isbn" name="isbn" required>
            </div>
            <input type="submit" value="Guardar" class="btn">
        </form>

        <h2>Lista de Libros</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Título</th>
                    <th>Autor</th>
                    <th>ISBN</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <!-- Aquí se mostrarían los libros -->
                <tr>
                    <td>1</td>
                    <td>Ejemplo de Libro</td>
                    <td>Autor Ejemplo</td>
                    <td>123456789</td>
                    <td>
                        <a href="edit.jsp?id=1" class="btn" onclick="showAlert('edit'); return false;">Editar</a>
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