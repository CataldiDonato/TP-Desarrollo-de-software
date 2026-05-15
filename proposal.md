# Propuesta TP DSW

## Grupo
### Integrantes

* 54310 - Cataldi, Donato
* 54152 - Vada, Gaspar Ignacio
* 55264 - Curti, Tomas Andres
* 55220 - Acosta, Ismael Fabricio

### Repositorios
* https://github.com/CataldiDonato/TP-dsw

## Tema
### Descripción
RestoFlow es una plataforma full-stack para la gestión interna de establecimientos gastronómicos que digitaliza el ciclo completo del salón, conectando en tiempo real a mozos, cocina y caja para optimizar el servicio y el control de ventas.

### DER

DER.webp

https://drive.google.com/file/d/1pjR-0EBUXGuOsIK2jgLkAOpsdjNiHiWR/view?usp=drive_link

## Alcance Funcional 

### Alcance minimo

| Req | Detalle |
| :--- | :--- |
| **CRUD simple** | 1. CRUD Categoria de Plato<br>2. CRUD Mesa<br>3. CRUD Método de Pago<br>4. CRUD Usuario (Mozos, Administradores, Cocineros)<br> 5. CRUD Precio plato |
| **CRUD dependiente** | 1. CRUD Plato {depende de} Categoría<br>2. CRUD Reserva {depende de} Mesa<br>3. CRUD Comanda {depende de} Mesa y Usuario (Mozo) |
| **Listado<br>+<br>detalle** | 1. Pantalla de Cocina (KDS) filtrada por estado (pendiente/en preparación) => detalle del pedido con observaciones.<br>2. Listado de mesas filtrado por disponibilidad => detalle del estado y comanda activa.|
| **CUU/Epic** | 1. Apertura de mesa y carga de pedido inicial por el mozo.<br>2. Gestión de reserva de mesa y asignación de disponibilidad.|

Adicionales para Aprobación

|Req|Detalle|
|:-|:-|
|CRUD | 1. CRUD Categoria de Plato<br>2. CRUD Mesa<br>3. CRUD Método de Pago<br>4. CRUD Usuario (Mozos, Administradores, Cocineros) 5. CRUD  <br>|
|CUU/Epic|1. Apertura de mesa y carga de pedido inicial por el mozo.<br>2. Gestión de reserva de mesa y asignación de disponibilidad.<br>3. Ciclo completo de cocina: recepción de comanda, preparación y actualización de estado de platos.<br>4. Cierre de mesa, pago de cuenta y liberación de mesa.|

### Alcance Adicional Voluntario

|Req|Detalle|
|:-|:-|
|Listados |1. Listado de ventas filtrado por rango de fecha y método de pago => detalle de la comanda y platos consumidos.<br>2. Listado de platos.<br>3. Metodos de pago.|
|CUU/Epic||
|Otros||