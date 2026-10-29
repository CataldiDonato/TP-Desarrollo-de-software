# Deploy

Se despliegan tres piezas por separado:

| Pieza | Dónde | URL |
|---|---|---|
| Base de datos | PostgreSQL administrado en la nube | — (solo la usa el backend, por `DATABASE_URL`) |
| Backend | [Vercel](https://vercel.com), como función serverless | https://tp-desarrollo-de-software-backend.vercel.app |
| Frontend | [Vercel](https://vercel.com), sitio estático (Vite) | https://tp-desarrollo-de-software-frontend.vercel.app |

Las credenciales de prueba están en el [README](../README.md#deploy).

## 1. Base de datos

1. Crear una base PostgreSQL en la nube (Neon, Supabase o similar) y copiar la **connection string** (`postgresql://usuario:clave@host/base?sslmode=require`).
2. Esa URL es la `DATABASE_URL` del backend.
3. Crear las tablas y cargar los datos de prueba desde la PC, una sola vez:

```bash
cd backend
DATABASE_URL="postgresql://..." npm run db:deploy   # aplica las migraciones
DATABASE_URL="postgresql://..." npm run seed        # usuarios de prueba, mesas, medios de pago y productos
```

## 2. Backend (Vercel → Add New → Project)

| Campo | Valor |
|---|---|
| Root Directory | `backend` |
| Framework Preset | Other |

Variables de entorno:

| Variable | Valor |
|---|---|
| `DATABASE_URL` | la connection string de la base |
| `JWT_SECRET` | un texto largo y aleatorio (ej: salida de `openssl rand -hex 32`) |
| `CORS_ORIGIN` | la URL del frontend, sin `/` al final |

Cómo corre en Vercel:

- `index.ts` exporta la app de Express. Si existe la variable `VERCEL` (la define Vercel solo) no llama a `app.listen`: cada request la atiende la función serverless. En local sigue levantando el servidor en el puerto 3000.
- El script `postinstall` corre `prisma generate`, así el cliente de Prisma se genera en cada build.

Para verificar: abrir la URL del backend tiene que responder `{"estado":"OK", ...}`.

## 3. Frontend (Vercel → Add New → Project)

| Campo | Valor |
|---|---|
| Root Directory | `frontend` |
| Framework Preset | Vite |
| Build Command | `npm run build` |
| Output Directory | `dist` |

Variable de entorno: `API` = URL del backend + `/api` (`https://tp-desarrollo-de-software-backend.vercel.app/api`). `vite.config.js` la lee en el build y, si no está, usa `http://localhost:3000/api`.

`frontend/vercel.json` hace que al recargar una ruta como `/mesas` se sirva la app en lugar de un 404.

## 4. Verificación

1. Entrar al frontend con `admin@restoflow.com` / `admin1234`.
2. Probar el circuito: abrir una comanda con el mozo, prepararla con el cocinero y cobrarla.
3. Con el usuario mozo, entrar a una pantalla de administrador (ej: `/usuarios`): la app lo manda de vuelta a su pantalla, y la API responde 403.

## Problemas comunes

| Síntoma | Causa probable |
|---|---|
| El front muestra "Network Error" | `API` mal escrita (falta `/api`), o `CORS_ORIGIN` no coincide exacto con la URL del front (sin `/` al final). Después de cambiar una variable hay que redeployar |
| El backend falla al iniciar o en cada request | Falta `DATABASE_URL` o `JWT_SECRET` en las variables del proyecto |
| Login responde "Credenciales inválidas" con los usuarios de prueba | No se corrió el seed contra la base de la nube |
