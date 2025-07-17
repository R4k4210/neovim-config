# Guía para Verificar Templates de Avante

Esta guía te ayudará a verificar que tus templates personalizados de Avante estén funcionando correctamente desde cualquier proyecto.

## 📋 Templates Disponibles

Tienes los siguientes templates configurados:
- `default.jinja` - Template por defecto
- `editing.jinja` - Para edición de código
- `suggesting.jinja` - Para sugerencias
- `planning.jinja` - Para planificación de implementación
- `typescript.jinja` - Especializado en TypeScript

## 🧪 Métodos de Verificación

### 1. Verificación Básica - Comandos de Avante

#### En Neovim, ejecuta estos comandos para verificar:

```vim
:AvanteAsk ¿Qué templates tienes disponibles?
```

```vim
:AvanteChat
```

### 2. Verificación de Template Específico

#### Para probar el template de Planning:
1. Abre un archivo en tu proyecto
2. Selecciona un bloque de código o requisitos
3. Ejecuta: `:AvanteAsk` con el prompt: `@planning Crea un plan para implementar una función de autenticación`

#### Para probar el template de TypeScript:
1. Abre un archivo `.ts` o `.tsx`
2. Ejecuta: `:AvanteAsk` con: `@typescript Ayúdame a optimizar este componente React`

#### Para probar el template de Editing:
1. Selecciona código que quieras editar
2. Ejecuta: `:AvanteEdit`

### 3. Verificación desde la Terminal

#### Verifica que los templates existan:
```bash
ls ~/.config/nvim/lua/r4k4210/llm/templates/
```

#### Verifica el contenido de un template específico:
```bash
cat ~/.config/nvim/lua/r4k4210/llm/templates/planning.jinja
```

### 4. Verificación de Configuración

#### Ejecuta en Neovim:
```vim
:lua print(vim.inspect(require('avante.config').get().template_dir))
```

Debería mostrar: `/Users/r4k4210/.config/nvim/lua/r4k4210/llm/templates`

### 5. Test de Debugging

#### Crea un archivo de test temporal:
```vim
:e test_avante.md
```

#### Escribe contenido de prueba:
```markdown
# Test de Templates Avante

## Requisitos para probar:
- Función de login
- Validación de formularios
- Manejo de errores
```

#### Selecciona el texto y prueba:
- `:AvanteAsk @planning Analiza estos requisitos`
- `:AvanteAsk @typescript Convierte esto a TypeScript`

## 🔍 Indicadores de que Funciona Correctamente

### ✅ Señales Positivas:
1. **Respuestas estructuradas**: Las respuestas siguen el formato definido en cada template
2. **Contexto específico**: El AI responde con conocimiento específico del template usado
3. **Sin errores**: No aparecen mensajes de error sobre templates no encontrados
4. **Autocompletado**: Al escribir `@` deberías ver los templates disponibles

### ❌ Señales de Problemas:
1. **Error de template**: "Template not found" o similar
2. **Respuestas genéricas**: El AI no sigue el formato específico del template
3. **No hay autocompletado**: Los templates no aparecen al escribir `@`

## 🛠 Troubleshooting

### Si los templates no funcionan:

1. **Verifica la ruta**:
   ```vim
   :lua print(require('avante.config').get().template_dir)
   ```

2. **Reinicia Neovim** después de cambios en la configuración

3. **Verifica permisos**:
   ```bash
   ls -la ~/.config/nvim/lua/r4k4210/llm/templates/
   ```

4. **Revisa logs de Avante**:
   ```vim
   :messages
   ```

5. **Verifica sintaxis de templates**:
   - Los archivos deben tener extensión `.jinja`
   - La sintaxis Jinja debe ser correcta

## 📝 Ejemplo de Uso Completo

### Escenario: Planificar una nueva funcionalidad

1. **Abre tu proyecto** en Neovim
2. **Crea o abre un archivo** donde quieras planificar
3. **Escribe los requisitos**:
   ```
   Necesito implementar un sistema de notificaciones push que:
   - Envíe notificaciones en tiempo real
   - Permita personalizar tipos de notificación
   - Tenga fallback para navegadores sin soporte
   ```
4. **Selecciona el texto** (modo visual)
5. **Ejecuta**: `:AvanteAsk @planning`
6. **Verifica** que la respuesta incluya:
   - Análisis de requisitos
   - Arquitectura propuesta
   - Pasos de implementación
   - Recomendaciones tecnológicas
   - Estrategia de testing

### Resultado Esperado:
El AI debería responder con un plan estructurado siguiendo el formato definido en `planning.jinja`, incluyendo secciones específicas como "Requirements Analysis", "Architecture Design", etc.

## 🎯 Tips para Mejores Resultados

1. **Usa nombres descriptivos**: `@planning`, `@typescript`, etc.
2. **Proporciona contexto**: Incluye información relevante antes de usar el template
3. **Combina templates**: Puedes usar diferentes templates en una misma sesión
4. **Itera**: Usa los resultados de un template como input para otro

## 📊 Verificación Automática

### Script de verificación rápida:
```bash
#!/bin/bash
echo "🔍 Verificando templates de Avante..."

TEMPLATE_DIR="$HOME/.config/nvim/lua/r4k4210/llm/templates"

if [ -d "$TEMPLATE_DIR" ]; then
    echo "✅ Directorio de templates encontrado: $TEMPLATE_DIR"
    echo "📁 Templates disponibles:"
    ls -1 "$TEMPLATE_DIR"/*.jinja 2>/dev/null | wc -l | xargs echo "   Cantidad:"
    ls -1 "$TEMPLATE_DIR"/*.jinja 2>/dev/null | sed 's/.*\//   - /'
else
    echo "❌ Directorio de templates no encontrado: $TEMPLATE_DIR"
fi
```

Guarda esto como `check_templates.sh` y ejecútalo para verificar rápidamente.

---

¡Con esta guía deberías poder verificar completamente que tus templates estén funcionando correctamente desde cualquier proyecto!

