
# Imagen Nginx preparada para ejecutarse sin root
FROM nginxinc/nginx-unprivileged:stable-alpine

LABEL maintainer="Equipo DevOps - Duoc UC"
LABEL description="Microservicio web estático contenerizado para entorno cloud"

# Copiar únicamente los archivos necesarios
COPY index.html /usr/share/nginx/html/index.html

# Puerto utilizado por Nginx sin privilegios
EXPOSE 8080

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
