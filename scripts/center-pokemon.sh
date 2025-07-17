#!/usr/bin/env bash

# Ejecutá el colorscript y guardá el output
pokemon=$(pokemon-colorscripts -r --no-title)

# Obtené el ancho de la terminal
cols=$(tput cols)

# Centramos cada línea
while IFS= read -r line; do
  # Calcula el largo sin colores ANSI
  clean_line=$(echo "$line" | sed 's/\x1B\[[0-9;]*[a-zA-Z]//g')
  padding=$(( (cols - ${#clean_line}) / 2 ))
  if [ $padding -gt 0 ]; then
    printf "%*s%s\n" $padding "" "$line"
  else
    echo "$line"
  fi
done <<< "$pokemon"
