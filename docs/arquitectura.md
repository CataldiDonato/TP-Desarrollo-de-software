# Arquitectura y modelo de datos

## Vista general

Frontend y backend son dos aplicaciones independientes que se comunican solo por la API REST (JSON + token JWT).

```mermaid
flowchart LR
    subgraph Cliente["Navegador (celular, tablet o PC)"]
        FE["Frontend<br/>React 19 + Vite + Tailwind"]
    end
    subgraph Servidor["Backend"]
        API["API REST<br/>Express 5 + TypeScript"]
        ORM["Prisma 7 (ORM)"]
    end
    DB[("PostgreSQL")]

    FE -- "HTTP + JSON<br/>Authorization: Bearer token" --> API
    API --> ORM --> DB
```

## Backend en capas

Cada módulo (mesas, reservas, comandas, cocina, etc.) tiene las mismas cuatro capas. Ninguna capa se saltea a la de abajo.

```mermaid
flowchart TB
    R["routes/<br/>URL, método HTTP y roles permitidos (verificarRol)"]
    C["controllers/<br/>lee params, query y body; arma la respuesta HTTP"]
    S["services/<br/>validaciones y reglas de negocio; lanza AppError"]
    Rep["repositories/<br/>única capa que usa Prisma"]
    P[("Prisma → PostgreSQL")]
    MW["middlewares/<br/>verificarToken (JWT)"]

    MW --> R --> C --> S --> Rep --> P
```

- **Errores:** los servicios lanzan `AppError(mensaje, código)`; los controladores lo convierten en `{ "message": "..." }` con el código HTTP. Un JSON mal formado devuelve 400 y una ruta inexistente 404.
- **Transacciones:** abrir una comanda (comanda + productos + mesa Ocupada) y cerrarla (estado + medio de pago + mesa Libre) se hacen con `prisma.$transaction`: o se guarda todo o nada.
- **Concurrencia en cocina:** el cambio de estado de un plato usa `updateMany` condicionado al estado actual; si dos cocineros lo tocan a la vez, el segundo recibe 409.

## Frontend

```mermaid
flowchart TB
    App["App.jsx<br/>BrowserRouter + AuthProvider + Toaster"]
    Auth["context/AuthContext<br/>usuario y token (localStorage)"]
    Router["routes/AppRouter<br/>RutaProtegida por rol"]
    Pages["pages/<br/>una carpeta por pantalla: página + modales"]
    Comp["components/<br/>Modal, Navbar"]
    Serv["services/<br/>una función por endpoint (axios)"]
    Models["models/<br/>clases: Mesa, Comanda, PedidoCocina…"]
    API[["API REST"]]

    App --> Auth
    App --> Router --> Pages
    Pages --> Comp
    Pages --> Serv --> API
    Serv -- "conModelo(Clase)" --> Models
    Pages -- "toApi()" --> Models
```

- **Servicios:** `services/api.js` agrega el token a cada pedido y, si el backend responde 401, cierra la sesión.
- **Modelos:** cada respuesta se convierte en una instancia de su clase (`Mesa.desdeApi(json)`, patrón Factory Method) y los formularios arman el body con `toApi()`.
- **Estilos:** Tailwind CSS v4, mobile-first (breakpoints `sm` 640px, `md` 768px, `lg` 1024px).

## Modelo de datos implementado

```mermaid
erDiagram
    usuario ||--o{ comanda : "abre (mozo)"
    usuario |o--o{ detalle_comanda : "prepara (cocinero)"
    mesa ||--o{ comanda : tiene
    mesa ||--o{ reserva : tiene
    medio_de_pago |o--o{ comanda : "se cobra con"
    comanda ||--|{ detalle_comanda : contiene
    producto ||--o{ detalle_comanda : "se pide en"
    categoria ||--o{ producto : agrupa
    producto ||--|{ precio_producto : "historial de precios"

    usuario {
        int id PK
        string nombre
        string email UK
        string contrasenia "hash scrypt"
        enum rol "Administrador | Mozo | Cocinero"
    }
    mesa {
        int id PK
        int capacidad
        enum estado "Libre | Ocupada | Reservada"
    }
    reserva {
        int id PK
        datetime fecha
        string nombre_cliente
        string telefono_cliente
        int cantidad_personas
        enum estado "Confirmada | Cancelada"
        string motivo_cancelacion
        int id_mesa FK
    }
    comanda {
        int id PK
        datetime fecha
        enum estado "Abierta | Pagada | Cancelada"
        int id_mesa FK
        int id_mozo FK
        int id_medio_pago FK
    }
    detalle_comanda {
        int id_comanda PK, FK
        int id_producto PK, FK
        int cantidad
        enum estado "Pendiente | En_Preparacion | Finalizada"
        string observaciones
        int id_cocinero FK
    }
    producto {
        int id PK
        string nombre
        string descripcion
        enum tipo "Plato | Bebida"
        int id_categoria FK
    }
    categoria {
        int id PK
        string nombre
    }
    precio_producto {
        int id_producto PK, FK
        datetime fecha_desde PK
        decimal precio
    }
    medio_de_pago {
        int id PK
        enum tipo "Efectivo | Transferencia | Tarjeta"
    }
```

**Diferencias con el DER conceptual de la propuesta** ([der.webp](der.webp)):

- `estadoReserva` y `estado-comandaDetalle` pasaron a ser **enums** de PostgreSQL: son valores fijos que no administra el usuario.
- `plato` pasó a llamarse `producto` y tiene un `tipo` (Plato o Bebida), para poder cargar también bebidas.
- Los roles (mozo, administrador, cocinero) son un enum `rol` dentro de `usuario` en lugar de subtipos.
- El total de la comanda y los subtotales no se guardan: se calculan con el **precio vigente** de cada producto a la fecha de la comanda (`precio_producto` guarda el historial).
- Se agregó `observaciones` a `detalle_comanda` para las aclaraciones a la cocina.

## Ciclos de vida

```mermaid
stateDiagram-v2
    direction LR
    state "Comanda" as C {
        [*] --> Abierta: el mozo abre la mesa
        Abierta --> Pagada: cobrar (con medio de pago)
        Abierta --> Cancelada: cancelar
    }
```

```mermaid
stateDiagram-v2
    direction LR
    state "Producto pedido (detalle_comanda)" as D {
        [*] --> Pendiente: el mozo lo carga
        Pendiente --> En_Preparacion: un cocinero lo toma
        En_Preparacion --> Finalizada: el mismo cocinero lo termina
    }
```

```mermaid
stateDiagram-v2
    direction LR
    state "Mesa" as M {
        [*] --> Libre
        Libre --> Ocupada: se abre una comanda
        Reservada --> Ocupada: se abre una comanda
        Ocupada --> Libre: se cobra o se cancela la comanda
        Libre --> Reservada: el admin la marca
        Reservada --> Libre: el admin la libera
    }
```

## Secuencia del circuito principal

```mermaid
sequenceDiagram
    actor Mozo
    actor Cocinero
    participant FE as Frontend
    participant API as Backend
    participant DB as PostgreSQL

    Mozo->>FE: elige mesa, carga productos (con observaciones)
    FE->>API: POST /comandas { id_mesa, detalles[] }
    API->>DB: transacción: crear comanda + detalles (Pendiente) + mesa Ocupada
    API-->>FE: 201 comanda creada

    loop cada 15 segundos
        FE->>API: GET /cocina/pedidos
    end
    Cocinero->>FE: Iniciar preparación
    FE->>API: PATCH /cocina/detalles/estado (En_Preparacion)
    API->>DB: update si sigue Pendiente (si no, 409) + guarda el cocinero del token
    Cocinero->>FE: Marcar como listo
    FE->>API: PATCH /cocina/detalles/estado (Finalizada)

    Mozo->>FE: Cobrar (Efectivo)
    FE->>API: PATCH /comandas/:id/estado { Pagada, id_medio_pago }
    API->>DB: transacción: comanda Pagada + mesa Libre
    API-->>FE: 200 comanda cobrada
```
