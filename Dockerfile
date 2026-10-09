# Imagen a descargar: 
FROM debian:latest

# Actualizar el SO
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y apache2 elinks

# Copia el fichero al contenedor en la ruta indicada
COPY ana.html /var/www/html/ana.html

# Exponer el puerto 80
EXPOSE 80

# Fijar el directorio de trabajo
WORKDIR /var/www/html

# Ejecutar apache
CMD ["apachectl", "-D", "FOREGROUND"]