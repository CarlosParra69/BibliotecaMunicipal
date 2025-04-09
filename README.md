
# 📚 Sistema de Gestión de Biblioteca - Java Web JSP

Este proyecto es un **Sistema de Gestión de Biblioteca** desarrollado con **Java Web usando JSP (JavaServer Pages)**. Permite la administración de libros, el control de préstamos y devoluciones, y además incluye un **chatbot integrado** para asistir a los usuarios con preguntas frecuentes o guiar el uso del sistema.

---

## 🧩 Características principales

- ✅ Gestión de libros: registrar, editar, eliminar y listar libros.
- ✅ Gestión de préstamos: asignar libros a usuarios y controlar su devolución.
- ✅ Buscador dinámico de libros y usuarios.
- ✅ Chatbot integrado para soporte automatizado.
- ✅ Interfaz web responsiva, con soporte para modo claro y oscuro.
- ✅ Diseño limpio y fácil de usar.

---

## 🛠️ Tecnologías utilizadas

- Java (Servlets + JSP)
- HTML5 / CSS3 / JavaScript
- Bootstrap (para el diseño responsivo)
- MySQL (como base de datos relacional)
- Apache Tomcat (servidor de aplicaciones)
- JSTL (Librería estándar de etiquetas JSP)

---

## 💬 Chatbot Integrado

El sistema incluye un chatbot básico que asiste a los usuarios en:

- Uso general del sistema.
- Búsqueda de libros.
- Consultas sobre préstamos.
- Horarios o reglas de la biblioteca.

El chatbot puede ser extendido con respuestas personalizadas y mejoras mediante NLP o integración con servicios como Dialogflow o GPT.

---

## 🚀 Cómo desplegar el proyecto

### Requisitos previos

- Java JDK 8 o superior
- Apache Tomcat 9+
- MySQL Server
- Maven (opcional, si usas proyecto tipo Maven)
- IDE recomendado: Eclipse, IntelliJ o NetBeans

### Pasos para correr el proyecto localmente

1. **Clona este repositorio:**

```bash
git clone https://github.com/tu-usuario/nombre-del-repositorio.git
```

2. **Importa el proyecto en tu IDE favorito** como un proyecto web (tipo Dynamic Web Project si estás usando Eclipse).

3. **Configura tu base de datos:**

- Crea una base de datos en MySQL con el nombre `biblioteca_db`.
- Ejecuta el script `database.sql` incluido en el proyecto para crear las tablas necesarias.

4. **Edita la conexión a la base de datos** en el archivo `DBConnection.java` o en el archivo de configuración donde manejes la conexión:

```java
String url = "jdbc:mysql://localhost:3306/biblioteca_db";
String username = "root";
String password = "tu_contraseña";
```

5. **Despliega en Apache Tomcat**:

- Ejecuta el proyecto desde tu IDE con Tomcat.
- O empaqueta el proyecto en un `.war` y colócalo en la carpeta `webapps` de Tomcat.

6. **Abre en tu navegador:**

```
http://localhost:8080/nombre-del-proyecto/
```

---

## 📂 Estructura del proyecto

```
📁 /src
   └── servlets/
   └── dao/
   └── model/
📁 /web
   └── index.jsp
   └── list.jsp
   └── chatbot.jsp
📁 /WEB-INF
   └── web.xml
📄 database.sql
📄 README.md
```

---

## 📸 Capturas de pantalla

> Puedes agregar imágenes aquí mostrando el diseño del sistema.

---

## 🙋‍♂️ Autor

- Nombre: [Tu Nombre]
- Contacto: [Tu email o enlace a tu perfil]
- LinkedIn: [opcional]

---

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más información.

---

## 🌟 Contribuciones

¡Las contribuciones son bienvenidas! Si encuentras errores o deseas proponer mejoras, no dudes en hacer un fork del repositorio y enviar un pull request.
