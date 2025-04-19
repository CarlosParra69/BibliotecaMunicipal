# Usa la imagen oficial de Tomcat
FROM tomcat:9.0

# Borra las apps por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia tu archivo WAR al directorio webapps y lo nombra ROOT.war para que sea la app principal
COPY target/Sistema_gestion_libros-1.0.war /usr/local/tomcat/webapps/ROOT.war

# Expone el puerto por defecto de Tomcat
EXPOSE 8080

# Comando para ejecutar Tomcat
CMD ["catalina.sh", "run"]
