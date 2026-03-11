# Manual de usuario — Peerval

## 1. Descripción general

**Peerval** es una aplicación para evaluación de compañeros en trabajos grupales que, en este primer avance, incluye:

- pantalla principal de selección de rol
- autenticación
  - inicio de sesión
  - registro
- home para estudiante
- home para docente
- manejo básico de estado con GetX
- navegación entre pantallas según el rol del usuario

La app permite que una persona elija si entra como **Estudiante** o como **Docente**, y a partir de esa elección se le muestra el flujo correspondiente.

## 2. Objetivo del sistema en este avance

El objetivo de esta versión es mostrar el flujo inicial de la aplicación:

- seleccionar tipo de usuario
- registrarse o iniciar sesión
- entrar al home correspondiente
- cerrar sesión y volver a la pantalla principal

En esta etapa, los usuarios se almacenan en memoria, por lo que la información no queda guardada de manera permanente al cerrar la app.

## 3. Tecnologías usadas

La aplicación fue desarrollada con:

- Flutter
- Dart
- GetX para:
  - manejo de estado
  - inyección de dependencias
  - navegación y mensajes visuales

## 4. Estructura funcional de la app

La aplicación está dividida en varias partes:

### Pantallas principales

- Pantalla inicial
- Login
- Registro
- Home estudiante
- Home docente

### Lógica

#### AuthenticationController

Se encarga de:

- registrar usuarios
- validar inicio de sesión
- guardar el usuario actual
- cerrar sesión

### Modelo de usuario

Cada usuario tiene:

- correo
- contraseña
- nombre
- rol

## 5. Flujo general de uso

### Paso 1: pantalla inicial

Al abrir la app, aparece una pantalla de bienvenida con dos opciones:

- Estudiante
- Docente

El usuario debe seleccionar una de las dos.

### Paso 2: autenticación

Después de elegir el rol, la app lleva al usuario a la pantalla de autenticación de ese rol.

Desde ahí puede:

- iniciar sesión
- ir a registrarse

### Paso 3: acceso al home

Si el proceso es exitoso:

- el estudiante entra al **Home de estudiante**
- el docente entra al **Home de docente**

### Paso 4: cerrar sesión

En ambos homes, el botón de la parte superior derecha funciona como **cerrar sesión**.

Al presionarlo:

- se limpia el usuario actual
- se regresa a la pantalla principal
