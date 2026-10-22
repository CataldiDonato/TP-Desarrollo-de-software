# Cumplimiento de los requisitos de Aprobación Directa

Requisitos tomados de [utnfrrodsw/tp](https://github.com/utnfrrodsw/tp). Grupo de 4 integrantes.

## Backend

| Requisito | Dónde está |
|---|---|
| JavaScript | TypeScript (superset de JS) en modo `strict` — [tsconfig.json](../backend/tsconfig.json) |
| Framework web con middlewares | Express 5: `cors`, `express.json`, `verificarToken`, `verificarRol` — [app.ts](../backend/src/app.ts) |
| API REST | [API.md](../backend/docs/API.md) |
| Base de datos persistente y externa | PostgreSQL |
| Persistencia con ORM | Prisma 7 — [schema.prisma](../backend/prisma/schema.prisma) y [migraciones](../backend/prisma/migrations) |
| Arquitectura en capas | routes → controllers → services → repositories — [arquitectura](arquitectura.md#backend-en-capas) |
| Validación y manejo de errores | [validation.ts](../backend/src/utils/validation.ts), [app-error.ts](../backend/src/utils/app-error.ts); respuestas `{ message }` con 400/401/403/404/409 |
| Dependencias registradas | [package.json](../backend/package.json) (`npm install`) |
| 1 test automatizado por integrante | 4 archivos de tests unitarios en [backend/tests](../backend/tests) (validación, contraseñas, precios, reservas) |
| 1 test de integración | [api.integration.test.ts](../backend/tests/api.integration.test.ts): levanta la API real contra la base |
| Login y 2+ niveles de acceso | JWT + contraseñas con scrypt; roles Administrador, Mozo y Cocinero — [auth.service.ts](../backend/src/services/auth.service.ts) |
| Rutas protegidas por nivel de acceso | Todas salvo el login pasan por `verificarToken`; cada router usa `verificarRol` — [routes/](../backend/src/routes) |
| Ambientes (.env) | [.env.example](../backend/.env.example): `DATABASE_URL`, `JWT_SECRET`, `PORT`, `CORS_ORIGIN` |

## Frontend

| Requisito | Dónde está |
|---|---|
| Framework de frontend | React 19 + Vite |
| HTML5 | JSX semántico (`nav`, `main`, `section`, `header`, `article`, formularios con `label`) |
| CSS con framework | **Tailwind CSS 4** — [index.css](../frontend/src/index.css) |
| Mobile-first y 3 breakpoints | Utilidades de Tailwind sin prefijo para celular y `sm:` / `md:` / `lg:` (640 / 768 / 1024 px) |
| UX/UI sin manual | Mensajes de éxito/error (toasts), confirmaciones antes de borrar, estados de carga, menú según el rol |
| Eventos del usuario | `onClick`, `onChange`, `onSubmit` en todas las pantallas |
| Manejo de errores amigable | Mensajes del backend mostrados con toast o en pantalla — [formato.js](../frontend/src/utils/formato.js) |
| Reactividad ante un estado | `useState` / `useEffect` (filtros que recargan, polling de cocina) |
| Input property | `Modal` recibe `titulo` y `children`; los formularios reciben `xInicial` — [Modal.jsx](../frontend/src/components/common/Modal.jsx) |
| Output property | `onCerrar`, `onGuardado`, `onCancelar`, `onCambio` |
| Al menos un servicio | [services/](../frontend/src/services) (una función por endpoint sobre axios) |
| Modelos con clases | [models/](../frontend/src/models): una clase por entidad, para respuestas (`desdeApi`) y requests (`toApi`) |
| Patrón de diseño OO | **Factory Method** en la clase base [Modelo](../frontend/src/models/Modelo.js); en el backend, **Repository** |
| Dependencias registradas | [package.json](../frontend/package.json) |
| Test unitario de un componente | [Modal.test.jsx](../frontend/src/components/common/Modal.test.jsx) |
| Test end-to-end | [e2e/](../frontend/e2e): flujo del administrador y circuito completo mozo → cocina → cobro |
| Login y protección por nivel de usuario | [RutaProtegida.jsx](../frontend/src/routes/RutaProtegida.jsx) + [AppRouter.jsx](../frontend/src/routes/AppRouter.jsx) |
| Ambientes (.env) | [.env.example](../frontend/.env.example): `VITE_API_URL` |

## Funcionales

| Requisito | Dónde está |
|---|---|
| CRUDs de todas las clases de negocio | Usuarios, Categorías, Medios de pago, Mesas, Productos (con historial de precios), Reservas y Comandas (alta, consulta, edición de productos, cobro y cancelación) |
| Listados con filtro + detalle | Cocina (filtro por estado → detalle de la comanda) · Mesas (por estado → detalle con comanda activa y reservas) · Comandas (por estado → detalle con productos y cobro) · Reservas (cliente y día) · Productos (nombre y categoría → historial de precios) |
| 1 CUU por integrante (4), al menos 2 relacionados | 1) Apertura de mesa y carga de pedido · 2) Reserva con disponibilidad · 3) Ciclo de cocina · 4) Cobro y cierre de mesa. 1 → 3 → 4 usan la misma comanda |

## Entrega

| Requisito | Estado |
|---|---|
| README con instrucciones de instalación | [README](../README.md) |
| Proposal actualizada con links a los PR | [proposal.md](../proposal.md) |
| Documentación de la API | [API.md](../backend/docs/API.md) |
| Evidencia de tests automáticos | [backend](../backend/docs/evidencia-tests.md) · [frontend](../frontend/docs/evidencia-tests.md) |
| Minutas y tracking | [minutas](minutas/README.md) · [tracking](tracking.md) |
| Video demo | *pendiente: link en el README* |
| Links de deploy y credenciales | *pendiente: ver [deploy.md](deploy.md)* |
| Contacto para la defensa | [README](../README.md#contacto) |
