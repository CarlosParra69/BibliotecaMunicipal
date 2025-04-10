<%@page import="sena.adso.sistema_gestion_libros.model.Loan"%>
<%@page import="sena.adso.sistema_gestion_libros.model.*"%>
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
            // Obtener el gestor de libros
            LibroManager manager = LibroManager.getInstance();
            
            // Obtener el ISBN del libro de la solicitud
            String isbn = request.getParameter("isbn");
            
            if (isbn == null || isbn.trim().isEmpty()) {
                // ISBN inválido, redirigir a la página de lista
                response.sendRedirect("list.jsp");
                return;
            }
            
            // Obtener el libro del gestor
            Libro libro = manager.getLibroPorISBN(isbn);
            
            // Verificar si el libro existe
            if (libro == null) {
                // Libro no encontrado, redirigir a la página de lista
                response.sendRedirect("list.jsp");
                return;
            }
            
            // Verificar si se envió el formulario (actualización)
            if (request.getMethod().equals("POST")) {
                String titulo = request.getParameter("titulo");
                String autor = request.getParameter("autor");
                
                // Validación para evitar error con año de publicación nulo
                int añoPublicacion = 2000; // Valor predeterminado
                String añoPublicacionStr = request.getParameter("añoPublicacion");
                if (añoPublicacionStr != null && !añoPublicacionStr.trim().isEmpty()) {
                    try {
                        añoPublicacion = Integer.parseInt(añoPublicacionStr);
                    } catch (NumberFormatException e) {
                        // Si hay error al convertir, simplemente usamos el valor predeterminado
                        System.out.println("Error al convertir año de publicación: " + e.getMessage());
                    }
                }
                
                // Obtener el valor de disponibilidad
                boolean disponible = "true".equals(request.getParameter("disponible"));
                
                // Actualizar los campos comunes
                libro.setTitulo(titulo);
                libro.setAutor(autor);
                libro.setAñoPublicacion(añoPublicacion);
                
                // Si el libro no está prestado actualmente, actualizar disponibilidad
                if (!libro.isDisponible() && disponible) {
                    // Si intentamos marcar como disponible un libro que no lo estaba
                    // Verificar que no esté prestado actualmente
                    boolean estaEnPrestamo = false;
                    for (Loan prestamo : manager.getPrestamosActivos()) {
                        if (prestamo.getLibro().getIsbn().equals(libro.getIsbn())) {
                            estaEnPrestamo = true;
                            break;
                        }
                    }
                    
                    if (!estaEnPrestamo) {
                        libro.setDisponible(disponible);
                    }
                }
                else if (libro.isDisponible() && !disponible) {
                    // Si intentamos marcar como no disponible un libro disponible
                    libro.setDisponible(false);
                }
                
                // Actualizar campos específicos según el tipo de libro
                if (libro instanceof LibroFiccion) {
                    LibroFiccion libroFiccion = (LibroFiccion) libro;
                    String genero = request.getParameter("genero");
                    boolean esSerie = request.getParameter("esSerie") != null;
                    
                    libroFiccion.setGenero(genero);
                    libroFiccion.setEsSerie(esSerie);
                } else if (libro instanceof LibroNoFiccion) {
                    LibroNoFiccion libroNoFiccion = (LibroNoFiccion) libro;
                    String tema = request.getParameter("tema");
                    String nivelAcademico = request.getParameter("nivelAcademico");
                    
                    libroNoFiccion.setTema(tema);
                    libroNoFiccion.setNivelAcademico(nivelAcademico);
                } else if (libro instanceof LibroReferencia) {
                    LibroReferencia libroReferencia = (LibroReferencia) libro;
                    String tipoReferencia = request.getParameter("tipoReferencia");
                    String actualizaciones = request.getParameter("actualizaciones");
                    
                    libroReferencia.setTipoReferencia(tipoReferencia);
                    libroReferencia.setActualizaciones(actualizaciones);
                }
                
                // Actualizar el libro en el gestor
                boolean actualizado = manager.actualizarLibro(libro);
                
                if (actualizado) {
                    // Libro actualizado exitosamente, redirigir a la página de lista
                    response.sendRedirect("list.jsp?action=edit");
                } else {
                    // Error al actualizar el libro
        %>
                    <div class="alert alert-danger mb-4">
                        <p>Error al actualizar el libro. Por favor, inténtelo de nuevo.</p>
                    </div>
        <%
                }
                return;
            }
            
            // Obtener los campos específicos según el tipo de libro
            String tipoLibro = libro.getTipo();
            
            String genero = "";
            boolean esSerie = false;
            String tema = "";
            String nivelAcademico = "";
            String tipoReferencia = "";
            String actualizaciones = "";
            
            if (libro instanceof LibroFiccion) {
                LibroFiccion libroFiccion = (LibroFiccion) libro;
                genero = libroFiccion.getGenero();
                esSerie = libroFiccion.isEsSerie();
            } else if (libro instanceof LibroNoFiccion) {
                LibroNoFiccion libroNoFiccion = (LibroNoFiccion) libro;
                tema = libroNoFiccion.getTema();
                nivelAcademico = libroNoFiccion.getNivelAcademico();
            } else if (libro instanceof LibroReferencia) {
                LibroReferencia libroReferencia = (LibroReferencia) libro;
                tipoReferencia = libroReferencia.getTipoReferencia();
                actualizaciones = libroReferencia.getActualizaciones();
            }
        %>
        
        <div class="row align-items-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0">Editar Libro</h3>
                    </div>
                    <div class="card-body">
                        <form action="edit.jsp" method="post" onsubmit="return validateForm();">
                            <input type="hidden" name="isbn" value="<%= libro.getIsbn() %>">
                            
                            <div class="mb-3">
                                <label for="isbn" class="form-label">ISBN:</label>
                                <input type="text" class="form-control" id="isbn" value="<%= libro.getIsbn() %>" readonly>
                                <small class="text-muted">El ISBN no se puede modificar.</small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="titulo" class="form-label">Título:</label>
                                <input type="text" class="form-control" id="titulo" name="titulo" value="<%= libro.getTitulo() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="autor" class="form-label">Autor:</label>
                                <input type="text" class="form-control" id="autor" name="autor" value="<%= libro.getAutor() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="tipo" class="form-label">Tipo:</label>
                                <input type="text" class="form-control" id="tipo" value="<%= libro.getTipo() %>" readonly>
                                <small class="text-muted">El tipo de libro no se puede modificar.</small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="añoPublicacion" class="form-label">Año de Publicación:</label>
                                <input type="number" class="form-control" id="añoPublicacion" name="añoPublicacion" value="<%= libro.getAñoPublicacion() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="disponible" class="form-label">Disponibilidad:</label>
                                
                                <%
                                    // Determinar el estado actual del libro
                                    String estadoActual = "";
                                    String claseEstado = "";
                                    if (libro.isDisponible()) {
                                        estadoActual = "Disponible";
                                        claseEstado = "text-success";
                                    } else {
                                        // Verificar si está prestado o no disponible
                                        boolean estaEnPrestamo = false;
                                        for (Loan prestamo : manager.getPrestamosActivos()) {
                                            if (prestamo.getLibro().getIsbn().equals(libro.getIsbn())) {
                                                estaEnPrestamo = true;
                                                break;
                                            }
                                        }
                                        
                                        if (estaEnPrestamo) {
                                            estadoActual = "Prestado";
                                            claseEstado = "text-warning";
                                        } else {
                                            estadoActual = "No Disponible";
                                            claseEstado = "text-danger";
                                        }
                                    }
                                %>
                                
                                <p class="mb-2">Estado actual: <span class="<%= claseEstado %>"><strong><%= estadoActual %></strong></span></p>
                                
                                <select class="form-select" id="disponible" name="disponible">
                                    <option value="true" <%= libro.isDisponible() ? "selected" : "" %>>Disponible</option>
                                    <option value="false" <%= !libro.isDisponible() ? "selected" : "" %>>No Disponible</option>
                                </select>
                                <small class="text-muted">
                                    Marque como "No Disponible" si el libro está perdido o dañado permanentemente.<br>
                                    <% if (estadoActual.equals("Prestado")) { %>
                                        <strong class="text-warning">Advertencia:</strong> Este libro está actualmente prestado. Cualquier cambio en la disponibilidad no tendrá efecto hasta que sea devuelto.
                                    <% } %>
                                </small>
                            </div>
                            
                            <% if (tipoLibro.equals("Ficción")) { %>
                            <!-- Campos específicos para Ficción -->
                            <div id="ficcionFields">
                                <div class="mb-3">
                                    <label for="genero" class="form-label">Género:</label>
                                    <select class="form-control" id="genero" name="genero">
                                        <option value="Fantasía" <%= genero.equals("Fantasía") ? "selected" : "" %>>Fantasía</option>
                                        <option value="Ciencia Ficción" <%= genero.equals("Ciencia Ficción") ? "selected" : "" %>>Ciencia Ficción</option>
                                        <option value="Misterio" <%= genero.equals("Misterio") ? "selected" : "" %>>Misterio</option>
                                        <option value="Romance" <%= genero.equals("Romance") ? "selected" : "" %>>Romance</option>
                                        <option value="Aventura" <%= genero.equals("Aventura") ? "selected" : "" %>>Aventura</option>
                                        <option value="Terror" <%= genero.equals("Terror") ? "selected" : "" %>>Terror</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="esSerie" name="esSerie" value="true" <%= esSerie ? "checked" : "" %>>
                                    <label class="form-check-label" for="esSerie">¿Es parte de una serie?</label>
                                </div>
                            </div>
                            <% } else if (tipoLibro.equals("No ficción")) { %>
                            <!-- Campos específicos para No Ficción -->
                            <div id="noFiccionFields">
                                <div class="mb-3">
                                    <label for="tema" class="form-label">Tema:</label>
                                    <select class="form-control" id="tema" name="tema">
                                        <option value="Ciencia" <%= tema.equals("Ciencia") ? "selected" : "" %>>Ciencia</option>
                                        <option value="Historia" <%= tema.equals("Historia") ? "selected" : "" %>>Historia</option>
                                        <option value="Biografía" <%= tema.equals("Biografía") ? "selected" : "" %>>Biografía</option>
                                        <option value="Autoayuda" <%= tema.equals("Autoayuda") ? "selected" : "" %>>Autoayuda</option>
                                        <option value="Tecnología" <%= tema.equals("Tecnología") ? "selected" : "" %>>Tecnología</option>
                                        <option value="Filosofía" <%= tema.equals("Filosofía") ? "selected" : "" %>>Filosofía</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="nivelAcademico" class="form-label">Nivel académico:</label>
                                    <select class="form-control" id="nivelAcademico" name="nivelAcademico">
                                        <option value="Básico" <%= nivelAcademico.equals("Básico") ? "selected" : "" %>>Básico</option>
                                        <option value="Medio" <%= nivelAcademico.equals("Medio") ? "selected" : "" %>>Medio</option>
                                        <option value="Superior" <%= nivelAcademico.equals("Superior") ? "selected" : "" %>>Superior</option>
                                        <option value="Especializado" <%= nivelAcademico.equals("Especializado") ? "selected" : "" %>>Especializado</option>
                                    </select>
                                </div>
                            </div>
                            <% } else if (tipoLibro.equals("Referencia")) { %>
                            <!-- Campos específicos para Referencia -->
                            <div id="referenciaFields">
                                <div class="mb-3">
                                    <label for="tipoReferencia" class="form-label">Tipo de referencia:</label>
                                    <select class="form-control" id="tipoReferencia" name="tipoReferencia">
                                        <option value="Enciclopedia" <%= tipoReferencia.equals("Enciclopedia") ? "selected" : "" %>>Enciclopedia</option>
                                        <option value="Diccionario" <%= tipoReferencia.equals("Diccionario") ? "selected" : "" %>>Diccionario</option>
                                        <option value="Manual" <%= tipoReferencia.equals("Manual") ? "selected" : "" %>>Manual</option>
                                        <option value="Atlas" <%= tipoReferencia.equals("Atlas") ? "selected" : "" %>>Atlas</option>
                                        <option value="Guía" <%= tipoReferencia.equals("Guía") ? "selected" : "" %>>Guía</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="actualizaciones" class="form-label">Actualizaciones:</label>
                                    <input type="text" class="form-control" id="actualizaciones" name="actualizaciones" value="<%= actualizaciones %>" placeholder="Ej: Edición 2023, Revisión 5">
                                </div>
                            </div>
                            <% } %>
                            
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                                <a href="list.jsp" class="btn btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6 text-center">
                <img src="../img/book.png" alt="Editar libro" class="img-fluid rounded" style="max-height: 350px;">
                <div class="mt-3">
                    <div class="alert alert-info">
                        <p><strong>Nota:</strong> El ISBN y el tipo de libro no se pueden modificar.</p>
                        <p>Complete el formulario con los datos actualizados del libro.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function validateForm() {
            var añoPublicacion = document.getElementById('añoPublicacion').value;
            
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

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html>
