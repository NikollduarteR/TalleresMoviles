# Taller 4

Aplicación móvil desarrollada en Flutter que permite gestionar tareas, funcionando con o sin conexión a internet, con sincronización automática al recuperar la conectividad.
Incluye backend hecho en FastAPI, gestión de estado con Provider, arquitectura modular y almacenamiento local con SQLite.

---

## 2. Arquitectura y Gestión de Estado

La aplicación implementa una arquitectura limpia y modular, organizada en tres capas principales:

### Capa UI (`presentation/`)
- Contiene widgets y pantallas como **TaskListView** y **TaskFormView**
- Maneja la interacción con el usuario
- Controla la navegación entre vistas

### Capa de Lógica (`provider/`)
Se utiliza **Provider** para la gestión del estado global:

- `TaskProvider` administra la lista local de tareas  
- Realiza la recarga, creación, actualización y eliminación  
- Notifica a los listeners cuando los datos cambian

### Capa de Datos (`services/` y `models/`)
Separada en dos fuentes:

#### 📌 Local (SQLite)
- Tabla `tasks` para almacenamiento local
- Tabla `queue_operations` para registrar cambios cuando no hay internet

#### 📌 Remota (FastAPI)
- Servicio HTTP que ofrece CRUD completo
- Comunicación mediante JSON

### Principios aplicados
- Separación de responsabilidades  
- Uso de repositorios  
- Cero lógica de negocio dentro de la UI  

---

## 3. Integración con API REST

El backend FastAPI ofrece endpoints estándar:

| Método | Endpoint         | Descripción                |
|--------|-----------------|----------------------------|
| GET    | `/tasks`        | Obtiene todas las tareas   |
| POST   | `/tasks`        | Crea una tarea             |
| GET    | `/tasks/{id}`   | Obtiene una tarea específica |
| PUT    | `/tasks/{id}`   | Actualiza una tarea        |
| DELETE | `/tasks/{id}`   | Elimina una tarea          |

### Formato JSON esperado
json
{
  "id": "string",
  "title": "string",
  "completed": false,
  "updatedAt": "ISO8601"
}

## 4. Persistencia Local con SQLite (sqflite)

La base de datos contiene dos tablas principales:

### Tabla `tasks`

CREATE TABLE tasks (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  completed INTEGER NOT NULL,
  updated_at TEXT NOT NULL,
  deleted INTEGER NOT NULL DEFAULT 0
);

### Tabla `queue_operations`
Almacena operaciones pendientes cuando no hay conexión:

CREATE TABLE queue_operations (
  id TEXT PRIMARY KEY,
  entity_id TEXT,
  op TEXT,
  payload TEXT,
  created_at INTEGER,
  attempt_count INTEGER,
  last_error TEXT
);

## 5. Estrategia Offline-First y Sincronización

La aplicación está diseñada para funcionar incluso sin Internet.

### ✅ Lecturas
- Los datos se cargan siempre primero desde SQLite
- Si hay conexión, se sincronizan silenciosamente desde el backend

### ✅ Escrituras Offline
Toda operación (crear, editar, eliminar):
- Se guarda localmente
- Se agrega a `queue_operations`
- Se sincroniza cuando vuelve la conexión

### ✅ Proceso de Sincronización
- Se detecta conectividad (o al iniciar la app)
- Se leen todas las operaciones pendientes
- Se envían al backend
- Si el servidor confirma, se elimina la operación
- Si falla, se reintenta luego (se puede aplicar backoff exponencial)

### ✅ Resolución de Conflictos
Se utiliza la estrategia **Last-Write-Wins (LWW)** empleando el campo `updatedAt`.
