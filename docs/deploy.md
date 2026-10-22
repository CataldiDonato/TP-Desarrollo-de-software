# Deploy

Se despliegan tres piezas por separado. Las tres opciones de abajo tienen plan gratuito.

| Pieza | Servicio sugerido | Qué se sube |
|---|---|---|
| Base de datos | [Neon](https://neon.tech) (PostgreSQL administrado) | — |
| Backend | [Render](https://render.com) (Web Service) | carpeta `backend/` |
| Frontend | [Vercel](https://vercel.com) o [Netlify](https://netlify.com) | carpeta `frontend/` |

> Cualquier otro proveedor equivalente sirve (Supabase, Railway, un VPS con Docker, etc.): lo importante son las variables de entorno y los comandos de cada paso.

## 1. Base de datos (Neon)

1. Crear un proyecto en Neon y copiar la **connection string** (`postgresql://usuario:clave@host/neondb?sslmode=require`).
2. Esa URL es la `DATABASE_URL` del backend. Las tablas las crea el backend al desplegarse (paso 2).

## 2. Backend (Render → New → Web Service)

| Campo | Valor |
|---|---|
| Repositorio | este repo |
| Root Directory | `backend` |
| Build Command | `npm ci && npx prisma generate && npm run db:deploy` |
| Start Command | `npm start` |

Variables de entorno:

| Variable | Valor |
|---|---|
| `DATABASE_URL` | la connection string de Neon |
| `JWT_SECRET` | un texto largo y aleatorio (ej: salida de `openssl rand -hex 32`) |
| `CORS_ORIGIN` | la URL del frontend (se completa después del paso 3, ej: `https://restoflow.vercel.app`) |

Render define `PORT` solo. Cuando termine, abrir la URL del servicio: tiene que responder `{"estado":"OK", ...}`.

**Datos de prueba (una sola vez):** desde la PC, con la `DATABASE_URL` de Neon:

```bash
cd backend
DATABASE_URL="postgresql://...neon..." npm run seed
```

Crea los usuarios de prueba (admin, mozo y cocinero), mesas, medios de pago y productos.

## 3. Frontend (Vercel → Add New → Project)

| Campo | Valor |
|---|---|
| Root Directory | `frontend` |
| Framework Preset | Vite |
| Build Command | `npm run build` |
| Output Directory | `dist` |

Variable de entorno: `VITE_API_URL` = URL del backend + `/api` (ej: `https://restoflow-api.onrender.com/api`).

`frontend/vercel.json` (y `frontend/public/_redirects` para Netlify) hace que al recargar una ruta como `/mesas` se sirva la app en lugar de un 404.

## 4. Cerrar el circuito

1. Volver a Render y completar `CORS_ORIGIN` con la URL de Vercel. Guardar (redeploya solo).
2. Entrar al frontend con `admin@restoflow.com` / `admin1234` y probar el flujo: abrir una comanda con el mozo, prepararla con el cocinero y cobrarla.
3. Completar en el [README](../README.md) la sección **Deploy** con las dos URLs y dejar las credenciales de prueba.

## Problemas comunes

| Síntoma | Causa probable |
|---|---|
| El front muestra "Network Error" | `VITE_API_URL` mal escrita (falta `/api`) o `CORS_ORIGIN` no coincide exacto con la URL del front (sin `/` al final) |
| El backend no arranca: "Falta configurar JWT_SECRET" | Falta la variable `JWT_SECRET` |
| Login responde "Credenciales inválidas" con los usuarios de prueba | No se corrió el seed contra la base de Neon |
| La primera carga tarda ~1 minuto | El plan gratuito de Render "duerme" el servicio sin uso; abrir la URL del backend un rato antes de la demo |
