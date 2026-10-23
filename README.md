# Proyecto DevOps: Pipeline CI/CD, Contenerización y Orquestación (Evaluación Parcial N°2)

**Asignatura:** Ingeniería DevOps
**Integrantes:** Matías Gonzalez, Jerson Pedreros, Jorge Alfaro

--- 

## Tabla de Contenidos
1. Descripción del Proyecto
2. Estrategia de Contenerización
3. Pruebas Automatizadas y Políticas de Calidad
4. Seguridad, Gobernanza y Bloqueos
5. Despliegue Automático y Trazabilidad
6. Orquestación de Contenedores
7. Instrucciones de Ejecución Local
8. Declaración Ética de Uso de IA y Reflexiones Personales

---

## 1. Descripción del Proyecto
Este repositorio contiene la implementación integral del ciclo de vida de desarrollo automatizado (CI/CD) para el microservicio web del curso. La solución migra la aplicación hacia una arquitectura basada en contenedores modernos, garantizando alta disponibilidad, pruebas automatizadas de integración, análisis continuo de vulnerabilidades en la cadena de suministro de software y trazabilidad de extremo a extremo.

---

## 2. Estrategia de Contenerización (IE1)
Para cumplir con el uso eficaz de contenedores e imágenes optimizadas:
* **Imagen Base:** Se implementó **`nginx:alpine`**, una distribución ultraligera basada en Alpine Linux que minimiza el tamaño de almacenamiento de la imagen, optimiza los tiempos de transferencia en red y reduce drásticamente la superficie de ataque frente a vulnerabilidades.
* **Dockerfile:** Encapsula de forma limpia los elementos estáticos del microservicio hacia el directorio raíz de Nginx (`/usr/share/nginx/html`) y expone el puerto estándar HTTP (80).

---

## 3. Pruebas Automatizadas y Políticas de Calidad (IE2)
El pipeline de Integración Continua (CI) ejecuta validaciones estrictas antes de aprobar el empaquetado:
* **Validación Estática:** Comprobación automatizada de la existencia e integridad estructural del archivo `index.html`.
* **Smoke Test (Prueba Funcional):** El runner de GitHub Actions levanta la imagen recién construida en un entorno aislado y ejecuta una petición HTTP automatizada (`curl`). Si la aplicación no responde con un código de éxito **HTTP 200 OK**, el pipeline emite un error (`exit 1`) y se bloquea de inmediato.

---

## 4. Seguridad, Gobernanza y Bloqueos (IE3)
Para asegurar el cumplimiento de los estándares de seguridad en entornos con contenedores:
* **Dependabot:** Activado de forma nativa en GitHub para el monitoreo continuo y alertas automáticas de dependencias.
* **Análisis de Seguridad con Snyk:** Integrado dentro del pipeline de CI/CD analizando directamente la imagen de Docker mediante `snyk/actions/docker`. Está configurado con un umbral estricto (`--severity-threshold=high`) y políticas de bloqueo activo (`continue-on-error: false`) para impedir el paso de artefactos vulnerables.

---

## 5. Despliegue Automático y Trazabilidad (IE4)
El flujo automatiza la gestión de versiones y auditoría:
* **Trazabilidad por Commit:** Cada imagen generada es etiquetada unívocamente utilizando el hash SHA del commit (`${{ github.sha }}`) además de la etiqueta `latest`, lo que permite conocer con precisión milimétrica qué versión exacta del código fuente originó cada contenedor.

---

## 6. Orquestación de Contenedores (IE5)
Para gestionar soluciones escalables y asegurar la estabilidad operativa mediante **Docker Compose**:
* **Alta Disponibilidad:** Configuración de políticas de recuperación automática ante fallos (`restart: always`).
* **Verificaciones de Salud (Healthcheck):** Monitoreo continuo del estado operativo del servidor Nginx dentro del contenedor.
* **Límites de Recursos:** Restricciones estrictas de hardware (`deploy.resources.limits`) para CPU y memoria RAM, asegurando un desempeño eficiente y controlado.

---

## 7. Instrucciones de Ejecución Local
Para desplegar y verificar la solución en un entorno local:

1. Clonar el repositorio:
   git clone https://github.com/usuarioL4/evaluacion-parcial-1-DevOps
   cd evaluacion-parcial-1-DevOps

## Reflexiones Individuales

1. Jorge Alfaro: 

Mi aporte al proyecto fue la implementacion del pipeline CI/CD usando GitHub Actions. Estructure el archivo YAML para automatizar la contruccion de la imagen docker, la ejecucion de pruebas y la implementacion del token snyk para la seguridad.

Tuve una dificultad cuando intentaba correr el pipeline ya que se bloqueaba, por otro lado tuve que implementar el token snyk en los secretos del repositorio, por ultimo solucione un problema donde el puerto 8080 quedaba ocupado por el contenedor de pruebas lo que impedia que el docker compose levantara el servicio final

Como aprendizaje final me quedo con que cuando vi que paso todo el flujo en verde, entendi que eso era el valor de esta asignatura, el hecho de que hay que probar el codigo, una vez escaneado el codigo ahi finalmente se despliega de forma automatica, por eso es importante tener un pipeline bien hecho para cada proyecto.
