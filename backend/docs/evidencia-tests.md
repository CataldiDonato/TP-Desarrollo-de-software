# Evidencia de ejecución de tests — Backend

Fecha de ejecución: 29/10/2026 18:09 · Comando: `npm test` (test runner de Node, `node:test`) · Resultado: **25 tests, 25 pasan**

| Archivo | Tipo | Qué prueba |
|---|---|---|
| `tests/validation.test.ts` | Unitario | Validación de ids, textos, emails, enums y observaciones |
| `tests/password.test.ts` | Unitario | Hash y verificación de contraseñas |
| `tests/precios.test.ts` | Unitario | Precio vigente de un producto |
| `tests/reservas.test.ts` | Unitario | Superposición de horarios de reservas |
| `tests/api.integration.test.ts` | Integración | La API real: health check, 401 sin token, login inválido, 403 por rol, listado de mesas, validaciones y filtro de cocina |

```
✔ GET / responde que el servidor está funcionando (38.731014ms)
✔ una ruta protegida sin token devuelve 401 (2.998938ms)
✔ el login con datos incompletos devuelve 400 (11.662552ms)
✔ el login con credenciales incorrectas devuelve 401 (127.404414ms)
✔ un Cocinero no puede ver los usuarios (403) (3.625068ms)
✔ un Mozo puede listar las mesas y recibe una lista (6.529129ms)
✔ crear una mesa con capacidad inválida devuelve 400 con un mensaje claro (2.677806ms)
✔ la cocina rechaza un filtro de estado que no existe (400) (1.965755ms)
✔ un Mozo no puede ver el detalle de cocina de una comanda (403) (1.908793ms)
✔ el hash no guarda la contraseña en texto plano (46.504515ms)
✔ verifyPassword acepta la contraseña correcta y rechaza una incorrecta (133.601057ms)
✔ dos hashes de la misma contraseña son distintos (salt aleatorio) (63.270073ms)
✔ verifyPassword devuelve false si el hash guardado no tiene el formato esperado (0.235236ms)
✔ usa el último precio cargado antes de la fecha de la comanda (0.882066ms)
✔ si la comanda es anterior al primer precio, usa el primer precio (0.170884ms)
✔ si el producto no tiene precios devuelve null (0.191866ms)
✔ el rango va DURACION_RESERVA_HORAS antes y después de la reserva (0.875439ms)
✔ una reserva 1 hora después cae dentro del rango (se pisan) (0.205101ms)
✔ una reserva 3 horas después queda fuera del rango (no se pisan) (0.133781ms)
✔ parsePositiveId acepta enteros positivos (también como texto) (0.859717ms)
✔ parsePositiveId rechaza 0, negativos, decimales y texto (0.638204ms)
✔ requireText recorta espacios y rechaza textos vacíos (1.15285ms)
✔ parseEmail pasa a minúsculas y valida el formato (0.39603ms)
✔ parseOpcion solo acepta valores de la lista (0.255651ms)
✔ parseTextoOpcional devuelve null si no hay texto y respeta el largo máximo (0.229131ms)
ℹ tests 25
ℹ suites 0
ℹ pass 25
ℹ fail 0
ℹ cancelled 0
ℹ skipped 0
ℹ todo 0
ℹ duration_ms 615.083018
```

> El test de integración levanta la API completa (Express + middlewares + Prisma) contra la base de datos configurada en `DATABASE_URL`.
