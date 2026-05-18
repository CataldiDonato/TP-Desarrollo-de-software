# 🚀 Metodología de Trabajo - RestoFlow

Este documento define cómo vamos a organizarnos, dividir las tareas y escribir el código en equipo para el proyecto de Desarrollo de Software. El objetivo es evitar conflictos de código, trabajar de forma ordenada y asegurar que todos toquemos tanto el Frontend como el Backend.

---

## 🗺️ 1. Roadmap: Etapas del Proyecto

El desarrollo se dividirá en 5 grandes etapas. No avanzaremos a la siguiente hasta que la actual esté mergeada y funcionando en `main`.

# 🏗️ Etapa 1: Setup, Arquitectura Base y Modelado

El objetivo de esta primera etapa es construir los cimientos del proyecto **RestoFlow**. Al finalizar esta etapa, tendremos el repositorio estructurado, la base de datos PostgreSQL conectada mediante Prisma, el DER traducido a código y el Frontend comunicándose con el Backend.

---

## 📁 1. Estructura de Carpetas

Vamos a trabajar en un único repositorio (Monorepo simple). En la raíz del proyecto tendremos dos carpetas principales. Deben borrar los archivos sueltos que tengan ahora y dejar esta estructura:

```text
/TP-Desarrollo-de-software
  ├── /backend     (Node.js, Express, Prisma)
  ├── /frontend    (React, Vite, Tailwind)
  ├── README.md
  ├── proposal.md
  └── WORKFLOW.md
```

---

## 🛠️ 2. Guía Técnica Paso a Paso

### A. Setup del Backend
Dentro de la carpeta `/backend`:
1. Inicializar el proyecto: `npm init -y`
2. Instalar dependencias principales: 
   `npm install express cors dotenv pg`
3. Instalar dependencias de desarrollo: 
   `npm install --save-dev nodemon prisma`
4. Inicializar Prisma: 
   `npx prisma init`
5. Configurar el archivo `.env` con la URL de su base de datos PostgreSQL.

### B. Traducción del DER (Prisma Schema)
En el archivo `backend/prisma/schema.prisma` hay que escribir todas las tablas del DER que definimos en la propuesta (Usuario, Mesa, Comanda, Plato, etc.). 
*Una vez listo el schema, se corre la migración para crear las tablas en la base de datos:*
`npx prisma migrate dev --name init`

### C. Setup del Frontend
Desde la raíz del repositorio, crear el proyecto React usando Vite:
1. `npm create vite@latest frontend -- --template react`
2. Entrar a la carpeta: `cd frontend`
3. Instalar dependencias: `npm install`
4. Instalar enrutador y cliente HTTP: `npm install react-router-dom axios`
5. Instalar y configurar Tailwind CSS (seguir la doc oficial de Vite + Tailwind).

---

## 📋 3. Lista de Tareas para el Tablero Kanban (To-Do List)

Abran su tablero en **GitHub Projects** y creen estas tarjetas (Issues). Cada integrante debe asignarse al menos una.

- [ ] **Tarea 1: Estructura base y Setup Frontend (React + Vite)**
  - *Descripción:* Crear la carpeta `/frontend`, inicializar React con Vite, instalar TailwindCSS, Axios y React Router. Limpiar el código por defecto de Vite (logos y contadores) y dejar una pantalla en blanco que diga "Bienvenido a RestoFlow".

- [ ] **Tarea 2: Setup Backend (Node + Express)**
  - *Descripción:* Crear la carpeta `/backend`, inicializar `package.json`, instalar Express, CORS y Dotenv. Crear el archivo `index.js` con un servidor básico corriendo en el puerto 3000 y configurar un script en el `package.json` para usar Nodemon (`"dev": "nodemon index.js"`).

- [ ] **Tarea 3: Configuración de Base de Datos y Prisma**
  - *Descripción:* Instalar Prisma CLI. Crear una base de datos PostgreSQL (local o en la nube como Supabase/Neon). Configurar el `.env` del backend y hacer que `npx prisma init` funcione correctamente. Compartir el archivo `.env.example` con los compañeros.

- [ ] **Tarea 4: Modelado de Datos (Traducir DER a Prisma)**
  - *Descripción:* Agarrar el archivo `schema.prisma` y escribir los modelos (`model Usuario`, `model Mesa`, `model Categoria`, `model Plato`, etc.) respetando las relaciones 1:N que hay en el diagrama. Correr la primera migración `npx prisma migrate dev`. *(Nota: Depende de la Tarea 3)*.

- [ ] **Tarea 5: Prueba de Conexión (El "Ping-Pong")**
  - *Descripción:* Crear un endpoint de prueba en el Backend (`GET /api/ping` que devuelva `{"mensaje": "pong"}`). En el Frontend, usar un `useEffect` con `axios` para hacer una petición a esa ruta y mostrar la palabra "pong" en la pantalla de React. Esto confirma que Front y Back se comunican y no hay problemas de CORS. *(Nota: Depende de Tarea 1 y 2)*.

---

## 🎯 4. Criterios de Aceptación (Definition of Done)
*¿Cómo sabemos que la Etapa 1 está terminada?*
* [ ] Hay dos carpetas claras: `/frontend` y `/backend`.
* [ ] Si un integrante hace `git clone`, `npm install` en ambas carpetas y configura su `.env`, el proyecto levanta sin errores.
* [ ] La base de datos tiene las tablas creadas de acuerdo al DER.
* [ ] React se comunica con Express correctamente.

# 🚀 Etapa 2: CRUDs Simples y Seguridad Básica

El objetivo de esta etapa es darle vida al sistema desarrollando los ABMs (Alta, Baja, Modificación y Listado) de las entidades independientes que no dependen de otras para existir. Además, implementaremos el sistema de login básico para proteger nuestras rutas. 

Al finalizar esta etapa, un Administrador podrá ingresar al sistema y configurar las mesas, categorías, medios de pago y cargar a los empleados (mozos y cocineros).

---

## 🏗️ 1. Arquitectura Backend a Utilizar (Patrón de Capas)

Para mantener el código ordenado, el backend debe seguir esta estructura lógica para cada entidad (Vertical Slicing):

*   **Rutas (`/routes`):** Reciben la petición web (Ej: `GET /api/mesas`) y la derivan al controlador.
*   **Controladores (`/controllers`):** Extraen los datos del request (ej. el `body` o los `params`), llaman al servicio y devuelven la respuesta HTTP (Ej: `res.status(200).json(...)`).
*   **Servicios (`/services`):** Aquí va la "Lógica de Negocio" y las consultas a la base de datos usando Prisma (Ej: `prisma.mesa.findMany()`).

---

## 🛠️ 2. Guía Técnica y Recomendaciones

### Para el Backend:
1. Instalar dependencias para seguridad: `npm install bcrypt jsonwebtoken` (para encriptar contraseñas y generar tokens de sesión).
2. Probar todos los endpoints (GET, POST, PUT, DELETE) usando herramientas como Postman o Thunder Client antes de conectarlos al frontend.

### Para el Frontend:
1. Crear una carpeta `/src/services` en React donde usarán Axios para pegarle al backend.
2. Crear componentes reutilizables con Tailwind CSS (Ej: un componente `<Tabla />`, un componente `<Boton />`).
3. Instalar dependencias para formularios (opcional pero recomendado): `npm install react-hook-form`.

---

## 📋 3. Lista de Tareas para el Tablero Kanban (To-Do List)

Recuerden la regla de oro: **Trabajo "Vertical"**. El integrante que toma la tarea, hace tanto el Backend (rutas/controladores) como el Frontend (formulario/tabla en React) de esa entidad.

- [ ] **Tarea 1: Autenticación (Login) y CRUD de Usuarios**
  - *Backend:* Endpoint de Login que verifique el email, valide la contraseña con `bcrypt` y devuelva un JWT. Endpoints CRUD para crear, listar, editar y eliminar usuarios. Validar el campo "rol" (Administrador, Mozo, Cocinero).
  - *Frontend:* Pantalla de Login inicial. Pantalla protegida de "Gestión de Empleados" (Listado y formulario para crear/editar usuarios).

- [ ] **Tarea 2: CRUD de Mesas**
  - *Backend:* Endpoints (GET, POST, PUT, DELETE) para la entidad Mesa. Los campos principales serán `id`, `capacidad` y `estado` (libre/ocupada - por defecto libre).
  - *Frontend:* Pantalla de "Gestión de Mesas" con una tabla que liste todas las mesas y un formulario para dar de alta nuevas o modificar su capacidad.

- [ ] **Tarea 3: CRUD de Categoría de Plato**
  - *Backend:* Endpoints (GET, POST, PUT, DELETE) para la entidad Categoría (ej: "Entradas", "Platos Principales", "Bebidas", "Postres").
  - *Frontend:* Pantalla de "Categorías de Menú" con su respectiva tabla y formulario de carga.

- [ ] **Tarea 4: CRUD de Método de Pago**
  - *Backend:* Endpoints (GET, POST, PUT, DELETE) para la entidad MedioDePago. El campo principal será `tipo` (Ej: Efectivo, Tarjeta de Crédito, MercadoPago).
  - *Frontend:* Pantalla simple para listar, agregar, editar o eliminar los métodos de pago aceptados en el local.

- [ ] **Tarea 5: CRUD de Precio Plato**
  - *Backend:* Endpoints (GET, POST, PUT, DELETE) para gestionar los precios históricos y actuales. Campos principales: `fechaDesde`, `monto`. *(Nota: Aunque luego se asocie al Plato, por ahora se debe poder listar y crear el registro de precio base).*
  - *Frontend:* Interfaz administrativa para cargar los valores monetarios que luego se asignarán al menú.

---

## 🎯 4. Criterios de Aceptación (Definition of Done)
*¿Cómo sabemos que la Etapa 2 está terminada?*
* [ ] Las contraseñas de los usuarios se guardan encriptadas en la base de datos PostgreSQL.
* [ ] El endpoint de login funciona y devuelve un Token JWT válido.
* [ ] Todas las entidades simples (Mesas, Categorías, Medios de Pago) se pueden Crear, Leer, Actualizar y Eliminar desde la interfaz de React.
* [ ] Las tablas en React se actualizan correctamente cuando se agrega o elimina un registro.
* [ ] Todo el código de esta etapa fue revisado mediante Pull Requests y ya está mergeado en la rama `main` sin generar conflictos.

# **Etapa 3: CRUDs Dependientes y Relaciones.** 

El objetivo de esta etapa es subir la complejidad del sistema conectando las entidades. Ahora las tablas se relacionan entre sí a través de las Claves Foráneas (Foreign Keys) que definimos en Prisma. 

Al finalizar esta etapa, tendremos el catálogo completo de platos (asociados a sus categorías y precios), el sistema de reservas funcionando y la estructura base preparada para abrir una comanda.

---

## 🏗️ 1. Lógica Backend: El uso de `include` en Prisma

Cuando trabajamos con entidades dependientes, al buscar un registro casi siempre queremos ver los datos del registro padre. En sus servicios del backend (`/services`), empezarán a usar la propiedad `include` de Prisma.

*Ejemplo de cómo listar platos trayendo el nombre de la categoría:*
```javascript
const platos = await prisma.plato.findMany({
  include: {
    categoria: true,
    precio: true
  }
});
```

---

## 🛠️ 2. Guía Técnica y Recomendaciones para el Frontend

En esta etapa, los formularios de React cambian. Ya no son solo campos de texto (`<input type="text">`), sino que necesitarán usar menús desplegables (`<select>`).

*   **Paso 1:** Al cargar la pantalla de "Crear Plato", primero deben hacer un `GET` a `/api/categorias` para obtener la lista de categorías.
*   **Paso 2:** Guardar esas categorías en un estado (`useState`).
*   **Paso 3:** Dibujar un `<select>` que recorra ese estado con un `.map()` e imprima una etiqueta `<option>` por cada categoría. De esta forma, el usuario selecciona el ID correcto sin darse cuenta.

---

## 📋 3. Lista de Tareas para el Tablero Kanban (To-Do List)

Recuerden: **Trabajo Vertical**. Quien toma la tarea hace Backend + Frontend y no la da por terminada hasta que su PR esté aprobado en `main`.

- [ ] **Tarea 1: CRUD de Platos**
  - *Backend:* Endpoints para la entidad Plato. Al crear (`POST`), se debe recibir y validar el `categoriaId` y asociarle un `precio`. Al listar (`GET`), se debe incluir la información de la categoría.
  - *Frontend:* Pantalla "Catálogo de Platos". Formulario de creación que incluya un `<select>` para elegir la Categoría y otro para definir o vincular el Precio actual.

- [ ] **Tarea 2: CRUD de Estados Auxiliares**
  - *Descripción:* En el DER tenemos `estadoReserva` y `estado-comandaDetalle`. 
  - *Backend:* En vez de hacer un CRUD completo para el Frontend, pueden crear un *Seeder* (script de semilla) o endpoints simples para cargar estos estados fijos en la BD (Ej: Reservas: "Confirmada", "Cancelada". Comandas: "Pendiente", "En Preparación", "Listo").
  - *Frontend:* Pantallas simples o configuración inicial para listarlos si lo consideran necesario.

- [ ] **Tarea 3: CRUD de Reservas de Mesas**
  - *Backend:* Endpoints para crear y gestionar reservas. Recibe fecha, hora, nombre/teléfono del cliente, `mesaId` y `estadoReservaId`. Validar que no se superpongan reservas de una misma mesa en el mismo horario.
  - *Frontend:* Pantalla de "Gestión de Reservas". Formulario con selectores de fecha/hora y un `<select>` que muestre solo las Mesas disponibles.

- [ ] **Tarea 4: Apertura Inicial de Comanda (La Cabecera)**
  - *Backend:* Endpoint para inicializar una Comanda. Recibe el `mesaId` y el `usuarioId` (el Mozo que la abre). Registra la fecha/hora actual y la marca con estado "Abierta". Todavía no le cargamos platos, es solo crear el registro.
  - *Frontend:* En la pantalla de un Mozo, debe haber un botón "Abrir Mesa" al seleccionar una mesa libre, que dispare este endpoint y cambie el estado visual de la mesa (Ej: de Verde a Rojo).

---

## 🎯 4. Criterios de Aceptación (Definition of Done)
*¿Cómo sabemos que la Etapa 3 está terminada?*
* [ ] No se puede crear un Plato si no se le asigna una Categoría que exista en la BD.
* [ ] Las restricciones de Clave Foránea funcionan (Ej: No se puede borrar una Categoría si ya tiene Platos adentro).
* [ ] Los formularios en React cargan dinámicamente las listas desplegables (Categorías, Mesas) consultando al Backend.
* [ ] Se pueden registrar reservas de clientes para mesas específicas en días y horarios determinados.
* [ ] El Mozo puede "Abrir" una mesa, generando un registro de Comanda en la BD asignado a su Usuario y a esa Mesa.

# 🍳 Etapa 4: Épicas Core - El Ciclo de Salón y Cocina

El objetivo de esta etapa es programar el "corazón" del negocio gastronómico. Vamos a implementar la lógica operativa en tiempo real (o casi real) donde interactúan los Mozos y los Cocineros. 

Al finalizar esta etapa, un Mozo podrá visualizar el salón, tomarle un pedido a una mesa, y automáticamente ese pedido aparecerá en la pantalla táctil o monitor de la cocina (KDS - *Kitchen Display System*) para que el Cocinero lo prepare.

---

## 🏗️ 1. Lógica y Arquitectura de Roles

En esta etapa, el sistema empieza a comportarse distinto dependiendo de quién inició sesión. El **Mozo** y el **Cocinero** tendrán pantallas de inicio completamente diferentes.

*   **Para el Backend:** Deberán crear *Middlewares* que verifiquen el Rol del usuario a partir del Token JWT. Por ejemplo, un middleware `verificarCocinero` para proteger las rutas donde se cambia el estado de un plato.
*   **Para el Frontend:** Usarán *React Router* para redirigir al usuario según su rol después del Login. Si es Mozo, va a `/salon`; si es Cocinero, va a `/cocina`.

---

## 🛠️ 2. Guía Técnica y Recomendaciones

*   **Comanda Detalle:** En Prisma, cuando el Mozo carga platos, van a interactuar con la tabla intermedia `comandaDetalle` (que une Comanda, Plato y el Estado del plato).
*   **Actualización de datos (Polling vs WebSockets):** Para que la pantalla de la cocina se actualice cuando entra un pedido nuevo, tienen dos opciones:
    1.  *Opción Fácil (Polling):* Usar un `setInterval` en React que haga un `GET /api/cocina/pendientes` cada 10 segundos.
    2.  *Opción Pro (Opcional):* Implementar Socket.io para que el aviso sea instantáneo. (Recomiendo arrancar con la opción fácil para asegurar el TP).

---

## 📋 3. Lista de Tareas para el Tablero Kanban (To-Do List)

Recuerden: **Trabajo Vertical** y uso de Pull Requests. Esta etapa es la más compleja, la comunicación del equipo es vital.

- [ ] **Tarea 1: Mapa del Salón (Vista Mozo)**
  - *Backend:* Endpoint que devuelva todas las mesas con su estado actual y, si está ocupada, el ID de la Comanda activa.
  - *Frontend:* Pantalla visual (grilla de tarjetas) con las mesas. Las Libres en verde, las Ocupadas en rojo. Al hacer clic en una mesa ocupada, debe llevar al detalle de su comanda.

- [ ] **Tarea 2: Carga de Pedidos (Comanda Detalle)**
  - *Backend:* Endpoint `POST /api/comandas/:id/platos`. Recibe un arreglo de platos y cantidades, y los inserta en la tabla `comandaDetalle` con el estado inicial "Pendiente".
  - *Frontend:* Dentro de una mesa abierta, crear una interfaz donde el Mozo vea el menú, seleccione platos, indique la cantidad y presione "Enviar a Cocina".

- [ ] **Tarea 3: Pantalla KDS - Kitchen Display System (Vista Cocinero)**
  - *Backend:* Endpoint `GET /api/cocina/pedidos` que traiga todos los registros de `comandaDetalle` cuyo estado sea "Pendiente" o "En Preparación".
  - *Frontend:* Pantalla exclusiva para el rol Cocinero. Un tablero estilo Kanban con dos columnas: "Nuevos Pedidos (Pendientes)" y "En Preparación". Las tarjetas deben mostrar el Nombre del Plato, Cantidad y Número de Mesa.

- [ ] **Tarea 4: Flujo de Estados y Vinculación del Cocinero**
  - *Backend:* Endpoint `PUT /api/comanda-detalle/:id/estado`. Permite cambiar el estado de un plato pedido (Ej: de "Pendiente" a "En Preparación", y luego a "Listo"). Al pasarlo a "Listo", el endpoint debe registrar qué `usuarioId` (el Cocinero) fue el que lo preparó, cumpliendo la relación del DER.
  - *Frontend:* Botones en las tarjetas del KDS (Cocina) para avanzar el estado del plato. En la vista del Mozo, los platos de su mesa que estén marcados como "Listos" deben cambiar de color para que sepa que los tiene que ir a buscar a la cocina.

---

## 🎯 4. Criterios de Aceptación (Definition of Done)
*¿Cómo sabemos que la Etapa 4 está terminada?*
* [ ] El sistema distingue entre roles: un Cocinero no puede ver el salón, y un Mozo no ve la pantalla KDS de la cocina.
* [ ] Un Mozo puede abrir una mesa y cargarle 3 hamburguesas y 2 gaseosas.
* [ ] Al enviar el pedido, las 3 hamburguesas aparecen en la pantalla del Cocinero con estado "Pendiente".
* [ ] El Cocinero puede aceptar el pedido, prepararlo y marcarlo como "Listo", quedando su ID de usuario registrado en la base de datos como el autor de ese plato.
* [ ] El Mozo puede ver en su pantalla de la mesa que las hamburguesas ya están "Listas" para servir.

# 🏁 Etapa 5: Cierre de Mesa y Pulido para Aprobación Directa

El objetivo de esta última etapa es cerrar el ciclo económico del restaurante (facturación y cobro), desarrollar los reportes gerenciales (listados complejos) y cumplir con los requisitos adicionales de la cátedra (Testing automatizado y Mobile-first) para asegurar la **Aprobación Directa** (promoción).

Al finalizar, el Mozo podrá cobrarle al cliente, liberar la mesa, y el Administrador podrá ver un reporte de cuánto dinero ingresó en el día. ¡El sistema estará listo para la entrega final!

---

## 🏗️ 1. Lógica Backend: Transacciones (Transactions) en Prisma

Al cerrar una mesa, ocurren varias cosas en la base de datos al mismo tiempo: la comanda se cierra, se asigna el total, se guarda el medio de pago y la mesa vuelve a estar "Libre". 
Si una de estas cosas falla, no debería guardarse ninguna. Para esto usarán las **Transacciones** de Prisma (`prisma.$transaction`).

*Ejemplo de lógica para el cierre:*
```javascript
const cierreMesa = await prisma.$transaction([
  // 1. Actualizar la comanda (poner total, estado 'Cerrada' y medioDePago)
  prisma.comanda.update({ ... }),
  // 2. Liberar la mesa
  prisma.mesa.update({ where: { id: mesaId }, data: { estado: 'Libre' } })
]);
```

---

## 🛠️ 2. Guía Técnica y Recomendaciones

*   **Testing:** La cátedra exige pruebas automatizadas para la aprobación directa. Les recomiendo usar **Jest + Supertest** en el Backend para testear las rutas principales (ej. testear que el login falla con credenciales incorrectas, o que la ruta de traer mesas devuelve un array).
*   **Mobile-first:** Abran las herramientas de desarrollador en el navegador (F12) y pongan la vista de celular. Verifiquen que Tailwind esté haciendo su trabajo. Los mozos usarán la app caminando por el salón, la vista en celulares debe ser perfecta.

---

## 📋 3. Lista de Tareas para el Tablero Kanban (To-Do List)

- [ ] **Tarea 1: Cierre de Mesa y Cálculo de Total**
  - *Backend:* Endpoint `POST /api/comandas/:id/cerrar`. Debe sumar el subtotal de todos los platos consumidos (vinculando la tabla `precio`), recibir el `medioDePagoId`, marcar la comanda como finalizada y cambiar el estado de la Mesa a Libre.
  - *Frontend:* En el detalle de la mesa, el Mozo presiona "Pedir Cuenta". Se muestra un resumen con los platos, el total a pagar y un `<select>` para elegir si el cliente paga en Efectivo, Tarjeta, etc. Al confirmar, la mesa vuelve a aparecer en verde en el salón.

- [ ] **Tarea 2: Listado de Ventas (Reporte Gerencial)**
  - *Backend:* Endpoint `GET /api/reportes/ventas`. Debe permitir recibir parámetros por query (`?fechaDesde=...&fechaHasta=...&medioDePago=...`) y devolver las comandas cerradas que coincidan, incluyendo el detalle de platos.
  - *Frontend:* Pantalla exclusiva para el Administrador. Un panel de reportes con filtros de fecha y método de pago, y una tabla/grilla que muestre los ingresos del restaurante.

- [ ] **Tarea 3: Implementación de Tests Automatizados (Backend)**
  - *Descripción:* Configurar Jest en la carpeta `/backend`.
  - *Acción:* Escribir al menos 3 o 4 tests de integración. (Ejemplo: `test('GET /api/mesas debe devolver status 200')`). Añadir el script `"test": "jest"` al `package.json`.

- [ ] **Tarea 4: Revisión Mobile-First y Pulido Visual (UI/UX)**
  - *Descripción:* Tarea de Frontend pura. 
  - *Acción:* Navegar por toda la aplicación (Login, Salón, KDS de Cocina, Reportes) simulando pantallas de celulares y tablets. Ajustar clases de Tailwind (`flex-col`, `md:flex-row`, `p-2`, `md:p-4`, menús hamburguesa si es necesario) para que nada se rompa en pantallas chicas.

- [ ] **Tarea 5: Limpieza de Código y Preparación de Entrega**
  - *Descripción:* Revisar que no hayan quedado `console.log()` sueltos, contraseñas hardcodeadas o dependencias sin usar. 
  - *Acción:* Grabar el video demostrativo que suele pedir la cátedra mostrando todo el flujo de trabajo, y verificar que el archivo `README.md` del proyecto explique claramente cómo instalar y levantar el sistema.

---

## 🎯 4. Criterios de Aceptación (Definition of Done)
*¿Cómo sabemos que la Etapa 5 (y el proyecto) está terminada?*
* [ ] Se puede cerrar una mesa: se calcula el total exacto según los platos pedidos, se cobra y la mesa queda libre para el próximo cliente.
* [ ] El administrador puede filtrar cuánto se facturó en "Efectivo" durante el día de hoy.
* [ ] Si ejecutamos `npm test` en el backend, las pruebas pasan en verde.
* [ ] La aplicación se ve y se puede usar perfectamente desde un teléfono celular.
* [ ] **¡El equipo está listo para presentar el TP y conseguir la promoción!** 🎉
---

## 📋 2. Gestión de Tareas (Tablero Kanban)

Utilizaremos la herramienta **GitHub Projects** integrada en este repositorio. Nuestro tablero tendrá 4 columnas:

1.  **To Do (Por hacer):** Tareas pendientes, aprobadas y listas para ser tomadas.
2.  **In Progress (En curso):** Tareas que alguien está programando en este momento.
3.  **Code Review (En revisión):** Código terminado esperando que otro compañero lo revise a través de un Pull Request (PR).
4.  **Done (Listo):** Código mergeado en la rama `main` y funcionando.

**Regla de Asignación (Vertical Slicing):**
Trabajaremos de forma "vertical". Quien toma una tarea (ej. *CRUD de Mesas*), se encarga de hacer el modelo en Prisma, la ruta en el Backend y la pantalla en React (Frontend). Así todos aprendemos de todo el stack. **Nadie empieza una tarea sin asignarse la tarjeta en el tablero.**

---

## 🌿 3. Flujo de Trabajo en Git (GitHub Flow)

Para evitar sobreescribir el trabajo de los demás, usaremos ramas (branches) y Pull Requests.

### 🚫 REGLA DE ORO: Nunca hacer *push* directo a `main`.
La rama `main` debe ser estable y funcional en todo momento.

### Pasos para desarrollar una nueva funcionalidad:

1.  **Sincronizar:** Antes de empezar, asegúrate de tener lo último de `main`.
    ```bash
    git checkout main
    git pull origin main
    ```
2.  **Crear una rama nueva:**
    ```bash
    git checkout -b feature/nombre-de-tu-tarea
    ```
3.  **Trabajar y hacer commits:** Haz commits pequeños y descriptivos.
    ```bash
    git add .
    git commit -m "Agrega controlador y rutas para creación de mesas"
    ```
4.  **Subir la rama al repositorio:**
    ```bash
    git push origin feature/nombre-de-tu-tarea
    ```
5.  **Abrir un Pull Request (PR):**
    Ve a GitHub y abre un PR desde tu rama hacia `main`.
6.  **Code Review:**
    Avisa por WhatsApp al equipo. Al menos **UN integrante** debe revisar el código en GitHub. Si todo está bien, aprueba el PR y le da a **Merge**.
7.  **Actualizar localmente:** Una vez mergeado, el que hizo el PR debe volver a su terminal, cambiar a `main` y hacer `git pull` para actualizar su compu.

---

## 📝 4. Nomenclatura y Convenciones

Para mantener el orden, nombraremos las ramas y los commits con prefijos estandarizados:

### Nombres de Ramas:
*   `feature/` para nuevas funcionalidades (ej: `feature/crud-usuarios`)
*   `fix/` para arreglar errores (ej: `fix/error-login`)
*   `docs/` para documentación (ej: `docs/actualizar-readme`)

### Mensajes de Commit:
Deben ser claros e indicar qué se hizo. Ejemplos:
*   ✅ `feat: Crea formulario de login en React`
*   ✅ `fix: Corrige validación de contraseñas en backend`
*   ❌ `cambios varios` o `asd`

---

## ⚙️ 5. Reglas y Buenas Prácticas del Equipo

1.  **Sincronización Asíncrona (Daily por WhatsApp):** Cada 2 días mandaremos un mensaje breve al grupo: *1) Qué hice, 2) Qué voy a hacer, 3) Si estoy bloqueado con algo.*
2.  **Variables de Entorno (`.env`):** NUNCA subir archivos `.env` o credenciales de la base de datos a GitHub. Asegurarse de que el archivo `.env` esté en el `.gitignore`. Crearemos un archivo `.env.example` con variables de ejemplo para que cada uno sepa qué configurar en su PC.
3.  **Dependencias (`node_modules`):** Cada vez que hagan `git pull origin main` y vean que alguien instaló algo nuevo, recuerden correr `npm install` en sus computadoras.
4.  **Ayuda mutua:** Si alguien lleva más de un día trabado en el mismo error, se pide ayuda al equipo por Discord o Meet.