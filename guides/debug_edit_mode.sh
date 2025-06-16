#!/bin/bash

# Script de diagnóstico para Avante Edit Mode
echo "🔍 Diagnosticando problemas con Avante Edit Mode..."
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar estado
show_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
    fi
}

# 1. Verificar directorio de templates
echo -e "${BLUE}📁 Verificando templates...${NC}"
TEMPLATE_DIR="$HOME/.config/nvim/lua/r4k4210/llm/templates"

if [ -d "$TEMPLATE_DIR" ]; then
    show_status 0 "Directorio de templates encontrado"
    
    # Verificar template de editing específicamente
    if [ -f "$TEMPLATE_DIR/editing.jinja" ]; then
        show_status 0 "Template editing.jinja existe"
        
        # Verificar que contiene la variable selection
        if grep -q "{{ selection }}" "$TEMPLATE_DIR/editing.jinja"; then
            show_status 0 "Template contiene variable {{ selection }}"
        else
            show_status 1 "Template NO contiene variable {{ selection }}"
        fi
        
        # Mostrar tamaño del template
        SIZE=$(wc -l < "$TEMPLATE_DIR/editing.jinja")
        echo "   📄 Template editing.jinja: $SIZE líneas"
    else
        show_status 1 "Template editing.jinja NO existe"
    fi
else
    show_status 1 "Directorio de templates NO encontrado"
fi

echo ""

# 2. Verificar API Key
echo -e "${BLUE}🔑 Verificando API Key...${NC}"
if [ -n "$OPENROUTER_API_KEY" ]; then
    show_status 0 "OPENROUTER_API_KEY está configurado"
    echo "   🔐 Key: ${OPENROUTER_API_KEY:0:8}...${OPENROUTER_API_KEY: -4}"
else
    show_status 1 "OPENROUTER_API_KEY NO está configurado"
    echo -e "${YELLOW}   💡 Configura con: export OPENROUTER_API_KEY='tu_api_key'${NC}"
fi

echo ""

# 3. Verificar configuración de Neovim
echo -e "${BLUE}⚙️  Verificando configuración de Neovim...${NC}"

# Verificar que el archivo de configuración existe
AVANTE_CONFIG="$HOME/.config/nvim/lua/r4k4210/plugins/avante.lua"
if [ -f "$AVANTE_CONFIG" ]; then
    show_status 0 "Archivo de configuración de Avante encontrado"
    
    # Verificar configuraciones clave
    if grep -q "template_dir.*r4k4210/llm/templates" "$AVANTE_CONFIG"; then
        show_status 0 "template_dir configurado correctamente"
    else
        show_status 1 "template_dir NO configurado o incorrecto"
    fi
    
    if grep -q "provider.*openrouter" "$AVANTE_CONFIG"; then
        show_status 0 "Provider OpenRouter configurado"
    else
        show_status 1 "Provider OpenRouter NO configurado"
    fi
    
    if grep -q "auto_set_keymaps.*true" "$AVANTE_CONFIG"; then
        show_status 0 "auto_set_keymaps habilitado"
    else
        show_status 1 "auto_set_keymaps NO habilitado"
    fi
else
    show_status 1 "Archivo de configuración de Avante NO encontrado"
fi

echo ""

# 4. Crear archivo de test para probar
echo -e "${BLUE}🧪 Creando archivo de test...${NC}"
TEST_FILE="/tmp/avante_test.js"
cat > "$TEST_FILE" << 'EOF'
// Test code for Avante Edit Mode
function hello() {
    console.log("hello world");
    var x = 1;
    return x;
}
EOF

show_status 0 "Archivo de test creado: $TEST_FILE"
echo "   📝 Contenido:"
echo "   $(cat "$TEST_FILE" | sed 's/^/      /')"

echo ""

# 5. Instrucciones de test manual
echo -e "${BLUE}📋 Instrucciones para test manual:${NC}"
echo ""
echo "1. Abre Neovim con el archivo de test:"
echo -e "${YELLOW}   nvim $TEST_FILE${NC}"
echo ""
echo "2. En Neovim, selecciona el código:"
echo -e "${YELLOW}   ggVG${NC} (seleccionar todo)"
echo "   o"
echo -e "${YELLOW}   V${NC} (seleccionar línea actual)"
echo ""
echo "3. Ejecuta el comando de editar:"
echo -e "${YELLOW}   :AvanteEdit${NC}"
echo ""
echo "4. Si no funciona, prueba estos comandos de debug:"
echo -e "${YELLOW}   :lua print(require('avante.config').get().template_dir)${NC}"
echo -e "${YELLOW}   :command Avante${NC}"
echo -e "${YELLOW}   :messages${NC}"
echo ""

# 6. Comandos de verificación adicionales
echo -e "${BLUE}🔧 Comandos de verificación en Neovim:${NC}"
echo ""
echo "# Verificar que Avante está cargado:"
echo -e "${YELLOW}:lua print(vim.inspect(require('avante')))${NC}"
echo ""
echo "# Verificar configuración completa:"
echo -e "${YELLOW}:lua print(vim.inspect(require('avante.config').get()))${NC}"
echo ""
echo "# Verificar comandos disponibles:"
echo -e "${YELLOW}:command Avante${NC}"
echo ""
echo "# Habilitar debug mode:"
echo -e "${YELLOW}:lua vim.g.avante_debug = true${NC}"
echo ""
echo "# Ver mensajes de error:"
echo -e "${YELLOW}:messages${NC}"
echo ""

# 7. Resumen
echo -e "${BLUE}📊 Resumen del diagnóstico:${NC}"
echo ""

# Contar problemas encontrados
PROBLEMS=0

if [ ! -d "$TEMPLATE_DIR" ]; then
    ((PROBLEMS++))
fi

if [ ! -f "$TEMPLATE_DIR/editing.jinja" ]; then
    ((PROBLEMS++))
fi

if [ -z "$OPENROUTER_API_KEY" ]; then
    ((PROBLEMS++))
fi

if [ ! -f "$AVANTE_CONFIG" ]; then
    ((PROBLEMS++))
fi

if [ $PROBLEMS -eq 0 ]; then
    echo -e "${GREEN}🎉 No se encontraron problemas obvios en la configuración${NC}"
    echo -e "${GREEN}   El problema podría estar en la selección de texto o en Neovim${NC}"
else
    echo -e "${RED}⚠️  Se encontraron $PROBLEMS problema(s) potencial(es)${NC}"
    echo -e "${YELLOW}   Revisa los elementos marcados con ❌ arriba${NC}"
fi

echo ""
echo -e "${BLUE}💡 Próximos pasos:${NC}"
echo "1. Corregir cualquier problema marcado con ❌"
echo "2. Ejecutar el test manual en Neovim"
echo "3. Si sigue sin funcionar, revisar :messages para errores específicos"
echo ""

# Limpiar archivo de test
rm -f "$TEST_FILE" 2>/dev/null

