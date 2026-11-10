# Minuta — Etapa 5: cierre, cobro y tests (06/10/2026)

- **Fuente:** reconstruida del historial de git
- **Medio:** Discord
- **Presentes:** Cataldi · Vada · Curti · Acosta

## Avances registrados
| Integrante | Avance |
|---|---|
| Acosta | Corrección: las contraseñas de los datos iniciales (seed) se guardan hasheadas |
| Vada | Ajustes finales de back y front |
| Cataldi | Cobro y cierre de mesa con transacción, permisos por rol en todas las rutas, formato único de errores, CRUD de categorías y medios de pago en la UI, tests (back: unitarios + integración; front: componente + e2e), README y documentación de la API |

## Decisiones
- Tests con `node:test` en el backend (sin dependencias extra) y Vitest + Playwright en el frontend.
- El id del mozo y del cocinero se toman del token, no del body.
- Reservas: margen de 2 horas para considerar que dos reservas de la misma mesa se pisan.

## Bloqueos o problemas
- La carga de tests, documentación y cierre de mesa se concentró al final de la etapa; queda como aprendizaje repartir antes los tests entre los integrantes.

## Próximos pasos
- Presentación de regularidad y preparación de la entrega de Aprobación Directa.
