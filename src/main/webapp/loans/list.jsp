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
        function showAlert(action) {
            switch(action) {
                case 'add':
                    alert('Préstamo agregado exitosamente.');
                    break;
                case 'edit':
                    alert('Préstamo actualizado exitosamente.');
                    break;
                case 'delete':
                    alert('Préstamo eliminado exitosamente.');
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
        <p>Gestión de Préstamos</p>
    </header>

    <nav>
        <ul>
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="../books/list.jsp">Libros</a></li>
            <li><a href="list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Agregar/Editar Préstamo</h2>

        <form action="LoanController" method="post" class="form" onsubmit="showAlert('add');">
            <input type="hidden" name="id" value="">
            <div class="form-group">
                <label for="bookId">ID del Libro:</label>
                <input type="number" id="bookId" name="bookId" required>
            </div>
            <div class="form-group">
                <label for="borrower">Nombre del Prestatario:</label>
                <input type="text" id="borrower" name="borrower" required>
            </div>
            <div class="form-group">
                <label for="loanDate">Fecha de Préstamo:</label>
                <input type="date" id="loanDate" name="loanDate" required>
            </div>
            <div class="form-group">
                <label for="returnDate">Fecha de Devolución:</label>
                <input type="date" id="returnDate" name="returnDate" required>
            </div>
            <input type="submit" value="Guardar" class="btn btn-success">
        </form>

        <h2>Lista de Préstamos</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>ID del Libro</th>
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