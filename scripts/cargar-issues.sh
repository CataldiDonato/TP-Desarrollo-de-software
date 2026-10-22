#!/usr/bin/env bash
# Carga en GitHub el tracking de docs/tracking.md: un issue por feature, bug y pendiente.
# Los ya resueltos se cierran con un comentario que apunta a sus commits.
# Al final crea un GitHub Project (tablero) y le agrega todos los issues.
#
# Requisitos (una sola vez):
#   gh auth login
#   gh auth refresh -s project      # permiso para crear el tablero
#
# Uso, desde la raíz del repo:
#   bash scripts/cargar-issues.sh
#
# Correrlo UNA sola vez: si se corre de nuevo, duplica los issues.
set -euo pipefail

REPO="CataldiDonato/TP-Desarrollo-de-software"
OWNER="CataldiDonato"
URL_COMMIT="https://github.com/$REPO/commit"

ISSUES_CREADOS=()

crear_label() {
  gh label create "$1" --repo "$REPO" --color "$2" --description "$3" 2>/dev/null || true
}

# crear_issue <label> <titulo> <responsable> <commits separados por espacio o vacío si está pendiente>
crear_issue() {
  local label="$1" titulo="$2" responsable="$3" commits="$4"
  local cuerpo="Responsable: **$responsable**

Cargado desde [docs/tracking.md](../blob/main/docs/tracking.md)."
  local url
  url=$(gh issue create --repo "$REPO" --title "$titulo" --label "$label" --body "$cuerpo")
  ISSUES_CREADOS+=("$url")

  if [[ -n "$commits" ]]; then
    local links=""
    for c in $commits; do links+="- $URL_COMMIT/$c"$'\n'; done
    gh issue close "$url" --repo "$REPO" --comment "Resuelto en:
$links"
  fi
  echo "✔ $titulo"
}

crear_label "feature" "1d76db" "Funcionalidad nueva"
crear_label "bug" "d73a4a" "Algo no funciona"
crear_label "entrega" "fbca04" "Tareas de la entrega a la cátedra"

# ---------- Features ----------
crear_issue feature "F1 · Setup backend (Node, Express, .env.example)" "Cataldi" "53a3ba8"
crear_issue feature "F2 · Setup frontend (React + Vite)" "Curti" "0d93bf9"
crear_issue feature "F3 · Prisma: schema del DER y migraciones" "Cataldi" "4e56dfe"
crear_issue feature "F4 · Backend en capas" "Cataldi" "5d50c3f"
crear_issue feature "F5 · CRUD Categorías y Productos con historial de precios" "Cataldi" "4a4424c 2e1be75"
crear_issue feature "F6 · CRUD Usuarios + dashboard + cocina (backend)" "Acosta" "fa0e202 001003b"
crear_issue feature "F7 · Frontend de dashboard, usuarios y cocina" "Acosta" "24a7160"
crear_issue feature "F8 · Módulo de salón: CRUD Mesas y Reservas" "Vada" "cecd986"
crear_issue feature "F9 · CRUD Medios de pago" "Curti" "c569f67 a247141"
crear_issue feature "F10 · Comandas: apertura de mesa y carga de pedido (CUU 1)" "Curti" "1dcbc5c a247141"
crear_issue feature "F11 · Login con JWT y protección por rol" "Cataldi" "2fca9ee fb97f48"
crear_issue feature "F12 · Cobro y cierre de mesa con transacción (CUU 4)" "Cataldi" "2e1be75"
crear_issue feature "F13 · Tests unitarios, de integración, de componente y e2e" "Cataldi" "2e1be75 469323a"
crear_issue feature "F14 · Documentación de la API" "Cataldi" "2e1be75"
crear_issue feature "F15 · Estilos con Tailwind CSS, mobile-first" "Cataldi" "5d04aeb"
crear_issue feature "F16 · Clases de modelo en el frontend" "Cataldi" "40aee6b"
crear_issue feature "F17 · KDS: filtro por estado, observaciones y detalle (CUU 3)" "Cataldi" "e73adb1 69d1be7 382cd30"
crear_issue feature "F18 · TypeScript strict y preparación para deploy" "Cataldi" "25638e5 0c91d91"

# ---------- Bugs ----------
crear_issue bug "B1 · El seed guardaba la contraseña sin hashear" "Acosta" "af99e71"
crear_issue bug "B2 · No se podía crear un producto (campos distintos front/back)" "Cataldi" "2e1be75"
crear_issue bug "B3 · Comandas con datos inventados y mozo fijo" "Cataldi" "2e1be75"
crear_issue bug "B4 · Los productos de una comanda nueva no llegaban a cocina" "Cataldi" "2e1be75"
crear_issue bug "B5 · Rutas de detalle-comanda cruzadas" "Cataldi" "2e1be75"
crear_issue bug "B6 · /precio-producto respondía siempre 400" "Cataldi" "2e1be75"
crear_issue bug "B7 · Reservas superpuestas en la misma mesa" "Cataldi" "2e1be75"
crear_issue bug "B8 · Rutas sin control de rol" "Cataldi" "2e1be75"
crear_issue bug "B9 · El cocinero podía hacerse pasar por otro" "Cataldi" "2e1be75"
crear_issue bug "B10 · Errores de Prisma con rutas del servidor en la respuesta" "Cataldi" "2e1be75"
crear_issue bug "B11 · Arreglos de comandas y home en el frontend" "Curti" "2f55fe9 493ba69"

# ---------- Pendientes de la entrega ----------
crear_issue entrega "I1 · Deploy y links + credenciales en el README" "(asignar)" ""
crear_issue entrega "I2 · Video demo linkeado en el README" "(asignar)" ""
crear_issue entrega "I3 · PR a utnfrrodsw/tp y formulario de entrega" "(asignar)" ""
crear_issue entrega "I4 · Completar presentes y decisiones de las minutas" "Todos" ""

# ---------- Tablero ----------
NUMERO=$(gh project create --owner "$OWNER" --title "RestoFlow — Kanban" --format json --jq '.number')
gh project link "$NUMERO" --owner "$OWNER" --repo "$REPO" || true
for url in "${ISSUES_CREADOS[@]}"; do
  gh project item-add "$NUMERO" --owner "$OWNER" --url "$url" >/dev/null
done

echo
echo "Listo: ${#ISSUES_CREADOS[@]} issues cargados en el tablero https://github.com/users/$OWNER/projects/$NUMERO"
echo "En el tablero, agrupá por Status: los cerrados van a Done y los abiertos a To Do."
