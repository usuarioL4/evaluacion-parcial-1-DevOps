# Microservicio - Evaluación Parcial N°1: Primer pipeline de despliegue

**Asignatura:** INGENIERIA DEVOPS_004D_OLS
**Institución:** Duoc UC  
**Integrantes:** Jorge Alfaro - Jerson Pedreros - Matías González

-------------

## 1. Descripción del Proyecto

Este repositorio contiene la implementación base y la configuración del pipeline DevOps para el microservicio web del proyecto Evaluacion Parcial 1 Devops. 
El objetivo es establecer un flujo de trabajo colaborativo, automatizado y trazable utilizando Git, GitHub y GitHub Actions.

## 2. Estrategia de Ramificación

Para este proyecto se ha seleccionado el modelo **GitFlow**.

### Justificación

GitFlow es una estrategia altamente estructurada orientada a proyectos que requieren un ciclo de liberación de software ordenado. 
Nos permite mantener la estabilidad del código en producción (`main`) mientras desarrollamos nuevas funcionalidades en paralelo (`develop`) e introducimos soluciones de emergencia rápidas (`hotfix`) sin interrumpir las características en desarrollo.

---

## 3. Guía de Buenas Prácticas y Convenciones

### Naming de Ramas

* **`main`**: Contiene exclusivamente código listo para producción y probado.

* **`develop`**: Rama base para la integración de funcionalidades.

* **`feature/<nombre-funcionalidad> -> es el nombre para colocar en este caso es style.css `**: Utilizada para desarrollar nuevas características.

* **`hotfix/<nombre-correccion> -> es el nombre para colocar en este caso es fix-padding`**: Correcciones críticas urgentes para la rama `main`.



### Convención de Commits

Todos los commits deben seguir el formato: `<tipo>: <descripción en minúsculas y presente>`

* `feat:` Nueva característica.

* `fix:` Corrección de errores.

* `docs:` Cambios en la documentación.

* `ci:` Cambios en la configuración de integración continua.

* `refactor:` Refactorización de código.



### Flujo de Merge y Revisiones de Código

1. Ninguna rama se fusiona directamente a `main` o `develop` sin un **Pull Request (PR)**.

2. Cada PR requiere al menos una revisión aprobada por el otro integrante del equipo.

3. Se evalúan ejecuciones automatizadas de integración continua (GitHub Actions) antes del merge.

-----------------------------

## 4. Estructura del Repositorio

├── .github/

│  └── workflows/

│    └── ci.yml     # Workflow de CI con GitHub Actions

├── css/

│  └── style.css      # Estilos de la aplicación

├── index.html       # Punto de entrada de la aplicación

└── README.md        # Documentación general del proyecto
