<%@page import="sena.adso.sistema_gestion_libros.modelo.*"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Libro - Sistema de Biblioteca</title>
    <link rel="icon" href="../img/book-closed-svgrepo-com.svg" type="image/svg+xml">
    <link rel="stylesheet" href="../css/styles.css">
    <%-- Incluir scripts y estilos para tema --%>
    <%@ include file="/includes/theme-script.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../js/sweetalert-utils.js"></script>
    <script>
        function showTypeFields() {
            document.getElementById('ficcionFields').style.display = 'none';
            document.getElementById('noFiccionFields').style.display = 'none';
            document.getElementById('referenciaFields').style.display = 'none';
            
            var tipo = document.getElementById('tipo').value;
            if (tipo === 'Ficcion') {
                document.getElementById('ficcionFields').style.display = 'block';
            } else if (tipo === 'NoFiccion') {
                document.getElementById('noFiccionFields').style.display = 'block';
            } else if (tipo === 'Referencia') {
                document.getElementById('referenciaFields').style.display = 'block';
            }
        }
        
        function validateForm() {
            var isbn = document.getElementById('isbn').value;
            var titulo = document.getElementById('titulo').value;
            var autor = document.getElementById('autor').value;
            var tipo = document.getElementById('tipo').value;
            var añoPublicacion = document.getElementById('anioPub').value;
            
            // Solo verificar que título, autor y tipo estén completos
            if (!isbn || !titulo || !autor || !tipo) {
                showErrorAlert('Campos incompletos', 'Por favor complete los campos obligatorios: ISBN, Título, Autor y Tipo.');
                return false;
            }
            
            // Validación básica del ISBN - solo verificar que tenga algún valor
            if (isbn.trim() === '') {
                showErrorAlert('ISBN requerido', 'Por favor ingrese un ISBN.');
                return false;
            }
            
            // Validar año de publicación - verificar que no esté vacío y sea un número válido
            if (añoPublicacion.trim() === '') {
                showErrorAlert('Año de publicación requerido', 'Por favor ingrese un año de publicación.');
                return false;
            }
            
            try {
                var añoNum = parseInt(añoPublicacion);
                var añoActual = new Date().getFullYear();
                if (isNaN(añoNum) || añoNum < 1000 || añoNum > añoActual) {
                    showErrorAlert('Año de publicación inválido', 'El año debe ser un número entre 1000 y ' + añoActual);
                    return false;
                }
            } catch (e) {
                showErrorAlert('Año de publicación inválido', 'Por favor ingrese un año válido.');
                return false;
            }
            
            return true;
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            showTypeFields();
            document.getElementById('tipo').addEventListener('change', showTypeFields);
        });
    </script>
</head>
<body>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
    <script src="https://files.bpcontent.cloud/2025/04/08/01/20250408014526-SGBBVDT9.js"></script>
    <header>
        <h1>Editar Libro</h1>
        <i class="text-muted">Leer el presente para entender el futuro.</i>
    </header>

    <nav class="text-center">
        <ul class="mb-4">
            <li><a href="../index.jsp">Inicio</a></li>
            <li><a href="list.jsp">Libros</a></li>
            <li><a href="../loans/list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <%
            String errorMsg = null;
            Libro libroAEditar = null;
            
            // Obtener el ISBN del libro a editar
            String isbnEditar = request.getParameter("isbn");
            
            // Si no hay ISBN, redireccionar a la lista
            if (isbnEditar == null || isbnEditar.trim().isEmpty()) {
                response.sendRedirect("list.jsp");
                return;
            }
            
            // Obtener el libro
            LibroManager manager = LibroManager.getInstance();
            libroAEditar = manager.getLibroPorISBN(isbnEditar);
            
            // Si no se encuentra el libro, redireccionar a la lista
            if (libroAEditar == null) {
                response.sendRedirect("list.jsp?error=libroNoEncontrado");
                return;
            }
            
            // Procesamiento del formulario cuando se envía
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                try {
                    String isbn = request.getParameter("isbn");
                    String titulo = request.getParameter("titulo");
                    String autor = request.getParameter("autor");
                    String tipo = request.getParameter("tipo");
                    String añoPublicacionStr = request.getParameter("anioPub");
                    
                    // Validar datos básicos
                    if (isbn == null || isbn.trim().isEmpty()) {
                        errorMsg = "ISBN no puede estar vacío";
                        throw new Exception(errorMsg);
                    }
                    
                    if (titulo == null || titulo.trim().isEmpty()) {
                        errorMsg = "Título no puede estar vacío";
                        throw new Exception(errorMsg);
                    }
                    
                    if (autor == null || autor.trim().isEmpty()) {
                        errorMsg = "Autor no puede estar vacío";
                        throw new Exception(errorMsg);
                    }
                    
                    // Usar un valor predeterminado si no se recibe año
                    int añoPublicacion = 2014; // Valor predeterminado
                    
                    if (añoPublicacionStr != null && !añoPublicacionStr.trim().isEmpty()) {
                        try {
                            añoPublicacion = Integer.parseInt(añoPublicacionStr.trim());
                        } catch (NumberFormatException e) {
                            errorMsg = "El año de publicación debe ser un número válido.";
                            throw new Exception(errorMsg);
                        }
                    }

                    // Verificar rango del año
                    int añoActual = Calendar.getInstance().get(Calendar.YEAR);
                    if (añoPublicacion < 1000 || añoPublicacion > añoActual) {
                        errorMsg = "El año de publicación debe estar entre 1000 y " + añoActual;
                        throw new Exception(errorMsg);
                    }

                    // Crear el libro según el tipo
                    Libro libroActualizado = null;

                    if ("Ficcion".equals(tipo)) {
                        String genero = request.getParameter("genero");
                        if (genero == null || genero.trim().isEmpty()) {
                            genero = "Fantasía"; // Valor predeterminado
                        }
                        boolean esSerie = "true".equals(request.getParameter("esSerie"));

                        libroActualizado = new LibroFiccion(isbn, titulo, autor, añoPublicacion, genero, esSerie);
                    } else if ("NoFiccion".equals(tipo)) {
                        String tema = request.getParameter("tema");
                        if (tema == null || tema.trim().isEmpty()) {
                            tema = "Ciencia"; // Valor predeterminado
                        }
                        String nivelAcademico = request.getParameter("nivelAcademico");
                        if (nivelAcademico == null || nivelAcademico.trim().isEmpty()) {
                            nivelAcademico = "Básico"; // Valor predeterminado
                        }
                        libroActualizado = new LibroNoFiccion(isbn, titulo, autor, añoPublicacion, tema, nivelAcademico);
                    } else if ("Referencia".equals(tipo)) {
                        String tipoReferencia = request.getParameter("tipoReferencia");
                        if (tipoReferencia == null || tipoReferencia.trim().isEmpty()) {
                            tipoReferencia = "Enciclopedia"; // Valor predeterminado
                        }
                        String actualizaciones = request.getParameter("actualizaciones");
                        if (actualizaciones == null) {
                            actualizaciones = "";
                        }

                        libroActualizado = new LibroReferencia(isbn, titulo, autor, añoPublicacion, tipoReferencia, actualizaciones);
                    } else {
                        errorMsg = "No se pudo actualizar el libro. Tipo no reconocido: " + tipo;
                    }

                    // Actualizar el libro si se creó correctamente
                    if (libroActualizado != null) {
                        manager.actualizarLibro(libroActualizado);
                        response.sendRedirect("list.jsp?action=edit");
                        return;
                    }

                } catch (Exception e) {
                    errorMsg = "Error: " + e.getMessage();
                }
            }
            
            // Determinar el tipo de libro
            String tipoLibro = "";
            if (libroAEditar instanceof LibroFiccion) {
                tipoLibro = "Ficcion";
            } else if (libroAEditar instanceof LibroNoFiccion) {
                tipoLibro = "NoFiccion";
            } else if (libroAEditar instanceof LibroReferencia) {
                tipoLibro = "Referencia";
            }
        %>
        
        <div class="row align-items-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Editar Libro</h3>
                    </div>
                    <div class="card-body">
                        <% if (errorMsg != null) { %>
                            <div class="alert alert-danger mb-3">
                                <%= errorMsg %>
                            </div>
                        <% } %>
                        <form id="libroForm" action="edit.jsp?isbn=<%= libroAEditar.getIsbn() %>" method="post" onsubmit="return validateForm();" accept-charset="UTF-8">
                            <div class="mb-3">
                                <label for="isbn" class="form-label">ISBN:</label>
                                <input type="text" class="form-control" id="isbn" name="isbn" value="<%= libroAEditar.getIsbn() %>" readonly>
                                <small class="text-muted">El ISBN no se puede modificar</small>
                            </div>
    
                            <div class="mb-3">
                                <label for="titulo" class="form-label">Título:</label>
                                <input type="text" class="form-control" id="titulo" name="titulo" value="<%= libroAEditar.getTitulo() %>" required>
                            </div>
    
                            <div class="mb-3">
                                <label for="autor" class="form-label">Autor:</label>
                                <input type="text" class="form-control" id="autor" name="autor" value="<%= libroAEditar.getAutor() %>" required>
                            </div>
    
                            <div class="mb-3">
                                <label for="tipo" class="form-label">Tipo de libro:</label>
                                <select class="form-control" id="tipo" name="tipo" required>
                                    <option value="Ficcion" <%= "Ficcion".equals(tipoLibro) ? "selected" : "" %>>Ficcion</option>
                                    <option value="NoFiccion" <%= "NoFiccion".equals(tipoLibro) ? "selected" : "" %>>NoFiccion</option>
                                    <option value="Referencia" <%= "Referencia".equals(tipoLibro) ? "selected" : "" %>>Referencia</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="anioPub" class="form-label">Año de publicación:</label>
                                <input type="text" class="form-control" id="anioPub" name="anioPub" 
                                       value="<%= libroAEditar.getAñoPublicacion() %>" required>
                                <small class="text-muted">Ingrese el año de publicación (entre 1000 y <%= Calendar.getInstance().get(Calendar.YEAR) %>)</small>
                            </div>
                            
                            <!-- Campos específicos para Ficcion -->
                            <div id="ficcionFields" style="display: none;">
                                <h5 class="mt-3 mb-3">Información específica para Ficcion</h5>
                                <%
                                    String generoSeleccionado = "";
                                    boolean esSerie = false;
                                    if (libroAEditar instanceof LibroFiccion) {
                                        LibroFiccion ficcion = (LibroFiccion)libroAEditar;
                                        generoSeleccionado = ficcion.getGenero();
                                        esSerie = ficcion.isEsSerie();
                                    }
                                %>
                                <div class="mb-3">
                                    <label for="genero" class="form-label">Género:</label>
                                    <select class="form-control" id="genero" name="genero">
                                        <option value="Fantasía" <%= "Fantasía".equals(generoSeleccionado) ? "selected" : "" %>>Fantasía</option>
                                        <option value="Ciencia Ficción" <%= "Ciencia Ficción".equals(generoSeleccionado) ? "selected" : "" %>>Ciencia Ficción</option>
                                        <option value="Misterio" <%= "Misterio".equals(generoSeleccionado) ? "selected" : "" %>>Misterio</option>
                                        <option value="Romance" <%= "Romance".equals(generoSeleccionado) ? "selected" : "" %>>Romance</option>
                                        <option value="Aventura" <%= "Aventura".equals(generoSeleccionado) ? "selected" : "" %>>Aventura</option>
                                        <option value="Terror" <%= "Terror".equals(generoSeleccionado) ? "selected" : "" %>>Terror</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="esSerie" name="esSerie" value="true" <%= esSerie ? "checked" : "" %>>
                                    <label class="form-check-label" for="esSerie">¿Es parte de una serie?</label>
                                </div>
                            </div>
                            
                            <!-- Campos específicos para NoFiccion -->
                            <div id="noFiccionFields" style="display: none;">
                                <h5 class="mt-3 mb-3">Información específica para NoFiccion</h5>
                                <%
                                    String temaSeleccionado = "";
                                    String nivelAcademicoSeleccionado = "";
                                    if (libroAEditar instanceof LibroNoFiccion) {
                                        LibroNoFiccion noFiccion = (LibroNoFiccion)libroAEditar;
                                        temaSeleccionado = noFiccion.getTema();
                                        nivelAcademicoSeleccionado = noFiccion.getNivelAcademico();
                                    }
                                %>
                                <div class="mb-3">
                                    <label for="tema" class="form-label">Tema:</label>
                                    <select class="form-control" id="tema" name="tema">
                                        <option value="Ciencia" <%= "Ciencia".equals(temaSeleccionado) ? "selected" : "" %>>Ciencia</option>
                                        <option value="Historia" <%= "Historia".equals(temaSeleccionado) ? "selected" : "" %>>Historia</option>
                                        <option value="Biografía" <%= "Biografía".equals(temaSeleccionado) ? "selected" : "" %>>Biografía</option>
                                        <option value="Autoayuda" <%= "Autoayuda".equals(temaSeleccionado) ? "selected" : "" %>>Autoayuda</option>
                                        <option value="Tecnología" <%= "Tecnología".equals(temaSeleccionado) ? "selected" : "" %>>Tecnología</option>
                                        <option value="Filosofía" <%= "Filosofía".equals(temaSeleccionado) ? "selected" : "" %>>Filosofía</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="nivelAcademico" class="form-label">Nivel académico:</label>
                                    <select class="form-control" id="nivelAcademico" name="nivelAcademico">
                                        <option value="Básico" <%= "Básico".equals(nivelAcademicoSeleccionado) ? "selected" : "" %>>Básico</option>
                                        <option value="Medio" <%= "Medio".equals(nivelAcademicoSeleccionado) ? "selected" : "" %>>Medio</option>
                                        <option value="Superior" <%= "Superior".equals(nivelAcademicoSeleccionado) ? "selected" : "" %>>Superior</option>
                                        <option value="Especializado" <%= "Especializado".equals(nivelAcademicoSeleccionado) ? "selected" : "" %>>Especializado</option>
                                    </select>
                                </div>
                            </div>
                            
                            <!-- Campos específicos para Referencia -->
                            <div id="referenciaFields" style="display: none;">
                                <h5 class="mt-3 mb-3">Información específica para Referencia</h5>
                                <%
                                    String tipoReferenciaSeleccionado = "";
                                    String actualizaciones = "";
                                    if (libroAEditar instanceof LibroReferencia) {
                                        LibroReferencia referencia = (LibroReferencia)libroAEditar;
                                        tipoReferenciaSeleccionado = referencia.getTipoReferencia();
                                        actualizaciones = referencia.getActualizaciones();
                                    }
                                %>
                                <div class="mb-3">
                                    <label for="tipoReferencia" class="form-label">Tipo de referencia:</label>
                                    <select class="form-control" id="tipoReferencia" name="tipoReferencia">
                                        <option value="Enciclopedia" <%= "Enciclopedia".equals(tipoReferenciaSeleccionado) ? "selected" : "" %>>Enciclopedia</option>
                                        <option value="Diccionario" <%= "Diccionario".equals(tipoReferenciaSeleccionado) ? "selected" : "" %>>Diccionario</option>
                                        <option value="Manual" <%= "Manual".equals(tipoReferenciaSeleccionado) ? "selected" : "" %>>Manual</option>
                                        <option value="Atlas" <%= "Atlas".equals(tipoReferenciaSeleccionado) ? "selected" : "" %>>Atlas</option>
                                        <option value="Guía" <%= "Guía".equals(tipoReferenciaSeleccionado) ? "selected" : "" %>>Guía</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="actualizaciones" class="form-label">Actualizaciones:</label>
                                    <input type="text" class="form-control" id="actualizaciones" name="actualizaciones" 
                                           value="<%= actualizaciones %>" placeholder="Ej: Edición 2023, Revisión 5">
                                </div>
                            </div>
    
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-primary">Actualizar</button>
                                <a href="list.jsp" class="btn btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-6 text-center">
                <img src="../img/book.png" alt="Imagen de libro" class="img-fluid rounded" style="max-height: 350px;">
                <div class="mt-3">
                    <p class="text-muted">Modifique los campos del libro que desea actualizar.</p>
                    <p class="text-muted">Tenga en cuenta que el ISBN no se puede modificar.</p>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Biblioteca Municipal De Miraflores - Sistema de Gestión</p>
    </footer>
</body>
</html> 