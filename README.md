# RestoFlow

Plataforma full-stack para la gestión interna de un restaurante: conecta a **mozos**, **cocina** y **administración** para manejar mesas, reservas, pedidos, la pantalla de cocina y el cobro.

Trabajo práctico de **Desarrollo de Software** — UTN FRRo. Requisitos de la cátedra: [utnfrrodsw/tp](https://github.com/utnfrrodsw/tp).

| Legajo | Integrante |
|---|---|
| 54310 | Cataldi, Donato |
| 54152 | Vada, Gaspar Ignacio |
| 55264 | Curti, Tomás Andrés |
| 55220 | Acosta, Ismael Fabricio |

## Video demo

▶️ **[Ver el video del sistema funcionando](PEGAR_LINK_DEL_VIDEO)**

## Deploy

| | URL |
|---|---|
| Aplicación | *(completar después del deploy)* |
| API | *(completar después del deploy)* |

Credenciales de prueba (las crea el seed):

| Rol | Email | Contraseña |
|---|---|---|
| Administrador | admin@restoflow.com | admin1234 |
| Mozo | mozo@restoflow.com | mozo1234 |
| Cocinero | cocinero@restoflow.com | cocinero1234 |

## Qué hace

| Rol | Puede |
|---|---|
| **Mozo** | Ver el salón, abrir una mesa y cargar el pedido (con observaciones para la cocina), agregar productos, cobrar con un medio de pago y gestionar reservas |
| **Cocinero** | Ver los pedidos activos en la pantalla de cocina (KDS), filtrarlos por estado, ver el detalle de cada comanda y avanzar cada plato: pendiente → en preparación → listo |
| **Administrador** | Todo lo anterior (la cocina, solo para mirar) más el dashboard del día y los ABM de usuarios, mesas, productos (con historial de precios), categorías y medios de pago |

## Tecnologías

| | |
|---|---|
| Backend | Node.js · TypeScript (`strict`) · Express 5 · Prisma 7 · PostgreSQL · JWT |
| Frontend | React 19 · Vite · Tailwind CSS 4 · React Router · Axios |
| Tests | `node:test` (backend) · Vitest + Testing Library · Playwright (e2e) |

## Estructura del repositorio

```
├── backend/     API REST (Express + Prisma)             → backend/README.md
├── frontend/    Aplicación web (React + Vite)            → frontend/README.md
├── docs/        Documentación del TP                     → docs/README.md
├── scripts/     Utilidades (carga del tablero de tareas)
└── proposal.md  Propuesta actualizada
```

## Instalación y ejecución

Requisitos: **Node.js 20+** y **PostgreSQL 14+** (local o en la nube).

### 1. Backend

```bash
cd backend
npm install
cp .env.example .env        # completar DATABASE_URL y JWT_SECRET
npx prisma migrate deploy   # crea las tablas
npx prisma generate
npm run seed                # usuarios de prueba, mesas, medios de pago y productos
npm run dev                 # http://localhost:3000
```

### 2. Frontend (en otra terminal)

```bash
cd frontend
npm install
cp .env.example .env        # VITE_API_URL=http://localhost:3000/api
npm run dev                 # http://localhost:5000
```

Entrar con cualquiera de los usuarios de prueba de la tabla de arriba.

### Tests

```bash
cd backend && npm test               # unitarios + integración (necesita la base levantada)
cd frontend && npm test              # unitarios y de componente
cd frontend && npx playwright install chromium && npm run test:e2e   # e2e (necesita el backend con el seed)
```

## Documentación

Todo está en [docs/](docs/README.md): propuesta, arquitectura y modelo de datos, [API](backend/docs/API.md), evidencia de tests, metodología, minutas, tracking y deploy.

## Contacto

Para coordinar la defensa:

| Integrante | GitHub | Email |
|---|---|---|
| Donato Cataldi | [@CataldiDonato](https://github.com/CataldiDonato) | *(completar)* |
| Gaspar Vada | [@GasparVada](https://github.com/GasparVada) | *(completar)* |
| Tomás Curti | *(completar)* | *(completar)* |
| Ismael Acosta | [@IsmaelAcosta-IAL](https://github.com/IsmaelAcosta-IAL) | *(completar)* |
