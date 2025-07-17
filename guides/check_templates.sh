#!/bin/bash

# Script para verificar templates de Avante
echo "🔍 Verificando templates de Avante..."
echo ""

TEMPLATE_DIR="$HOME/.config/nvim/lua/r4k4210/llm/templates"

# Verificar si el directorio existe
if [ -d "$TEMPLATE_DIR" ]; then
    echo "✅ Directorio de templates encontrado: $TEMPLATE_DIR"
    echo ""
    
    # Contar templates
    TEMPLATE_COUNT=$(ls -1 "$TEMPLATE_DIR"/*.jinja 2>/dev/null | wc -l)
    echo "📁 Templates disponibles ($TEMPLATE_COUNT):"
    
    # Listar templates con detalles
    if [ "$TEMPLATE_COUNT" -gt 0 ]; then
        for template in "$TEMPLATE_DIR"/*.jinja; do
            if [ -f "$template" ]; then
                NAME=$(basename "$template" .jinja)
                SIZE=$(wc -l < "$template" 2>/dev/null || echo "?")
                echo "   - $NAME.jinja ($SIZE líneas)"
            fi
        done
    else
        echo "   ⚠️  No se encontraron templates .jinja"
    fi
    
    echo ""
    echo "🔧 Verificación de permisos:"
    ls -la "$TEMPLATE_DIR"/*.jinja 2>/dev/null | head -5
    
else
    echo "❌ Directorio de templates no encontrado: $TEMPLATE_DIR"
    echo ""
    echo "💡 Sugerencias:"
    echo "   1. Verifica que Neovim esté correctamente configurado"
    echo "   2. Revisa la configuración de Avante en: ~/.config/nvim/lua/r4k4210/plugins/avante.lua"
    echo "   3. Asegúrate de que el directorio exista: mkdir -p $TEMPLATE_DIR"
fi

echo ""
echo "📋 Para probar los templates en Neovim:"
echo "   :AvanteAsk @planning <tu_pregunta>"
echo "   :AvanteAsk @typescript <tu_pregunta>"
echo "   :AvanteEdit (con código seleccionado)"
echo ""
echo "🔍 Para verificar configuración en Neovim:"
echo "   :lua print(vim.inspect(require('avante.config').get().template_dir))"

