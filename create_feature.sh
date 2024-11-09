#!/bin/bash

# Verifica que se haya proporcionado el nombre del feature
if [ -z "$1" ]; then
  echo "Por favor, proporciona el nombre del feature."
  echo "Uso: ./create_feature.sh nombre_feature"
  exit 1
fi

# Asigna el primer argumento como el nombre del feature
FEATURE_NAME=$1

# Ruta base para la característica dentro del proyecto
BASE_DIR="lib/features/$FEATURE_NAME"

# Archivo de rutas
ROUTES_FILE="lib/app/routes/app_routes.dart"


# Crea la estructura de carpetas
echo "Creando estructura para $FEATURE_NAME..."
mkdir -p "$BASE_DIR/pages"
mkdir -p "$BASE_DIR/widgets"
mkdir -p "$BASE_DIR/controllers"
mkdir -p "$BASE_DIR/models"

# Crea archivos iniciales con contenido de ejemplo o en blanco
echo "Creando archivos iniciales..."

# Archivo de la página principal del feature
cat <<EOF > "$BASE_DIR/pages/${FEATURE_NAME}_page.dart"
import 'package:flutter/material.dart';

class ${FEATURE_NAME^}Page extends StatelessWidget {
  const ${FEATURE_NAME^}Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$FEATURE_NAME Page'),
      ),
      body: Center(
        child: Text('Bienvenido a $FEATURE_NAME'),
      ),
    );
  }
}
EOF

# Archivo de widget de ejemplo
cat <<EOF > "$BASE_DIR/widgets/${FEATURE_NAME}_widget.dart"
import 'package:flutter/material.dart';

class ${FEATURE_NAME^}Widget extends StatelessWidget {
  const ${FEATURE_NAME^}Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text('Este es un widget de $FEATURE_NAME'),
    );
  }
}
EOF

# Archivo de controlador de ejemplo
cat <<EOF > "$BASE_DIR/controllers/${FEATURE_NAME}_controller.dart"
class ${FEATURE_NAME^}Controller {
  // Agrega lógica y controladores para $FEATURE_NAME
}
EOF

# Archivo de modelo de ejemplo
cat <<EOF > "$BASE_DIR/models/${FEATURE_NAME}_model.dart"
class ${FEATURE_NAME^}Model {
  // Define propiedades y métodos del modelo de $FEATURE_NAME
}
EOF

# Nombre de la ruta en minúsculas
ROUTE_NAME="${FEATURE_NAME,,}"
ROUTE_STATIC="static const String $ROUTE_NAME = '/$ROUTE_NAME';"
ROUTE_PATH="$ROUTE_NAME :(context)=> const ${FEATURE_NAME^}Page(),"

# Verifica si el archivo de rutas existe
if [ ! -f "$ROUTES_FILE" ]; then
  echo "El archivo $ROUTES_FILE no existe. Por favor, verifica la ruta."
  exit 1
fi

# Agrega la importación de la página al archivo de rutas en orden alfabético
IMPORT_LINE="import 'package:chacrita/features/$FEATURE_NAME/pages/${FEATURE_NAME}_page.dart';"
if grep -q "$IMPORT_LINE" "$ROUTES_FILE"; then
  echo "La importación ya existe en $ROUTES_FILE."
else
  echo "Agregando la importación al archivo $ROUTES_FILE..."
  awk -v line="$IMPORT_LINE" '
    /^import / && !x {print line; x=1} 1
  ' "$ROUTES_FILE" > temp && mv temp "$ROUTES_FILE"
fi

# Agrega el string despues de la última ruta
if grep -q "$ROUTE_STATIC" "$ROUTES_FILE"; then
  echo "La linea $ROUTE_STATIC ya existe en el archivo $ROUTES_FILE."
else
  echo "Agregando la ruta $ROUTE_STATIC a AppRoutes..."
  sed -i "/class AppRoutes {/a \ \ \ \ $ROUTE_STATIC" "$ROUTES_FILE"
fi

# Agrega la ruta al Map de getRoutes antes del último cierre
if grep -q "$ROUTE_PATH" "$ROUTES_FILE"; then
  echo "La ruta $ROUTE_PATH ya existe en el archivo $ROUTES_FILE."
else
  echo "Agregando la ruta $ROUTE_NAME a AppRoutes..."
  sed -i "/return {/a \ \ \ \ $ROUTE_PATH" "$ROUTES_FILE"
fi

echo "Importación y ruta agregadas en $ROUTES_FILE para $FEATURE_NAME."
