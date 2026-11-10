# Minuta — Preparación de la entrega de Aprobación Directa (22/10/2026)

- **Fuente:** revisión de los requisitos de [utnfrrodsw/tp](https://github.com/utnfrrodsw/tp) contra el proyecto
- **Medio:** Discord
- **Presentes:** Cataldi · Vada · Curti · Acosta

## Qué se hizo
- Se unificaron back y front en el fork (`backend/` y `frontend/`) con todo su historial.
- Estilos migrados a **Tailwind CSS** (lo comprometido en la propuesta), mobile-first.
- **Clases de modelo** en el frontend para respuestas y requests (patrón Factory Method).
- Pantalla de cocina como figura en la propuesta: **filtro por estado, observaciones y detalle** de la comanda.
- Backend en TypeScript `strict`, CORS configurable y scripts para deploy.
- Tests nuevos (back 25, front 18 unitarios + 4 e2e) y evidencia actualizada.
- Documentación en `docs/`: arquitectura en Mermaid, proposal actualizada, minutas, tracking y guía de deploy.

## Bloqueos o problemas
- Revisando los requisitos aparecieron dos puntos que no cumplían del todo: el CSS era propio (sin framework) y el frontend no tenía clases de modelo. Se resolvieron migrando a Tailwind y creando las clases con Factory Method.

## Pendientes antes del 30/10
| Tarea | Responsable |
|---|---|
| Deploy (base, backend y frontend) y credenciales en el README | Cataldi — hecho el 29/10 en Vercel |
| Video demo y link en el README | Cataldi |
| Cargar los issues en GitHub Projects (`scripts/cargar-issues.sh`) | Cataldi — hecho el 22/10 |
| PR a `utnfrrodsw/tp` y formulario de entrega | Cataldi |
| Completar los presentes y decisiones de estas minutas | Todos — hecho |
