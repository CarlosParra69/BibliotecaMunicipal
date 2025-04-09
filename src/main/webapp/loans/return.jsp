<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Devolución de Libro - Sistema de Biblioteca</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Biblioteca</h1>
        <p>Devolución de Libro</p>
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
                    String loanId = request.getParameter("id");
                    // Por ahora usaremos datos de ejemplo
                    String bookTitle = "Ejemplo de Libro";
                    String borrowerName = "Juan Pérez";
                    String loanDate = "2025-01-01";
                    String returnDate = "2025-01-15";
                %>

                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h3 class="mb-0">Confirmar Devolución</h3>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <strong>ID del Préstamo:</strong> <%= loanId %>
                        </div>
                        <div class="mb-3">
                            <strong>Libro:</strong> <%= bookTitle %>
                        </div>
                        <div class="mb-3">
                            <strong>Prestatario:</strong> <%= borrowerName %>
                        </div>
                        <div class="mb-3">
                            <strong>Fecha de Préstamo:</strong> <%= loanDate %>
                        </div>
                        <div class="mb-3">
                            <strong>Fecha de Devolución Prevista:</strong> <%= returnDate %>
                        </div>

                        <form action="LoanController" method="post" class="mt-4">
                            <input type="hidden" name="action" value="return">
                            <input type="hidden" name="id" value="<%= loanId %>">
                            
                            <div class="mb-3">
                                <label for="actualReturnDate" class="form-label">Fecha de Devolución Real:</label>
                                <input type="date" class="form-control" id="actualReturnDate" name="actualReturnDate" required>
                            </div>

                            <div class="mb-3">
                                <label for="bookCondition" class="form-label">Estado del Libro:</label>
                                <select class="form-select" id="bookCondition" name="bookCondition" required>
                                    <option value="">Seleccione el estado</option>
                                    <option value="good">Bueno</option>
                                    <option value="damaged">Dañado</option>
                                    <option value="lost">Perdido</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="observations" class="form-label">Observaciones:</label>
                                <textarea class="form-control" id="observations" name="observations" rows="3"></textarea>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-info text-white">Confirmar Devolución</button>
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