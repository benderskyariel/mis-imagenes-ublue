#!/usr/bin/env bash
set -euo pipefail

# Crear el directorio plantilla dentro de la estructura de la imagen
mkdir -p /usr/share/keybase-template

# Trabajar en un directorio temporal del contenedor de compilación
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "Descargando y extrayendo Keybase en la imagen..."
curl -L -O https://prerelease.keybase.io/keybase_amd64.rpm
rpm2cpio keybase_amd64.rpm | cpio -idmv --quiet

# Mover la estructura extraída a la plantilla de la imagen
mv usr /usr/share/keybase-template/
mv opt /usr/share/keybase-template/

# Limpieza dentro del contenedor de compilación
rm -rf "$TEMP_DIR"
