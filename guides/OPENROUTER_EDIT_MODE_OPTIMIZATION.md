# Guía de Optimización: OpenRouter + Avante Edit Mode

## 🚨 Problema Identificado

OpenRouter tiene problemas conocidos con el modo edit de Avante, específicamente:

- Crashes en streaming mode
- Errores en `selection.lua`
- Problemas con herramientas (tools)
- Timeouts en respuestas largas

## ✅ Configuraciones Implementadas

### 1. **Streaming Deshabilitado** ⭐ **CRÍTICO**

```lua
behaviour = {
  streaming = false, -- Evita crashes con OpenRouter en edit mode
}
```

**Por qué**: Los crashes más comunes ocurren en streaming mode con OpenRouter.

### 2. **Timeout Extendido**

```lua
openrouter = {
  timeout = 60000, -- 60 segundos (vs 30 por defecto)
}
```

**Por qué**: OpenRouter a veces es más lento que providers directos.

### 3. **Temperatura = 0** (DEPRECATED)

```lua
openrouter = {
  temperature = 0, -- Respuestas determinísticas
}
```

**Por qué**: Reduce variabilidad que puede causar errores de parsing.

### 4. **Límite de Tokens**

```lua
openrouter = {
  max_tokens = 8192, -- Evita respuestas excesivamente largas
}
```

**Por qué**: Respuestas muy largas pueden causar problemas de memoria.

### 5. **Cursor Planning Mode Habilitado**

```lua
behaviour = {
  enable_cursor_planning_mode = true,
}
```

**Por qué**: Más compatible con OpenRouter que el modo agentic completo.

## 🔧 Configuraciones Adicionales Recomendadas

### **Si Sigues Teniendo Problemas:**

#### Opción A: Deshabilitar herramientas problemáticas

```lua
openrouter = {
  disabled_tools = { "str_replace" }, -- Solo si hay errores específicos
}
```

#### Opción B: Modelo más estable

```lua
openrouter = {
  model = "anthropic/claude-3-5-sonnet", -- En lugar de claude-sonnet-4
}
```

#### Opción C: Reducir contexto

```lua
context = {
  max_files = 3,           -- Menos archivos en contexto
  max_lines_per_file = 50, -- Menos líneas por archivo
}
```

## 🧪 Proceso de Testing

### **Test 1: Verificar Configuración**

```vim
:lua print(vim.inspect(require('avante.config').get().behaviour.streaming))
```

Debe mostrar: `false`

### **Test 2: Probar Edit Mode Básico**

1. Abre un archivo simple
2. Selecciona unas líneas: `V` + `jjj`
3. Ejecuta: `:AvanteEdit`
4. Observa si hay errores en `:messages`

### **Test 3: Verificar Provider**

```vim
:lua print(require('avante.config').get().provider)
```

Debe mostrar: `"openrouter"`

## 🚫 Configuraciones a Evitar con OpenRouter

| Configuración        | Evitar | Razón                          |
| -------------------- | ------ | ------------------------------ |
| `streaming = true`   | ❌     | Causa crashes conocidos        |
| `temperature > 0.3`  | ❌     | Respuestas inconsistentes      |
| `max_tokens > 16384` | ❌     | Puede causar timeouts          |
| `timeout < 30000`    | ❌     | OpenRouter necesita más tiempo |

## 📊 Modelos Recomendados en OpenRouter

### **Para Edit Mode (Más Estables):**

1. `anthropic/claude-3-5-sonnet` ⭐ **RECOMENDADO**
2. `openai/gpt-4o`
3. `anthropic/claude-3-sonnet`

### **Evitar para Edit Mode:**

- `deepseek/deepseek-r1` (problemas conocidos)
- Modelos experimentales o beta
- Modelos con `reasoning_effort`

## 🔍 Diagnóstico de Problemas

### **Si Edit Mode Sigue Fallando:**

#### 1. Verificar Logs

```vim
:messages
```

Busca errores relacionados con `selection.lua` o `prev_line`.

#### 2. Test con Archivo Pequeño

- Crea archivo con 5-10 líneas
- Selecciona solo 2-3 líneas
- Prueba `:AvanteEdit`

#### 3. Verificar API Key

```bash
echo $OPENROUTER_API_KEY
```

#### 4. Test de Conectividad

```vim
:AvanteAsk "Hello, can you respond?"
```

## 💡 Consejos de Uso

### **Mejores Prácticas con OpenRouter:**

1. **Selecciones Pequeñas**: Selecciona máximo 20-30 líneas
2. **Archivos Simples**: Evita archivos muy grandes (>500 líneas)
3. **Prompts Claros**: Sé específico en lo que quieres editar
4. **Paciencia**: OpenRouter puede ser más lento que providers directos

### **Workflow Recomendado:**

1. Selecciona código específico
2. Usa `:AvanteEdit` para cambios pequeños
3. Para cambios grandes, usa `:AvanteAsk @planning` primero
4. Aplica cambios manualmente si es necesario

## ⚡ Optimizaciones de Performance

### **Para Mejor Rendimiento:**

```lua
behaviour = {
  enable_token_counting = false,    -- Reduce overhead
  minimize_diff = true,            -- Menos procesamiento
  auto_apply_diff_after_generation = false, -- Control manual
}
```

### **Para Proyectos Grandes:**

```lua
repo_map = {
  ignore_patterns = {
    "node_modules", "__pycache__", ".git",
    "%.log", "%.tmp", "build/", "dist/"
  },
}
```

## 🎯 Resultado Esperado

Con estas configuraciones deberías poder usar `:AvanteEdit` con OpenRouter de manera más estable:

- ✅ Sin crashes por streaming
- ✅ Timeouts adecuados
- ✅ Respuestas más consistentes
- ✅ Mejor manejo de errores

## 🆘 Plan B: Si Nada Funciona

Si el edit mode sigue fallando con OpenRouter:

1. **Usa templates alternativos:**

   ```vim
   :AvanteAsk @editing <describe what you want to change>
   ```

2. **Combina providers:**

   ```lua
   provider = "openrouter",              -- Para chat
   auto_suggestions_provider = "claude", -- Para edit mode
   ```

3. **Considera upgrade temporal a Claude directo:**
   Solo para proyectos críticos donde necesites edit mode estable.

---

**Conclusión**: Con `streaming = false` y las otras optimizaciones, deberías tener una experiencia mucho más estable con OpenRouter y el modo edit.
