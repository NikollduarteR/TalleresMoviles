# 🔐 Taller de Autenticación JWT en Flutter

Este proyecto implementa un sistema de autenticación con **JWT (JSON Web Token)** en una aplicación móvil Flutter.  
El objetivo es realizar el **consumo de un API REST** con manejo de **login, almacenamiento seguro del token y redirección** a una pantalla principal después de iniciar sesión correctamente.

---

## 📘 Descripción general

La aplicación permite que el usuario inicie sesión ingresando su correo electrónico y contraseña.  
Al validar las credenciales, el sistema realiza una petición `POST` al endpoint `/auth/login` del API.  
Si la autenticación es exitosa, se almacena el **token JWT** y la información del usuario en el **almacenamiento seguro** del dispositivo.

Este taller forma parte de la asignatura **Talleres Móviles**, y busca aplicar los conceptos de:
- Consumo de API REST
- Manejo de tokens JWT
- Almacenamiento local seguro (`flutter_secure_storage`)
- Manejo de rutas y navegación (`go_router`)
- Buenas prácticas con variables de entorno (`flutter_dotenv`)
