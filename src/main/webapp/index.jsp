<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Biblioteca - Sistema de Gestión de Libros</title>
        <link rel="stylesheet" href="css/styles.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    </head>
    <body>
        <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
        <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
        <header>
            <h1>Biblioteca</h1>
            <p>Sistema de Gestión de Biblioteca</p>
        </header>

        <nav class="text-center">
            <ul class="mb-4">
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="books/list.jsp">Libros</a></li>
                <li><a href="loans/list.jsp">Préstamos</a></li>
            </ul>
        </nav>

        <div class="container">
            <h2>Bienvenido al Sistema de Gestión de Libros</h2>
            <div class="dashboard">
                <div class="dashboard-item">
                    <h3>Gestión de Libros</h3>
                    <p>Administre el inventario de libros de la biblioteca.</p>
                    <a href="books/list.jsp" class="btn btn-primary">Ver Libros</a>
                </div>

                <div class="dashboard-item">
                    <h3>Gestión de Préstamos</h3>
                    <p>Administre los préstamos de libros a los usuarios.</p>
                    <a href="loans/list.jsp" class="btn btn-primary">Ver Préstamos</a>
                </div>
            </div>

            <div class="about-section">
                <h3>Acerca de la Biblioteca</h3>
                <p>La biblioteca ofrece una amplia variedad de libros para préstamo a nuestros usuarios. 
                    Promovemos la lectura y el acceso a la información.</p>
            </div>           
        </div>
        <footer>
            <p>&copy; 2025 Biblioteca - Sistema de Gestión de Libros</p>
        </footer>
    </body>
</html>