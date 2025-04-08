<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Biblioteca - Sistema de Gestión de Libros</title>
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>
        <header>
            <h1>Biblioteca</h1>
            <p>Sistema de Gestión de Libros</p>
        </header>
        
        <nav>
            <ul>
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
                    <a href="books/list.jsp" class="btn">Ver Libros</a>
                </div>
                
                <div class="dashboard-item">
                    <h3>Gestión de Préstamos</h3>
                    <p>Administre los préstamos de libros a los usuarios.</p>
                    <a href="loans/list.jsp" class="btn">Ver Préstamos</a>
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