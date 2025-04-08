<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Libro - Sistema de Biblioteca</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
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
        <h2>Editar Libro</h2>

        <%
            // Obtener el ID del libro de la URL
            String bookId = request.getParameter("id");
            
            // Aquí normalmente se haría una consulta a la base de datos para obtener los datos del libro
            // Por ahora, usaremos datos de ejemplo
            String bookTitle = "Ejemplo de Libro";
            String bookAuthor = "Autor Ejemplo";
            String bookIsbn = "123456789";
            
            // En un caso real, se obtendría el libro de la base de datos usando el ID
            // Book book = BookDAO.getBookById(Integer.parseInt(bookId));
            // String bookTitle = book.getTitle();
            // String bookAuthor = book.getAuthor();
            // String bookIsbn = book.getIsbn();
        %>

        <form action="BookController" method="post" class="form" onsubmit="showAlert('edit');">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= bookId %>">
            <div class="form-group">
                <label for="title">Título:</label>
                <input type="text" id="title" name="title" value="<%= bookTitle %>" required>
            </div>
            <div class="form-group">
                <label for="author">Autor:</label>
                <input type="text" id="author" name="author" value="<%= bookAuthor %>" required>
            </div>
            <div class="form-group">
                <label for="isbn">ISBN:</label>
                <input type="text" id="isbn" name="isbn" value="<%= bookIsbn %>" required>
            </div>
            <div class="form-group">
                <input type="submit" value="Actualizar" class="btn btn-success">
                <a href="list.jsp" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>

    </div>

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html>
