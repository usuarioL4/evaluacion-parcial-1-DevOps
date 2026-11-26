# Microservicio Nginx — Pipeline CI/CD y Observabilidad en AWS EC2

## 1. Arquitectura y Decisiones Técnicas

- **Contenedorización y seguridad (`Dockerfile`):** Se utilizó una imagen basada en `nginx-unprivileged` (con `curl` disponible para verificaciones de salud), ejecutando el servicio sin privilegios de `root` y escuchando en el puerto `8080` para reducir la superficie de ataque.
- **Orquestación, resiliencia y recursos (`docker-compose.yml`):**
  - Mapeo explícito de puertos `8080:8080` consistente con el contenedor no privilegiado.
  - Política `restart: always` para recuperación automática ante fallos del proceso o reinicios.
  - `healthcheck` periódico (`GET http://localhost:8080/`) para validar el estado saludable del servicio.
  - Límites y reservas de recursos (`cpus` y `memory`) para evitar saturación en la instancia EC2.
- **Integración y Entrega Continua (GitHub Actions + SonarCloud):**
  - Validación de calidad y seguridad del código/configuraciones mediante SonarCloud antes del despliegue.
  - *Smoke test* automatizado levantando el contenedor en un puerto de prueba (`8081:8080`) y verificando respuesta `HTTP 200` antes de desplegar.
  - Despliegue automatizado por SSH hacia la instancia EC2 (`100.62.149.105`) actualizando el repositorio en `~/app-devops`, reconstruyendo y levantando con `docker compose up -d --build`.
- **Observabilidad y Monitoreo (AWS CloudWatch):**
  - Envío de logs del contenedor mediante el driver `awslogs` hacia el grupo `/devops/microservicio` (stream `nginx-microservicio`).
  - Publicación de la métrica personalizada `TiempoDespliegue` en el namespace `DevOps/CICD` (`us-east-1`).
  - Configuración de una alarma en CloudWatch sobre el consumo de CPU (`> 50%`) para alertar ante posibles picos o saturación de la instancia.
  - Visualización centralizada en `Dashboard-Monitoreo-DevOps` junto con métricas de infraestructura y disponibilidad.

---

## 2. Resultados y Métricas Observadas

- **Pipeline CI/CD:** Ejecución completa en verde en GitHub Actions, con *smoke test* respondiendo `HTTP 200` y despliegue remoto completado en ~6 segundos según el log del workflow[cite: 2].
- **Estado del servicio en EC2:** Contenedor `app-devops-web-1` activo en `0.0.0.0:8080->8080/tcp`, pasando a estado saludable (`healthy`) y respondiendo `HTTP 200` en `http://localhost:8080/` y `http://100.62.149.105:8080/`[cite: 3].
- **Métricas y alarmas en CloudWatch:**
  - `TiempoDespliegue`: Registrada en `DevOps/CICD` (N. Virginia), con valores recientes en torno a **2.5 s** (tras una medición previa cercana a **6 s**)[cite: 4, 6].
  - `Disponibilidad`: En `1` dentro de `Dashboard-Monitoreo-DevOps`[cite: 6].
  - Alarma de CPU: Configurada para notificar cuando el uso de CPU supere el **50%**.
  - Recursos y métricas adicionales: `mem_used_percent` y `disk_used_percent` reportando datos del agente; `CPUUtilization` y `CoberturaPruebas` pendientes de ajuste de ventana/publicación reciente al momento de la captura[cite: 6].
- **Logs en CloudWatch:** Flujo activo en `/devops/microservicio`, registrando peticiones externas (`GET /favicon.ico` con `404` al no existir ícono) y comprobaciones periódicas `GET / HTTP/1.1` con `200`[cite: 5].

---

## 3. Apoyo con Inteligencia Artificial

En el diagnóstico de errores de configuración, ajuste de puertos (`8080`), configuración SSH/Git en la instancia EC2 y estructuración de este documento se contó con apoyo de inteligencia artificial como asistente técnico, validando cada cambio de forma práctica en el entorno real.

- **Referencia:** [https://bibliotecas.duoc.cl/ia](https://bibliotecas.duoc.cl/ia)

---

## 4. Reflexiones Finales

### Reflexión de Jorge Alfaro

En esta etapa me enfoqué principalmente en el entorno de **AWS CloudWatch**, diseñando y construyendo el dashboard (`Dashboard-Monitoreo-DevOps`) para centralizar y visualizar en tiempo real el comportamiento de nuestra instancia EC2 y del microservicio, integrando tanto métricas de infraestructura (CPU, memoria y disco) como métricas personalizadas del pipeline (`TiempoDespliegue` y `Disponibilidad`) y los registros de ejecución del contenedor[cite: 6]. Además, configuré una **alarma preventiva en CloudWatch** para recibir notificaciones en caso de que el consumo de CPU de la instancia supere el **50%**, permitiéndonos anticipar cuellos de botella o comportamientos anómalos antes de que afecten la disponibilidad del servicio.

Como principal aprendizaje me llevo que, al trabajar en la nube, desplegar una aplicación es solo la mitad del trabajo: es fundamental mantener una visión clara, trazable y en tiempo real de los recursos que se consumen. Contar con observabilidad y alertas tempranas no solo facilita detectar fallos operativos y validar el impacto de cada despliegue, sino que también permite optimizar el rendimiento y controlar los costos asociados a la infraestructura.

### Reflexión de Matias González

En esta etapa me centré en la configuración técnica del flujo de integración y entrega continua (CI/CD), así como en la estandarización del contenedor en Docker y docker-compose.yml. Trabajar con una imagen basada en nginx-unprivileged implicó alinear toda la arquitectura —desde el Dockerfile y el mapeo de puertos 8080:8080 hasta el smoke test automatizado en GitHub Actions y el healthcheck— para garantizar que el microservicio operara sin privilegios de root y respondiera correctamente antes y después de cada despliegue en la instancia EC2.

Como principal aprendizaje me llevo la importancia de automatizar las validaciones previas al despliegue, integrando análisis estático con SonarCloud y pruebas funcionales de humo (smoke tests con verificación HTTP 200), junto con una gestión ordenada de credenciales y llaves SSH entre GitHub Actions y el servidor remoto. Esto reduce drásticamente el margen de error humano y asegura que cada cambio subido al repositorio llegue a producción de forma predecible, segura y reproducible.
