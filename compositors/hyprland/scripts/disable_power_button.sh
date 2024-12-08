#!/bin/bash

# Ruta del archivo a analizar
FILE="/etc/systemd/logind.conf"

# Propiedad a buscar
PROPERTY="HandlePowerKey"
VALUE="ignore"

# Verifica si el archivo existe
if [ ! -f "$FILE" ]; then
    echo "El archivo $FILE no existe."
    exit 1
fi

# Busca si la propiedad existe en el archivo
if grep -q "^$PROPERTY=" "$FILE"; then
    # Si existe, reemplaza su valor por 'ignore'
    sed -i "s/^$PROPERTY=.*/$PROPERTY=$VALUE/" "$FILE"
    echo "La propiedad '$PROPERTY' ya existía y se actualizó a '$VALUE'."
else
    # Si no existe, agrégala al final del archivo
    echo "$PROPERTY=$VALUE" >> "$FILE"
    echo "La propiedad '$PROPERTY' no existía y se agregó con el valor '$VALUE'."
fi

# Reinicia el servicio logind para aplicar cambios
systemctl restart systemd-logind
echo "Cambios aplicados y servicio systemd-logind reiniciado."
