# Pagina web - Evaluación Parcial N°1: Primer pipeline de despliegue

**Asignatura:** INGENIERIA DEVOPS_004D_OLS 
**Integrantes:** Jorge Alfaro - Jerson Pedreros - Matías González

-------------

## 1. Descripción del Proyecto

Este repositorio contiene la implementación base y la configuración del pipeline DevOps para el servicio web del proyecto Evaluacion Parcial 1 Devops. 
El objetivo es establecer un flujo de trabajo colaborativo, automatizado y trazable utilizando Git, GitHub y GitHub Actions.

## 2. Estrategia de Ramificación

Para este proyecto se ha seleccionado el modelo **Trunk-Based Development**.

### Justificación

Trunk-based es una estrategia agil donde nos permite implementar cambios continuos mediante ramas de corta duracion, permitiendo a los colaboradores trabajar simultaneamente en ramas (feature) que se fusionan directamente en (main)
y ante errores son corregidos rapidamente con la rama (hotfix), permitiendo el desarrollo colaborativo sin regirse por una estructura y ramas de larga duracion lo cual puede ocasionar retrabajo ante cambios inesperados.

---

## 3. Guía de Buenas Prácticas y Convenciones

### Naming de Ramas

* **`main`**: Contiene exclusivamente código listo para producción y probado, es la rama principal donde se fusionan las ramas.

* **`feature/header-nav-bar`** -> Rama para la integración de la barra de navegacion..

* **`feature/description-decoration>`** -> es la decoracion de descripcion, desarrollada en style.css `**: Utilizada para desarrollar nueva decoracion a descripcion <p>.

* **`hotfix/<fix-padding-issue>`**  -> es el nombre para colocar en este caso es fix-padding`**: Correcciones críticas urgentes para la rama `main`.

* **`feature/echo-CI`** -> Rama para integracion continua: utilizada para ejecutar un echo en una maquina ubuntu mediante un evento de workflow que se activa con push o pull request.


### Convención de Commits

Todos los commits deben seguir el formato: `<tipo>: <descripción en minúsculas y presente>`

* `feat:` Nueva característica.

* `fix:` Corrección de errores.

* `ci:` Cambios en la configuración de integración continua.




### Flujo de Merge y Revisiones de Código

1. Ninguna rama se fusiona directamente a `main` sin un **Pull Request (PR)**.

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
