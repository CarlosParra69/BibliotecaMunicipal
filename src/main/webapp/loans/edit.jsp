<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Préstamo - Sistema de Biblioteca</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
    <%-- Incluir scripts y estilos para tema --%>
        <%@ include file="/includes/theme-script.jsp" %>
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

        function showAlert() {
            alert('Préstamo actualizado exitosamente.');
        }
    </script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Biblioteca</h1>
        <p>Editar Préstamo</p>
    </header>

    <nav class="text-center">
        <ul class="mb-4">
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="../books/list.jsp">Libros</a></li>
            <li><a href="list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <%
                    // Aquí normalmente se obtendría el ID del préstamo y se buscarían los datos en la base de datos
                    String loanId = request.getParameter("id");
                    // Por ahora usaremos datos de ejemplo
                    String bookId = "1";
                    String bookTitle = "Ejemplo de Libro";
                    String borrowerName = "Juan Pérez";
                    String loanDate = "2025-01-01";
                    String returnDate = "2025-01-15";
                %>

                <div class="card">
                    <div class="card-header bg-warning text-dark">
                        <h3 class="mb-0">Editar Préstamo #<%= loanId %></h3>
                    </div>
                    <div class="card-body">
                        <form action="LoanController" method="post" onsubmit="return validateForm() && showAlert();">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="<%= loanId %>">
                            <input type="hidden" name="bookId" value="<%= bookId %>">

                            <div class="mb-3">
                                <label for="bookTitle" class="form-label">Libro:</label>
                                <input type="text" class="form-control" id="bookTitle" value="<%= bookTitle %>" readonly>
                            </div>

                            <div class="mb-3">
                                <label for="borrower" class="form-label">Nombre del Prestatario:</label>
                                <input type="text" class="form-control" id="borrower" name="borrower" value="<%= borrowerName %>" required>
                            </div>

                            <div class="mb-3">
                                <label for="loanDate" class="form-label">Fecha de Préstamo:</label>
                                <input type="date" class="form-control" id="loanDate" name="loanDate" value="<%= loanDate %>" required>
                            </div>

                            <div class="mb-3">
                                <label for="returnDate" class="form-label">Fecha de Devolución:</label>
                                <input type="date" class="form-control" id="returnDate" name="returnDate" value="<%= returnDate %>" required>
                            </div>

                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-warning">Actualizar Préstamo</button>
                                <a href="list.jsp" class="btn btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6 text-center">
                <img src="../img/loan.png" alt="Imagen de préstamo" class="img-fluid rounded" style="max-height: 350px;">
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html>