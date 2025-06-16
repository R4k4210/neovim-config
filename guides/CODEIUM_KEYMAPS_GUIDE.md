# Guía de Keymaps para Codeium (Sin conflictos con Avante)

## 🚨 Problema Identificado

**Conflicto**: `<C-s>` está siendo usado por ambos:

- **Codeium**: Aceptar sugerencia
- **Avante**: Enviar prompt en modo insert

## ✅ Solución Implementada

He actualizado la configuración de Codeium con keymaps que no tienen conflictos:

### Nuevos Keymaps de Codeium:

| Comando                  | Keymap  | Descripción                                     |
| ------------------------ | ------- | ----------------------------------------------- |
| **Aceptar sugerencia**   | `<Tab>` | ⭐ **RECOMENDADO** - Estándar en autocompletado |
| **Siguiente sugerencia** | `<C-;>` | Navegar a la siguiente opción                   |
| **Sugerencia anterior**  | `<C-,>` | Navegar a la opción anterior                    |
| **Limpiar sugerencias**  | `<C-x>` | Eliminar sugerencias actuales                   |

## 🎯 Alternativas Recomendadas

### Opción 1: `<Tab>` (IMPLEMENTADO)

```lua
vim.keymap.set("i", "<Tab>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
```

**✅ Ventajas**: Estándar universal, intuitivo, usado en VSCode/otros IDEs

### Opción 2: `<C-y>` (Alternativa popular)

```lua
vim.keymap.set("i", "<C-y>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
```

**✅ Ventajas**: Usado en nvim-cmp por defecto, no conflicta

### Opción 3: `<C-l>` (Alternativa limpia)

```lua
vim.keymap.set("i", "<C-l>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
```

**✅ Ventajas**: Fácil de recordar (l = accept), ergonómico

### Opción 4: `<C-g>` (Default de Codeium)

```lua
vim.keymap.set("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
```

**✅ Ventajas**: Default oficial de Codeium

## 🔄 Si Quieres Cambiar

### Para cambiar a `<C-y>`:

```lua
-- En lua/r4k4210/plugins/codeium.lua, cambiar:
vim.keymap.set("i", "<C-y>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, desc = "Codeium: Accept suggestion" })
```

### Para cambiar a `<C-l>`:

```lua
-- En lua/r4k4210/plugins/codeium.lua, cambiar:
vim.keymap.set("i", "<C-l>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, desc = "Codeium: Accept suggestion" })
```

## 🚫 Keymaps a Evitar (Conflictos conocidos)

| Keymap        | Usado por | Razón                         |
| ------------- | --------- | ----------------------------- |
| `<C-s>`       | Avante    | Enviar prompt en insert mode  |
| `<C-c>`       | Vim       | Escape/Cancel                 |
| `<C-[>`       | Vim       | Escape alternativo            |
| `<C-o>`       | Vim       | Comando normal en insert mode |
| `<C-w>`       | Vim       | Window commands               |
| `<C-n>/<C-p>` | nvim-cmp  | Navegación de completado      |

## 🎮 Flujo de Trabajo Recomendado

1. **Escribes código** → Codeium muestra sugerencia
2. **`<Tab>`** → Aceptar sugerencia completa
3. **`<C-;>`** → Ver siguiente opción si no te gusta
4. **`<C-,>`** → Volver a opción anterior
5. **`<C-x>`** → Limpiar si no quieres ninguna

## 💡 Tips de Uso

### Para maximizar eficiencia:

- **`<Tab>`** es el más rápido para aceptar
- **`<C-;>`** y **`<C-,>`** son ergonómicos para navegar
- **`<C-x>`** útil cuando Codeium es demasiado agresivo

### Compatibilidad con nvim-cmp:

- La configuración actual no interfiere con nvim-cmp
- `<Tab>` funcionará para Codeium cuando hay sugerencias
- nvim-cmp seguirá funcionando normalmente

## 🔧 Configuración Actual Completa

```lua
return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    -- Codeium keymaps (sin conflictos con Avante)
    vim.keymap.set("i", "<Tab>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, desc = "Codeium: Accept suggestion" })

    vim.keymap.set("i", "<C-;>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, desc = "Codeium: Next suggestion" })

    vim.keymap.set("i", "<C-,>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, desc = "Codeium: Previous suggestion" })

    vim.keymap.set("i", "<C-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, desc = "Codeium: Clear suggestions" })
  end,
}
```

## ✅ Verificación

Después de reiniciar Neovim:

- **Codeium**: `<Tab>` para aceptar sugerencias
- **Avante**: `<C-s>` para enviar prompts (sin conflicto)
- Todo debería funcionar sin problemas

---

**Recomendación final**: `<Tab>` es la mejor opción porque es estándar, intuitivo y no conflicta con ninguna funcionalidad existente.
