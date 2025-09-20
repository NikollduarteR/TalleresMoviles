# taller 2 - 

## Arquitectura y Navegación
La aplicación utiliza go_router para la navegación entre pantallas y el paso de parámetros.
La estructura principal de navegación es la siguiente:

**Rutas existentes**
- /

Pantalla principal (HomeScreen):
Contiene un TabBar con varias pestañas. En la primera pestaña se muestra un GridView con varias opciones.

- /registrar
Pantalla de registro (RegistrarScreen):
Se accede al seleccionar **"Opción 1"** en el grid. Aquí se muestra un TextField para ingresar un dato y botones para navegar a la pantalla de detalle usando los métodos go, push o replace.

- /detalle/:metodo/:valor
Pantalla de detalle (RegistrarDetalleScreen):
Muestra el valor ingresado en el TextField y el método de navegación utilizado.

**¿Cómo se envían los parámetros?**
- Al escribir un valor en el TextField de la pantalla de registro y presionar uno de los botones (go, push, replace), se navega a la ruta /detalle/:metodo/:valor, donde:

  - :metodo es el método de navegación utilizado.
  - :valor es el texto ingresado por el usuario.

- En la pantalla de detalle, estos parámetros se reciben y se muestran en pantalla.

**Ejemplo de flujo**
El usuario abre la app y ve el TabBar.
En la primera pestaña, el usuario selecciona Opción 1 del grid.
Se navega a la pantalla de registro (/registrar).
El usuario ingresa un dato en el TextField y elige cómo navegar (go, push o replace).
Se navega a la pantalla de detalle (/detalle/:metodo/:valor), donde se muestran el método y el valor recibido.

## Ciclo de Vida

La aplicación incluye una pantalla dedicada a demostrar el ciclo de vida de un StatefulWidget en Flutter.
Puedes acceder a esta pantalla seleccionando **"Opción 2"** en el GridView de la pestaña principal.

En esta pantalla se muestran y registran en consola los métodos clave del ciclo de vida:

- **initState:** Se ejecuta una vez al crear el widget.
- **didChangeDependencies:** Se ejecuta después de initState y cuando cambian las dependencias.
- **build:** Se ejecuta cada vez que el widget se reconstruye.
- **setState:** Se llama manualmente para actualizar el estado y reconstruir el widget.
- **dispose:** Se ejecuta justo antes de eliminar el widget del árbol.

## Widget 
- **TabBar:** se utilizó para organizar las secciones principales de la aplicación (Grid, Info, Ajustes) dentro de una misma pantalla. Este widget facilita la navegación sin necesidad de cambiar de página completa, lo que hace que el acceso a la información sea más rápido e intuitivo.

- **GridView:** se empleó en la sección principal para mostrar diferentes opciones (ej. Registrarse, Ciclo de vida, Opción 3) de manera ordenada y visualmente atractiva. La cuadrícula permite aprovechar mejor el espacio de la pantalla y mantiene una estructura limpia.

- **TextField:** se integró (en la opción de Registrarse) para permitir que el usuario ingrese información, como nombre, correo o contraseña. Este widget es fundamental en cualquier formulario y proporciona una experiencia de entrada de datos simple y personalizable.

## Datos del estudiante

- Nombre completo: Nikoll Ximena Duarte Rivera
- Código: 230221043