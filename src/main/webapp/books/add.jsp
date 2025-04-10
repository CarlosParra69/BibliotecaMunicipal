<%@page import="sena.adso.sistema_gestion_libros.model.*"%>
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
            
            // Validar año de publicación
            var año = parseInt(añoPublicacion);
            var añoActual = new Date().getFullYear();
            if (isNaN(año) || año < 1000 || año > añoActual) {
                showErrorAlert('Año inválido', 'El año de publicación debe ser válido (entre 1000 y ' + añoActual + ').');
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
        <p>Agregar Nuevo Libro</p>
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
            
            // Procesamiento del formulario
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                try {
                    String isbn = request.getParameter("isbn");
                    String titulo = request.getParameter("titulo");
                    String autor = request.getParameter("autor");
                    String tipo = request.getParameter("tipo");
                    String añoPublicacionStr = request.getParameter("añoPublicacion");
                    
                    // Debug - Imprimir los valores para verificar
                    System.out.println("Tipo seleccionado: " + tipo);
                    
                    // Usar un año predeterminado si hay problemas con el valor recibido
                    int añoPublicacion = 2000; // Valor predeterminado
                    
                    try {
                        if (añoPublicacionStr != null && !añoPublicacionStr.trim().isEmpty()) {
                            añoPublicacion = Integer.parseInt(añoPublicacionStr.trim());
                            System.out.println("[CRÍTICO] Año de publicación convertido: " + añoPublicacion);
                        }
                    } catch (NumberFormatException e) {
                        // Si hay error al convertir, simplemente usamos el valor predeterminado
                        System.out.println("[CRÍTICO] Error al convertir año de publicación: " + e.getMessage());
                        System.out.println("[CRÍTICO] Usando año predeterminado: " + añoPublicacion);
                    }
                    
                    // Registrar el valor en la consola para depuración
                    System.out.println("[CRÍTICO] VALOR FINAL DEL AÑO ANTES DE CREAR LIBRO: " + añoPublicacion);
                    
                    // Guardar el año para uso en los parámetros si necesitamos redireccionar
                    session.setAttribute("ultimoAñoPublicacion", añoPublicacion);
                    
                    // Obtener el gestor de libros
                    LibroManager manager = LibroManager.getInstance();
                    
                    // Crear el libro según el tipo
                    Libro nuevoLibro = null;
                    
                    if ("Ficcion".equals(tipo)) {
                        String genero = request.getParameter("genero");
                        if (genero == null || genero.trim().isEmpty()) genero = "Fantasía"; // Valor predeterminado
                        boolean esSerie = "true".equals(request.getParameter("esSerie"));
                        
                        nuevoLibro = new LibroFiccion(isbn, titulo, autor, añoPublicacion, genero, esSerie);
                        System.out.println("[CRÍTICO] Libro ficción creado con año: " + añoPublicacion);
                        System.out.println("[CRÍTICO] Verificando: " + nuevoLibro.getAñoPublicacion());
                    } 
                    else if ("NoFiccion".equals(tipo)) {
                        String tema = request.getParameter("tema");
                        if (tema == null || tema.trim().isEmpty()) tema = "Ciencia"; // Valor predeterminado
                        
                        String nivelAcademico = request.getParameter("nivelAcademico");
                        if (nivelAcademico == null || nivelAcademico.trim().isEmpty()) nivelAcademico = "Básico"; // Valor predeterminado
                        
                        nuevoLibro = new LibroNoFiccion(isbn, titulo, autor, añoPublicacion, tema, nivelAcademico);
                    } 
                    else if ("Referencia".equals(tipo)) {
                        String tipoReferencia = request.getParameter("tipoReferencia");
                        if (tipoReferencia == null || tipoReferencia.trim().isEmpty()) tipoReferencia = "Enciclopedia"; // Valor predeterminado
                        
                        String actualizaciones = request.getParameter("actualizaciones");
                        if (actualizaciones == null) actualizaciones = "";
                        
                        // Imprimir valores para depuración
                        System.out.println("Creando libro de referencia con año: " + añoPublicacion);
                        nuevoLibro = new LibroReferencia(isbn, titulo, autor, añoPublicacion, tipoReferencia, actualizaciones);
                        System.out.println("Libro referencia creado, verificando año: " + nuevoLibro.getAñoPublicacion());
                    } else {
                        errorMsg = "No se pudo crear el libro. Tipo no reconocido: " + tipo;
                        System.out.println(errorMsg);
                    }
                    
                    // Agregar el libro si se creó correctamente
                    if (nuevoLibro != null) {
                        System.out.println("[CRÍTICO] VERIFICACIÓN ANTES DE AGREGAR - Libro: " + 
                                           nuevoLibro.getTitulo() + ", Año: " + nuevoLibro.getAñoPublicacion());
                        
                        // Establecer el año explícitamente de nuevo antes de agregar (por si acaso)
                        nuevoLibro.setAñoPublicacion(añoPublicacion);
                        
                        manager.agregarLibro(nuevoLibro);
                        
                        System.out.println("[CRÍTICO] VERIFICACIÓN DESPUÉS DE AGREGAR:");
                        manager.verificarEstadoContenedor();
                        
                        response.sendRedirect("list.jsp?action=add&añoPublicacion=" + añoPublicacion + "&isbn=" + isbn);
                        return;
                    }
                    
                } catch (Exception e) {
                    errorMsg = "Error: " + e.getMessage();
                    e.printStackTrace();
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
                        <% if (errorMsg != null) { %>
                            <div class="alert alert-danger mb-3">
                                <%= errorMsg %>
                            </div>
                        <% } %>
                        <form id="libroForm" action="add.jsp" method="post" onsubmit="return validateForm();" accept-charset="UTF-8">
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
                                <select class="form-control" id="tipo" name="tipo" required>
                                    <option value="">Seleccione un tipo</option>
                                    <option value="Ficcion">Ficcion</option>
                                    <option value="NoFiccion">NoFiccion</option>
                                    <option value="Referencia">Referencia</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="añoPublicacion" class="form-label">Año de publicación:</label>
                                <input type="number" class="form-control" id="añoPublicacion" name="añoPublicacion" min="1000" max="<%= new java.util.Date().getYear() + 1900 %>" value="2014">
                                <small class="text-muted">Ingrese un año válido entre 1000 y <%= new java.util.Date().getYear() + 1900 %></small>
                            </div>
                            
                            <!-- Campos específicos para Ficción -->
                            <div id="ficcionFields" style="display: none;">
                                <h5 class="mt-3 mb-3">Información específica para Ficcion</h5>
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
                                <h5 class="mt-3 mb-3">Información específica para NoFiccion</h5>
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
                                <h5 class="mt-3 mb-3">Información específica para Referencia</h5>
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
                    <p class="text-muted">Los campos son obligatorios</p>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Sistema de Biblioteca</p>
    </footer>
</body>
</html>
