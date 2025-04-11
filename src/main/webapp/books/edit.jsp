<%@page import="sena.adso.sistema_gestion_libros.model.Loan"%>
<%@page import="sena.adso.sistema_gestion_libros.model.*"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.Date"%>
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
            var añoPublicacion = document.getElementById('añoPublicacion').value;
            
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
            
            // Validar año de publicación - solo verificar que no esté vacío
            if (añoPublicacion.trim() === '') {
                showErrorAlert('Año de publicación requerido', 'Por favor ingrese un año de publicación.');
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
        <h1>Biblioteca</h1>
        <p>Editar Libro</p>
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
            Libro libroEditar = null;
            
            // Obtener el ISBN del libro a editar
            String isbnEditar = request.getParameter("isbn");
            
            if (isbnEditar == null || isbnEditar.trim().isEmpty()) {
                errorMsg = "ISBN no proporcionado para editar.";
            } else {
                LibroManager manager = LibroManager.getInstance();
                libroEditar = manager.buscarLibroPorISBN(isbnEditar);
                
                if (libroEditar == null) {
                    errorMsg = "No se encontró el libro con ISBN: " + isbnEditar;
                }
            }
            
            // Procesamiento del formulario
            if ("POST".equalsIgnoreCase(request.getMethod()) && libroEditar != null) {
                try {
                    String isbn = request.getParameter("isbn");
                    String titulo = request.getParameter("titulo");
                    String autor = request.getParameter("autor");
                    String tipo = request.getParameter("tipo");
                    String añoPublicacion = request.getParameter("añoPublicacion");
                    
                    // Validar datos
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
                    
                    // Validar año de publicación
                    try {
                        if (añoPublicacion == null || añoPublicacion.trim().isEmpty()) {
                            añoPublicacion = "Sin información";
                        } else {
                            int año = Integer.parseInt(añoPublicacion);
                            int añoActual = new java.util.Date().getYear() + 1900;
                            if (año < 1000 || año > añoActual) {
                                errorMsg = "Año de publicación debe estar entre 1000 y " + añoActual;
                                throw new Exception(errorMsg);
                            }
                        }
                    } catch (NumberFormatException e) {
                        errorMsg = "Año de publicación debe ser un número válido";
                        throw new Exception(errorMsg);
                    }
                    
                    // Obtener el gestor de libros
                    LibroManager manager = LibroManager.getInstance();
                    
                    // Modificar el libro según su tipo
                    if (libroEditar instanceof LibroFiccion && "Ficcion".equals(tipo)) {
                        LibroFiccion libroFiccion = (LibroFiccion) libroEditar;
                        
                        libroFiccion.setTitulo(titulo);
                        libroFiccion.setAutor(autor);
                        libroFiccion.setAñoPublicacion(añoPublicacion);
                        
                        String genero = request.getParameter("genero");
                        if (genero != null && !genero.trim().isEmpty()) {
                            libroFiccion.setGenero(genero);
                        }
                        
                        boolean esSerie = "true".equals(request.getParameter("esSerie"));
                        libroFiccion.setEsSerie(esSerie);
                        
                    } else if (libroEditar instanceof LibroNoFiccion && "NoFiccion".equals(tipo)) {
                        LibroNoFiccion libroNoFiccion = (LibroNoFiccion) libroEditar;
                        
                        libroNoFiccion.setTitulo(titulo);
                        libroNoFiccion.setAutor(autor);
                        libroNoFiccion.setAñoPublicacion(añoPublicacion);
                        
                        String tema = request.getParameter("tema");
                        if (tema != null && !tema.trim().isEmpty()) {
                            libroNoFiccion.setTema(tema);
                        }
                        
                        String nivelAcademico = request.getParameter("nivelAcademico");
                        if (nivelAcademico != null && !nivelAcademico.trim().isEmpty()) {
                            libroNoFiccion.setNivelAcademico(nivelAcademico);
                        }
                        
                    } else if (libroEditar instanceof LibroReferencia && "Referencia".equals(tipo)) {
                        LibroReferencia libroReferencia = (LibroReferencia) libroEditar;
                        
                        libroReferencia.setTitulo(titulo);
                        libroReferencia.setAutor(autor);
                        libroReferencia.setAñoPublicacion(añoPublicacion);
                        
                        String tipoReferencia = request.getParameter("tipoReferencia");
                        if (tipoReferencia != null && !tipoReferencia.trim().isEmpty()) {
                            libroReferencia.setTipoReferencia(tipoReferencia);
                        }
                        
                        String actualizaciones = request.getParameter("actualizaciones");
                        if (actualizaciones != null) {
                            libroReferencia.setActualizaciones(actualizaciones);
                        }
                        
                    } else {
                        errorMsg = "No se pudo editar el libro. El tipo seleccionado no coincide con el tipo original.";
                    }
                    
                    if (errorMsg == null) {
                        response.sendRedirect("list.jsp?action=edit");
                        return;
                    }
                    
                } catch (Exception e) {
                    errorMsg = "Error: " + e.getMessage();
                }
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
                            <div class="text-center mt-3">
                                <a href="list.jsp" class="btn btn-secondary">Volver a la lista</a>
                            </div>
                        <% } else if (libroEditar != null) { %>
                            <form id="libroForm" action="edit.jsp" method="post" onsubmit="return validateForm();" accept-charset="UTF-8">
                                <div class="mb-3">
                                    <label for="isbn" class="form-label">ISBN:</label>
                                    <input type="text" class="form-control" id="isbn" name="isbn" value="<%= libroEditar.getIsbn() %>" readonly>
                                    <small class="text-muted">El ISBN no se puede modificar.</small>
                                </div>
    
                                <div class="mb-3">
                                    <label for="titulo" class="form-label">Título:</label>
                                    <input type="text" class="form-control" id="titulo" name="titulo" value="<%= libroEditar.getTitulo() %>" required>
                                </div>
    
                                <div class="mb-3">
                                    <label for="autor" class="form-label">Autor:</label>
                                    <input type="text" class="form-control" id="autor" name="autor" value="<%= libroEditar.getAutor() %>" required>
                                </div>
    
                                <div class="mb-3">
                                    <label for="tipo" class="form-label">Tipo de libro:</label>
                                    <select class="form-control" id="tipo" name="tipo" required>
                                        <option value="">Seleccione un tipo</option>
                                        <option value="Ficcion" <%= libroEditar instanceof LibroFiccion ? "selected" : "" %>>Ficcion</option>
                                        <option value="NoFiccion" <%= libroEditar instanceof LibroNoFiccion ? "selected" : "" %>>NoFiccion</option>
                                        <option value="Referencia" <%= libroEditar instanceof LibroReferencia ? "selected" : "" %>>Referencia</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="añoPublicacion" class="form-label">Año de publicación:</label>
                                    <input type="number" class="form-control" id="añoPublicacion" name="añoPublicacion" 
                                           value="<%= libroEditar.getAñoPublicacion().equals("Sin información") ? "2014" : libroEditar.getAñoPublicacion() %>" 
                                           min="1000" max="<%= new java.util.Date().getYear() + 1900 %>" required>
                                    <small class="text-muted">Ingrese el año de publicación (entre 1000 y <%= new java.util.Date().getYear() + 1900 %>)</small>
                                </div>
                                
                                <!-- Campos específicos para Ficcion -->
                                <div id="ficcionFields" style="display: none;">
                                    <h5 class="mt-3 mb-3">Información específica para Ficcion</h5>
                                    <div class="mb-3">
                                        <label for="genero" class="form-label">Género:</label>
                                        <select class="form-control" id="genero" name="genero">
                                            <option value="Fantasía" <%= (libroEditar instanceof LibroFiccion && "Fantasía".equals(((LibroFiccion)libroEditar).getGenero())) ? "selected" : "" %>>Fantasía</option>
                                            <option value="Ciencia Ficción" <%= (libroEditar instanceof LibroFiccion && "Ciencia Ficción".equals(((LibroFiccion)libroEditar).getGenero())) ? "selected" : "" %>>Ciencia Ficción</option>
                                            <option value="Misterio" <%= (libroEditar instanceof LibroFiccion && "Misterio".equals(((LibroFiccion)libroEditar).getGenero())) ? "selected" : "" %>>Misterio</option>
                                            <option value="Romance" <%= (libroEditar instanceof LibroFiccion && "Romance".equals(((LibroFiccion)libroEditar).getGenero())) ? "selected" : "" %>>Romance</option>
                                            <option value="Aventura" <%= (libroEditar instanceof LibroFiccion && "Aventura".equals(((LibroFiccion)libroEditar).getGenero())) ? "selected" : "" %>>Aventura</option>
                                            <option value="Terror" <%= (libroEditar instanceof LibroFiccion && "Terror".equals(((LibroFiccion)libroEditar).getGenero())) ? "selected" : "" %>>Terror</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="esSerie" name="esSerie" value="true" <%= (libroEditar instanceof LibroFiccion && ((LibroFiccion)libroEditar).isEsSerie()) ? "checked" : "" %>>
                                        <label class="form-check-label" for="esSerie">¿Es parte de una serie?</label>
                                    </div>
                                </div>
                                
                                <!-- Campos específicos para NoFiccion -->
                                <div id="noFiccionFields" style="display: none;">
                                    <h5 class="mt-3 mb-3">Información específica para NoFiccion</h5>
                                    <div class="mb-3">
                                        <label for="tema" class="form-label">Tema:</label>
                                        <select class="form-control" id="tema" name="tema">
                                            <option value="Ciencia" <%= (libroEditar instanceof LibroNoFiccion && "Ciencia".equals(((LibroNoFiccion)libroEditar).getTema())) ? "selected" : "" %>>Ciencia</option>
                                            <option value="Historia" <%= (libroEditar instanceof LibroNoFiccion && "Historia".equals(((LibroNoFiccion)libroEditar).getTema())) ? "selected" : "" %>>Historia</option>
                                            <option value="Biografía" <%= (libroEditar instanceof LibroNoFiccion && "Biografía".equals(((LibroNoFiccion)libroEditar).getTema())) ? "selected" : "" %>>Biografía</option>
                                            <option value="Autoayuda" <%= (libroEditar instanceof LibroNoFiccion && "Autoayuda".equals(((LibroNoFiccion)libroEditar).getTema())) ? "selected" : "" %>>Autoayuda</option>
                                            <option value="Tecnología" <%= (libroEditar instanceof LibroNoFiccion && "Tecnología".equals(((LibroNoFiccion)libroEditar).getTema())) ? "selected" : "" %>>Tecnología</option>
                                            <option value="Filosofía" <%= (libroEditar instanceof LibroNoFiccion && "Filosofía".equals(((LibroNoFiccion)libroEditar).getTema())) ? "selected" : "" %>>Filosofía</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="nivelAcademico" class="form-label">Nivel académico:</label>
                                        <select class="form-control" id="nivelAcademico" name="nivelAcademico">
                                            <option value="Básico" <%= (libroEditar instanceof LibroNoFiccion && "Básico".equals(((LibroNoFiccion)libroEditar).getNivelAcademico())) ? "selected" : "" %>>Básico</option>
                                            <option value="Medio" <%= (libroEditar instanceof LibroNoFiccion && "Medio".equals(((LibroNoFiccion)libroEditar).getNivelAcademico())) ? "selected" : "" %>>Medio</option>
                                            <option value="Superior" <%= (libroEditar instanceof LibroNoFiccion && "Superior".equals(((LibroNoFiccion)libroEditar).getNivelAcademico())) ? "selected" : "" %>>Superior</option>
                                            <option value="Especializado" <%= (libroEditar instanceof LibroNoFiccion && "Especializado".equals(((LibroNoFiccion)libroEditar).getNivelAcademico())) ? "selected" : "" %>>Especializado</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <!-- Campos específicos para Referencia -->
                                <div id="referenciaFields" style="display: none;">
                                    <h5 class="mt-3 mb-3">Información específica para Referencia</h5>
                                    <div class="mb-3">
                                        <label for="tipoReferencia" class="form-label">Tipo de referencia:</label>
                                        <select class="form-control" id="tipoReferencia" name="tipoReferencia">
                                            <option value="Enciclopedia" <%= (libroEditar instanceof LibroReferencia && "Enciclopedia".equals(((LibroReferencia)libroEditar).getTipoReferencia())) ? "selected" : "" %>>Enciclopedia</option>
                                            <option value="Diccionario" <%= (libroEditar instanceof LibroReferencia && "Diccionario".equals(((LibroReferencia)libroEditar).getTipoReferencia())) ? "selected" : "" %>>Diccionario</option>
                                            <option value="Manual" <%= (libroEditar instanceof LibroReferencia && "Manual".equals(((LibroReferencia)libroEditar).getTipoReferencia())) ? "selected" : "" %>>Manual</option>
                                            <option value="Atlas" <%= (libroEditar instanceof LibroReferencia && "Atlas".equals(((LibroReferencia)libroEditar).getTipoReferencia())) ? "selected" : "" %>>Atlas</option>
                                            <option value="Guía" <%= (libroEditar instanceof LibroReferencia && "Guía".equals(((LibroReferencia)libroEditar).getTipoReferencia())) ? "selected" : "" %>>Guía</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="actualizaciones" class="form-label">Actualizaciones:</label>
                                        <input type="text" class="form-control" id="actualizaciones" name="actualizaciones" 
                                               value="<%= (libroEditar instanceof LibroReferencia) ? ((LibroReferencia)libroEditar).getActualizaciones() : "" %>" 
                                               placeholder="Ej: Edición 2023, Revisión 5">
                                    </div>
                                </div>
    
                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-primary">Guardar cambios</button>
                                    <a href="list.jsp" class="btn btn-secondary">Cancelar</a>
                                </div>
                            </form>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="col-md-6 text-center">
                <img src="../img/edit-book.png" alt="Imagen de edición de libro" class="img-fluid rounded" style="max-height: 350px;">
                <div class="mt-3">
                    <p class="text-muted">Realice los cambios necesarios en la información del libro.</p>
                    <p class="text-muted">El ISBN no puede ser modificado ya que es el identificador único del libro.</p>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html> 