<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Detalles del Préstamo - Sistema de Biblioteca</title>
    <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
    <link rel="stylesheet" href="../css/styles.css">
    <%-- Incluir scripts y estilos para tema --%>
        <%@ include file="/includes/theme-script.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Biblioteca</h1>
        <p>Detalles del Préstamo</p>
    </header>

    <nav class="text-center">
        <ul class="mb-4">
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="../books/list.jsp">Libros</a></li>
            <li><a href="list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Detalles del Préstamo</h3>
                    </div>
                    <div class="card-body">
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
                        
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h4>Información del Préstamo</h4>
                                <p><strong>ID del Préstamo:</strong> <%= loanId %></p>
                                <p><strong>Estado:</strong> <span class="badge bg-success"><%= status %></span></p>
                                <p><strong>Fecha de Préstamo:</strong> <%= loanDate %></p>
                                <p><strong>Fecha de Devolución:</strong> <%= returnDate %></p>
                            </div>
                            <div class="col-md-6">
                                <h4>Información del Libro</h4>
                                <p><strong>Título:</strong> <%= bookTitle %></p>
                                <p><strong>Prestatario:</strong> <%= borrowerName %></p>
                            </div>
                        </div>
                        
                        <div class="text-center mt-4">
                            <img src="../img/loan.png" alt="Imagen de préstamo" class="img-fluid rounded" style="max-height: 200px;">
                        </div>
                        
                        <div class="text-center mt-4">
                            
                            <a href="list.jsp" class="btn btn-secondary">Volver a la Lista</a>
                            <a href="return.jsp?id=<%= loanId %>" class="btn btn-success">Marcar como Devuelto</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html>