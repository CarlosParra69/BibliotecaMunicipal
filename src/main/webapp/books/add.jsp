<%@page import="sena.adso.sistema_gestion_libros.model.LibroReferencia"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroNoFiccion"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroFiccion"%>
<%@page import="sena.adso.sistema_gestion_libros.model.Libro"%>
<%@page import="sena.adso.sistema_gestion_libros.model.LibroManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Agregar Libro - Sistema de Biblioteca</title>
    <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
    <link rel="stylesheet" href="../css/styles.css">
    <%-- Incluir scripts y estilos para tema --%>
    <%@ include file="/includes/theme-script.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    <script>
        function showTypeFields() {
            document.getElementById('ficcionFields').style.display = 'none';
            document.getElementById('noFiccionFields').style.display = 'none';
            document.getElementById('referenciaFields').style.display = 'none';
            
            var tipo = document.getElementById('tipo').value;
            if (tipo === 'Ficción') {
                document.getElementById('ficcionFields').style.display = 'block';
            } else if (tipo === 'No ficción') {
                document.getElementById('noFiccionFields').style.display = 'block';
            } else if (tipo === 'Referencia') {
                document.getElementById('referenciaFields').style.display = 'block';
            }
        }
        
        function validateForm() {
            var isbn = document.getElementById('isbn').value;
            var añoPublicacion = document.getElementById('añoPublicacion').value;
            
            // Validar ISBN (formato básico)
            if (!/^\d{10}(\d{3})?$/.test(isbn)) {
                alert('El ISBN debe tener 10 o 13 dígitos numéricos.');
                return false;
            }
            
            // Validar año de publicación
            var año = parseInt(añoPublicacion);
            var añoActual = new Date().getFullYear();
            if (año < 1000 || año > añoActual) {
                alert('El año de publicación debe ser válido (entre 1000 y ' + añoActual + ').');
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
        <p>Agregar Nuevo Libro</p>
    </header>

    <nav class="text-center">
        <ul class="mb-4">
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="../books/list.jsp">Libros</a></li>
            <li><a href="../loans/list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <%
            if (request.getMethod().equals("POST")) {
                LibroManager manager = LibroManager.getInstance();
                
                String isbn = request.getParameter("isbn");
                String titulo = request.getParameter("titulo");
                String autor = request.getParameter("autor");
                String tipo = request.getParameter("tipo");
                int añoPublicacion = Integer.parseInt(request.getParameter("añoPublicacion"));
                
                Libro nuevoLibro = null;
                
                if (tipo.equals("Ficción")) {
                    String genero = request.getParameter("genero");
                    boolean esSerie = request.getParameter("esSerie") != null;
                    nuevoLibro = new LibroFiccion(isbn, titulo, autor, "Bueno", genero, esSerie, añoPublicacion);
                } else if (tipo.equals("No ficción")) {
                    String tema = request.getParameter("tema");
                    String nivelAcademico = request.getParameter("nivelAcademico");
                    nuevoLibro = new LibroNoFiccion(isbn, titulo, autor, añoPublicacion, tema, nivelAcademico);
                } else if (tipo.equals("Referencia")) {
                    String tipoReferencia = request.getParameter("tipoReferencia");
                    String actualizaciones = request.getParameter("actualizaciones");
                    nuevoLibro = new LibroReferencia(isbn, titulo, autor, añoPublicacion, tipoReferencia, actualizaciones);
                }
                
                if (nuevoLibro != null) {
                    manager.agregarLibro(nuevoLibro);
                    response.sendRedirect("list.jsp");
                    return;
                }
            }
        %>
        
        <div class="row align-items-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h3 class="mb-0">Nuevo Libro</h3>
                    </div>
                    <div class="card-body">
                        <form action="add-book.jsp" method="post" onsubmit="return validateForm();">
                            <div class="mb-3">
                                <label for="isbn" class="form-label">ISBN:</label>
                                <input type="text" class="form-control" id="isbn" name="isbn" required>
                            </div>

                            <div class="mb-3">
                                <label for="titulo" class="form-label">Título:</label>
                                <input type="text" class="form-control" id="titulo" name="titulo" required>
                            </div>

                            <div class="mb-3">
                                <label for="autor" class="form-label">Autor:</label>
                                <input type="text" class="form-control" id="autor" name="autor" required>
                            </div>

                            <div class="mb-3">
                                <label for="tipo" class="form-label">Tipo de libro:</label>
                                <select class="form-control" id="tipo" name="tipo" onchange="showTypeFields()" required>
                                    <option value="">Seleccione un tipo</option>
                                    <option value="Ficción">Ficción</option>
                                    <option value="No ficción">No ficción</option>
                                    <option value="Referencia">Referencia</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="añoPublicacion" class="form-label">Año de publicación:</label>
                                <input type="number" class="form-control" id="añoPublicacion" name="añoPublicacion" required>
                            </div>
                            
                            <!-- Campos específicos para Ficción -->
                            <div id="ficcionFields" style="display: none;">
                                <div class="mb-3">
                                    <label for="genero" class="form-label">Género:</label>
                                    <select class="form-control" id="genero" name="genero">
                                        <option value="Fantasía">Fantasía</option>
                                        <option value="Ciencia Ficción">Ciencia Ficción</option>
                                        <option value="Misterio">Misterio</option>
                                        <option value="Romance">Romance</option>
                                        <option value="Aventura">Aventura</option>
                                        <option value="Terror">Terror</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="esSerie" name="esSerie" value="true">
                                    <label class="form-check-label" for="esSerie">¿Es parte de una serie?</label>
                                </div>
                            </div>
                            
                            <!-- Campos específicos para No Ficción -->
                            <div id="noFiccionFields" style="display: none;">
                                <div class="mb-3">
                                    <label for="tema" class="form-label">Tema:</label>
                                    <select class="form-control" id="tema" name="tema">
                                        <option value="Ciencia">Ciencia</option>
                                        <option value="Historia">Historia</option>
                                        <option value="Biografía">Biografía</option>
                                        <option value="Autoayuda">Autoayuda</option>
                                        <option value="Tecnología">Tecnología</option>
                                        <option value="Filosofía">Filosofía</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="nivelAcademico" class="form-label">Nivel académico:</label>
                                    <select class="form-control" id="nivelAcademico" name="nivelAcademico">
                                        <option value="Básico">Básico</option>
                                        <option value="Medio">Medio</option>
                                        <option value="Superior">Superior</option>
                                        <option value="Especializado">Especializado</option>
                                    </select>
                                </div>
                            </div>
                            
                            <!-- Campos específicos para Referencia -->
                            <div id="referenciaFields" style="display: none;">
                                <div class="mb-3">
                                    <label for="tipoReferencia" class="form-label">Tipo de referencia:</label>
                                    <select class="form-control" id="tipoReferencia" name="tipoReferencia">
                                        <option value="Enciclopedia">Enciclopedia</option>
                                        <option value="Diccionario">Diccionario</option>
                                        <option value="Manual">Manual</option>
                                        <option value="Atlas">Atlas</option>
                                        <option value="Guía">Guía</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="actualizaciones" class="form-label">Actualizaciones:</label>
                                    <input type="text" class="form-control" id="actualizaciones" name="actualizaciones" placeholder="Ej: Edición 2023, Revisión 5">
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-success">Registrar</button>
                                <a href="list.jsp" class="btn btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6 text-center">
                <img src="../img/book.png" alt="Imagen de libro" class="img-fluid rounded" style="max-height: 350px;">
                <div class="mt-3">
                    <p class="text-muted">Complete el formulario para agregar un nuevo libro al sistema de biblioteca.</p>
                    <p class="text-muted">Los campos obligatorios están marcados con *.</p>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html>
