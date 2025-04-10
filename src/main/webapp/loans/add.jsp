<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Agregar Préstamo - Sistema de Biblioteca</title>
    <link rel="stylesheet" href="../css/styles.css">
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
    </script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Biblioteca</h1>
        <p>Agregar Nuevo Préstamo</p>
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
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h3 class="mb-0">Nuevo Préstamo</h3>
                    </div>
                    <div class="card-body">
                        <form action="LoanController" method="post" onsubmit="return validateForm();">
                            <input type="hidden" name="action" value="add">

                            <div class="mb-3">
                                <label for="bookId" class="form-label">ID del Libro:</label>
                                <input type="number" class="form-control" id="bookId" name="bookId" required>
                            </div>

                            <div class="mb-3">
                                <label for="borrower" class="form-label">Nombre del Prestatario:</label>
                                <input type="text" class="form-control" id="borrower" name="borrower" required>
                            </div>

                            <div class="mb-3">
                                <label for="loanDate" class="form-label">Fecha de Préstamo:</label>
                                <input type="date" class="form-control" id="loanDate" name="loanDate" required>
                            </div>

                            <div class="mb-3">
                                <label for="returnDate" class="form-label">Fecha de Devolución:</label>
                                <input type="date" class="form-control" id="returnDate" name="returnDate" required>
                            </div>

                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-success">Guardar Préstamo</button>
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