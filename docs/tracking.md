# Tracking de features, bugs e issues

Metodología: **Kanban** con GitHub Flow (ver [metodología](metodologia.md)). Columnas del tablero: *To Do → In Progress → Code Review → Done*.

El tablero vive en **GitHub Projects** del repo. Las tareas de las etapas ya terminadas se cargaron a posteriori como issues cerrados, con referencia a los commits y Pull Requests que las resolvieron. Para cargarlas se usa [`scripts/cargar-issues.sh`](../scripts/cargar-issues.sh). Las tareas nuevas se abren como issue, se trabajan en una rama `feature/`, `fix/` o `docs/` y entran por Pull Request.

Los commits se pueden ver en este repo: el historial de `backend/` y `frontend/` se conservó al unificarlos.

## Features

| # | Feature | Responsable | Estado | Evidencia |
|---|---|---|---|---|
| F1 | Setup backend (Node, Express, `.env.example`) | Cataldi | Hecho | `53a3ba8` |
| F2 | Setup frontend (React + Vite) | Curti | Hecho | `0d93bf9` |
| F3 | Prisma: schema del DER y migraciones | Cataldi | Hecho | `4e56dfe` |
| F4 | Backend en capas (routes / controllers / services / repositories) | Cataldi | Hecho | `5d50c3f` |
| F5 | CRUD Categorías y Productos con historial de precios | Cataldi | Hecho | `4a4424c`, `2e1be75` |
| F6 | CRUD Usuarios + dashboard + cocina (backend) | Acosta | Hecho | `fa0e202`, `001003b` |
| F7 | Frontend de dashboard, usuarios y cocina | Acosta | Hecho | `24a7160`, [PR front #1](https://github.com/CataldiDonato/TP-Desarrollo-de-software-Frontend/pull/1) |
| F8 | Módulo de salón: CRUD Mesas y Reservas, disponibilidad por horario | Vada | Hecho | `cecd986`, [PR back #1](https://github.com/CataldiDonato/TP-Desarrollo-de-software-Backend/pull/1) |
| F9 | CRUD Medios de pago | Curti | Hecho | `c569f67`, `a247141` |
| F10 | Comandas: apertura de mesa y carga de pedido (CUU 1) | Curti | Hecho | `1dcbc5c`, `a247141` |
| F11 | Login con JWT y protección de rutas por rol (back y front) | Cataldi | Hecho | `2fca9ee`, `fb97f48` |
| F12 | Cobro y cierre de mesa con transacción (CUU 4) | Cataldi | Hecho | `2e1be75` |
| F13 | Tests: unitarios e integración (back), componente y e2e (front) | Cataldi | Hecho | `2e1be75`, `469323a` |
| F14 | Documentación de la API | Cataldi | Hecho | `2e1be75` |
| F15 | Estilos con Tailwind CSS, mobile-first | Cataldi | Hecho | `5d04aeb` |
| F16 | Clases de modelo en el frontend (Factory Method) | Cataldi | Hecho | `40aee6b` |
| F17 | KDS: filtro por estado, observaciones y detalle de la comanda (CUU 3) | Cataldi | Hecho | `e73adb1`, `69d1be7`, `382cd30` |
| F18 | TypeScript strict y preparación para deploy (CORS, `db:deploy`) | Cataldi | Hecho | `25638e5`, `0c91d91` |
| F19 | Deploy de base, backend y frontend (Vercel) | Cataldi | Hecho | `b64ceae`, `5197884`, `0da9342`, `8577759`, `2322e5e`, `9825e69` |
| F20 | Video demo | *(asignar)* | Pendiente | — |

## Bugs corregidos

| # | Bug | Responsable | Evidencia |
|---|---|---|---|
| B1 | El seed guardaba la contraseña sin hashear | Acosta | `af99e71` |
| B2 | No se podía crear un producto: front y back mandaban campos distintos | Cataldi | `2e1be75` |
| B3 | Comandas con productos inventados y el mozo fijo en `id 1` | Cataldi | `2e1be75` |
| B4 | Los productos de una comanda nueva no llegaban a la cocina | Cataldi | `2e1be75` |
| B5 | Rutas de `detalle-comanda` cruzadas (GET creaba, PATCH borraba) | Cataldi | `2e1be75` |
| B6 | `/precio-producto` respondía siempre 400 | Cataldi | `2e1be75` |
| B7 | Se podían cargar reservas superpuestas en la misma mesa | Cataldi | `2e1be75` |
| B8 | Rutas sin control de rol (un cocinero podía crear reservas) | Cataldi | `2e1be75` |
| B9 | El cocinero mandaba su id a mano y podía hacerse pasar por otro | Cataldi | `2e1be75` |
| B10 | Los errores de Prisma devolvían rutas de archivos del servidor | Cataldi | `2e1be75` |
| B11 | Arreglos de comandas y home en el frontend | Curti | `2f55fe9`, `493ba69` |

## Issues abiertos (entrega de Aprobación Directa)

| # | Issue | Responsable |
|---|---|---|
| I1 | ~~Hacer el deploy y publicar links y credenciales en el README~~ (hecho) | Cataldi |
| I2 | Grabar el video demo y linkearlo en el README | *(asignar)* |
| I3 | Abrir el PR a `utnfrrodsw/tp` y completar el formulario de entrega | *(asignar)* |
| I4 | Completar presentes y decisiones en las [minutas](minutas/README.md) | Todos |
