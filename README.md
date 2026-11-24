# DevOps – Evaluación Parcial 3

## 1. Estrategia de monitoreo (IE1)

Se utiliza **AWS CloudWatch** como herramienta de monitoreo de la infraestructura desplegada en Amazon EC2.

Mediante CloudWatch Agent se recopilan métricas de rendimiento, como el consumo de CPU, memoria RAM y almacenamiento.

Estas métricas permiten observar el comportamiento de los recursos y detectar posibles problemas de rendimiento. CloudWatch también permite integrar registros de errores y configurar alarmas de disponibilidad mediante los mecanismos de recopilación correspondientes.

## 2. Estrategia de despliegue (IE2)

Se utiliza **Docker Compose** como herramienta para administrar y desplegar los componentes de la aplicación, en reemplazo de Kubernetes, según la modificación autorizada para la evaluación.

El despliegue se realiza manualmente en AWS EC2 mediante:

```bash
docker compose up -d --build
```

Docker Compose permite definir los servicios, sus redes, puertos y configuraciones en un archivo YAML, facilitando la administración de los contenedores.

El despliegue se mantiene separado del pipeline de integración continua, permitiendo decidir cuándo actualizar la aplicación.

## 3. Estrategia de observación (IE3)

La observabilidad se aborda mediante métricas de infraestructura y resultados de los controles de integración continua.

Las herramientas consideradas son:

| Métrica | Herramienta |
|---|---|
| CPU y memoria | AWS CloudWatch |
| Errores registrados | CloudWatch Logs, si está configurado |
| Cobertura de pruebas | SonarQube, si se importan reportes de cobertura |
| Tiempo de despliegue | Medición manual del despliegue con Docker Compose |

El dashboard de CloudWatch permite visualizar el consumo de recursos de la instancia EC2.

Las métricas de calidad del código se consultan mediante SonarQube Cloud. El pipeline actual no genera reportes de cobertura ni mide automáticamente la duración del despliegue manual.

## 4. Estrategia de políticas de cumplimiento (IE5)

Se implementaron controles mediante **SonarQube Cloud** y reglas de protección de ramas en GitHub.

SonarQube realiza análisis estático del código para identificar problemas relacionados con seguridad, fiabilidad y mantenibilidad. El Quality Gate permite evaluar si el código cumple las condiciones de calidad establecidas.

En GitHub se configuraron las siguientes reglas de Branch Protection:

- **Require a pull request before merging:** exige utilizar Pull Requests para integrar cambios.
- **Require approvals:** solicita aprobación antes de realizar el merge.
- **Require status checks to pass before merging:** exige que las verificaciones obligatorias finalicen correctamente.

Estas políticas permiten controlar la incorporación de cambios a la rama principal.

## 5. Documentación sobre integración en el pipeline CI/CD (IE4)

Se implementó un pipeline de integración continua mediante GitHub Actions, ejecutado automáticamente al realizar un push a la rama `main` o manualmente mediante `workflow_dispatch`.

El pipeline contempla las siguientes etapas:

1. **Checkout:** obtiene el código fuente del repositorio.
2. **Validación estructural:** verifica que exista `index.html` y contenga la etiqueta HTML.
3. **SonarQube Cloud:** realiza análisis estático y espera el resultado del Quality Gate.
4. **Docker Buildx:** configura las herramientas necesarias para construir imágenes.
5. **Docker Build:** construye una imagen Docker identificada mediante el SHA del commit.
6. **Smoke Test:** inicia un contenedor temporal y comprueba que la aplicación responda con HTTP 200.
7. **Trazabilidad:** registra el identificador del commit y la etiqueta de la imagen validada.

Estas verificaciones permiten determinar si una versión supera los controles establecidos antes de considerarla candidata para el despliegue manual.

El despliegue en AWS EC2 se realiza por separado utilizando Docker Compose.

## 6. Estrategia ante fallas críticas de seguridad y calidad (IE6)

El pipeline utiliza un mecanismo de interrupción automática ante errores en sus etapas de validación.

Se contemplan las siguientes condiciones de fallo:

- **Quality Gate rechazado:** SonarQube detecta un incumplimiento de las políticas de calidad o seguridad configuradas.
- **Validación estructural fallida:** el archivo HTML no cumple la comprobación básica.
- **Error de construcción:** Docker no consigue construir la imagen.
- **Smoke Test fallido:** la aplicación no responde con HTTP 200 durante los intentos establecidos.

Para integrar el resultado de SonarQube se utiliza:

```yaml
-Dsonar.qualitygate.wait=true
```

Esta propiedad hace que el pipeline espere la evaluación del Quality Gate. Si el resultado es rechazado, la acción falla y no se ejecutan las etapas posteriores.

El mismo comportamiento se aplica a las demás validaciones cuando sus comandos terminan con un código de error.

Para demostrar el indicador IE6, se debe presentar una ejecución fallida en GitHub Actions, evidenciando que el pipeline se detuvo antes de completar sus etapas.

## Conclusión

Se implementó una estrategia DevOps basada en integración continua con GitHub Actions, análisis estático mediante SonarQube Cloud, políticas de protección de ramas y despliegue manual mediante Docker Compose en AWS EC2.

El monitoreo de infraestructura se realiza con AWS CloudWatch, mientras que las validaciones automatizadas permiten detectar errores antes de seleccionar una versión para despliegue.
