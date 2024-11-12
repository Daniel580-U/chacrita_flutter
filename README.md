# chacrita

Proyecto en Flutter que hará de asistente a  Granjeros y Agricultores

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Flutter App - Proyecto Modular con Navegación

Este es un proyecto en Flutter que implementa una arquitectura modular, con navegación entre pantallas, uso de permisos y estructura organizada en `features` para asegurar escalabilidad y mantenibilidad. Este proyecto es adecuado para crear aplicaciones de gran tamaño, ya que cada `feature` puede desarrollarse y gestionarse de manera independiente.

## Estructura Prinicipal del Proyecto

```plaintext
# Estructura del Proyecto

Este proyecto está diseñado en Flutter y sigue una arquitectura modular basada en características (features). Cada feature tiene su propia lógica de negocio, modelos, vistas y servicios. La estructura de carpetas está organizada para facilitar el desarrollo escalable y mantener un código limpio y modular.

## Estructura de Directorios

```plaintext
lib/
├── app/
│   ├── app.dart               # Punto de entrada principal de la aplicación.
│   ├── config/                # Configuración global (temas, constantes, configuraciones).
│   └── routes/                # Definición de rutas para la navegación.
│       └── app_routes.dart    # Gestión de rutas en la aplicación.
├── features/
│   ├── guide/                 # Feature "Guía".
│   │   ├── controllers/       # Lógica de negocio para la funcionalidad de guía.
│   │   ├── models/            # Modelos de datos para la guía.
│   │   ├── pages/             # Páginas (vistas) para la funcionalidad de guía.
│   │   │   └── guide_page.dart
│   │   ├── services/          # Servicios relacionados con la guía (por ejemplo, acceso a APIs).
│   │   └── widgets/           # Widgets personalizados para la UI de la guía.
│   ├── index/                 # Feature "Índice".
│   │   ├── controllers/       # Lógica de negocio para la funcionalidad de índice.
│   │   ├── models/            # Modelos de datos para el índice.
│   │   ├── pages/             # Páginas (vistas) para la funcionalidad de índice.
│   │   │   └── index_page.dart
│   │   └── widgets/           # Widgets personalizados para la UI del índice.
│   ├── main/                  # Feature "Principal".
│   │   ├── controllers/       # Lógica de negocio para la funcionalidad principal.
│   │   ├── models/            # Modelos de datos para la funcionalidad principal.
│   │   ├── pages/             # Páginas para la funcionalidad principal.
│   │   │   ├── main_page.dart
│   │   │   └── permission_location_page.dart
│   │   └── widgets/           # Widgets personalizados para la funcionalidad principal.
│   └── main_features/         # Funcionalidades principales adicionales (como chat y grabación).
│       ├── chat/              # Feature de chat.
│       │   ├── controllers/   # Lógica de negocio para el chat.
│       │   ├── models/        # Modelos de datos para el chat.
│       │   ├── pages/         # Páginas del chat.
│       │   │   └── chat_page.dart
│       │   ├── services/      # Servicios relacionados con el chat (por ejemplo, API de mensajería).
│       │   └── widgets/       # Widgets del chat.
│       └── record/            # Feature de grabación.
│           ├── controllers/   # Lógica de negocio para la grabación.
│           ├── models/        # Modelos de datos para la grabación.
│           ├── pages/         # Páginas de grabación.
│           │   └── record_page.dart
│           ├── services/      # Servicios relacionados con el record (por ejemplo, API procesamiento de datos).
│           └── widgets/       # Widgets de grabación.
└── main.dart                   # Punto de entrada de la aplicación (inicializa la app).
