# Minuta — Etapa 1: setup y arquitectura base (15/05 al 17/06/2026)

- **Fuente:** reconstruida del historial de git (repos fork, backend y frontend)
- **Presentes:** *(completar)*

## Avances registrados
| Fecha | Integrante | Avance |
|---|---|---|
| 15/05 | Cataldi | Inicialización de npm en el repo del TP |
| 18/05 | Cataldi | Documento de metodología y seguimiento (etapas, Kanban, GitHub Flow) |
| 21/05 | Cataldi | Backend: `init node`, `.env.example` y primera versión |
| 21/05 | Curti | Frontend: proyecto React inicializado |
| 17/06 | Cataldi | Configuración de Prisma y tabla `usuario` (primeras migraciones) |

## Decisiones
- Trabajo **vertical**: quien toma una entidad hace back y front.
- Ramas `feature/`, `fix/` y `docs/`, y Pull Requests hacia `main` ([metodología](../metodologia.md)).
- Nunca subir `.env`: cada uno usa el `.env.example`.

## Próximos pasos
- Etapa 2: CRUDs simples (categorías, mesas, medios de pago, usuarios) y login.
