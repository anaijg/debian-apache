# Actividad apache - docker
# Unidad 1
## Comandos Docker usados

1. Descargar imagen del [hub de docker](https://hub.docker.com)
```
docker pull debian:bookworm-slim
```
2. Arrancar contenedor con nombre y puerto (-p), interactivo (-i), con terminal (-t) en *modo detached* (-d)

```
docker run -it -d --name miprimer-debian -p 8080:80 debian:bookworm-slim
```

3. Ejecutar una shell *bash* en el contenedor
```
docker exec -it miprimer-debian bash
```

4. Una vez dentro del contenedor, instalar paquete de **apache2**
```
apt update
apt install apache2
```
5. Arrancar servicio apache

```
service apache2 start
```

6. Comprobar desde navegador que el servidor web responde

```
http://localhost:8080
```

7. Crear una página nueva html en `/var/www/html` llamada carlos.html

```
echo "hola soy carlos" > carlos.html
```

8. Acceder desde navegador

```
http://localhost:8080/carlos.html
```

9. Acceder desde navegador de línea de comandos *elinks*

```
apt install elinks
...
elinks http://localhost/carlos.html
```

10. Hacer fichero llamado `Dockerfile` que automatice los pasos anteriores

```dockerfile
# Descargar debian bookworm-slim
FROM debian:bookworm-slim

# Instalar apache y utilidades
RUN apt update
RUN apt install -y apache2 elinks

# Copia fichero al contenedor
ADD carlos.html /var/www/html

# Exponer el puerto 80
EXPOSE 80

# Fijar el directorio de trabajo
WORKDIR /var/www/html

# Ejecutar apache
CMD ["apachectl", "-D", "FOREGROUND"]
```

11. Crear la imagen a partir del dockerfile

```
docker build -t midebian:1.0 .
```

12. Ejecutar el contenedor

```
docker run -it -d --name miprimer-debian -p 8080:80 midebian:1.0
```

13. Comando que copia un archivo local a un contenedor
```
docker cp apache-logo.png miprimer-debian:/var/www/html
```

14. Crear fichero docker-compose.yml para que arranque el apache con un volumen
que mapea la carpeta raíz de los documentos html de apache con una carpeta local

```yml
version: "3.9"

services:
  apache:
    image: midebian:1.0
    container_name: misegundo-debian
    ports:
      - 8081:80
    volumes:
      - ./html:/var/www/html
```