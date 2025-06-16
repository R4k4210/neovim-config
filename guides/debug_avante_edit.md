# Debug: Avante Edit Mode No Funciona

Esta guía te ayudará a diagnosticar por qué el modo de editar de Avante no está funcionando.

## 🔍 Posibles Causas y Soluciones

### 1. **Problema con la Selección de Texto**

#### ✅ Verificar:
- ¿Tienes texto seleccionado en modo visual antes de ejecutar `:AvanteEdit`?
- ¿El texto seleccionado es código válido?

#### 🧪 Test:
1. Abre un archivo con código
2. Entra en modo visual (`v` o `V`)
3. Selecciona unas líneas de código
4. Ejecuta `:AvanteEdit`

### 2. **Problema con el Template de Editing**

#### ✅ Verificar template:
```bash
cat ~/.config/nvim/lua/r4k4210/llm/templates/editing.jinja
```

#### 🔧 El template debe contener:
- Variable `{{ selection }}` para el código seleccionado
- Instrucciones claras para el AI
- Formato Jinja válido

### 3. **Problema con la Configuración de Avante**

#### ✅ Verificar configuración:
```vim
:lua print(vim.inspect(require('avante.config').get()))
```

#### 🔧 Configuraciones importantes:
- `template_dir` debe apuntar al directorio correcto
- `provider` debe estar configurado correctamente
- `behaviour.auto_set_keymaps` debe estar en `true`

### 4. **Problema con Keymaps/Comandos**

#### ✅ Verificar comandos disponibles:
```vim
:command Avante
```

#### 🧪 Comandos alternativos a probar:
- `:AvanteEdit` (comando principal)
- `:lua require('avante').edit()` (llamada directa)
- `<leader>ae` (si está configurado)

### 5. **Problema con el Provider**

#### ✅ Verificar API key:
```bash
echo $OPENROUTER_API_KEY
```

#### 🔧 El API key debe:
- Estar configurado en tu shell
- Ser válido y tener créditos
- Tener permisos para el modelo configurado

### 6. **Problema con Dependencies**

#### ✅ Verificar plugins instalados:
```vim
:Lazy health avante
```

#### 🔧 Dependencies requeridas:
- `dressing.nvim` - Para UI
- `plenary.nvim` - Funciones Lua
- `nui.nvim` - Componentes UI

## 🧪 Tests Paso a Paso

### Test 1: Verificación Básica
```vim
" 1. Abrir archivo de test
:e test.js

" 2. Escribir código simple
console.log("hello world");

" 3. Seleccionar línea completa
V

" 4. Intentar editar
:AvanteEdit
```

### Test 2: Verificación de Template
```vim
" Verificar que el template sea encontrado
:lua print(require('avante.config').get().template_dir)
```

### Test 3: Verificación de Provider
```vim
" Test de conexión básica
:AvanteAsk "Hello, can you respond?"
```

## 🔧 Soluciones Comunes

### Solución 1: Reiniciar Configuración
```vim
" Recargar configuración de Avante
:lua require('avante').setup()

" O reiniciar Neovim completamente
```

### Solución 2: Verificar Selección
```vim
" Usar modo visual línea completa
V
" Seleccionar código
j j j
" Ejecutar comando
:AvanteEdit
```

### Solución 3: Comando Alternativo
```vim
" Si :AvanteEdit no funciona, probar:
:lua require('avante.api').edit()
```

### Solución 4: Debug Mode
```vim
" Habilitar mensajes de debug
:set verbose=1
:AvanteEdit
:messages
```

## 🚨 Errores Comunes y Sus Mensajes

### Error: "No text selected"
**Causa**: No hay texto seleccionado en modo visual
**Solución**: Selecciona texto con `v` o `V` antes de ejecutar

### Error: "Template not found"
**Causa**: El archivo `editing.jinja` no existe o no se encuentra
**Solución**: Verificar que el archivo existe en el directorio correcto

### Error: "Provider error" o "API error"
**Causa**: Problema con el proveedor de AI (API key, créditos, etc.)
**Solución**: Verificar configuración del provider y API key

### Error: "Command not found"
**Causa**: Avante no está cargado correctamente
**Solución**: Verificar instalación y configuración del plugin

## 📋 Checklist de Verificación

- [ ] Texto seleccionado en modo visual
- [ ] Template `editing.jinja` existe y es válido
- [ ] API key configurado y válido
- [ ] Provider configurado correctamente
- [ ] Dependencies instaladas
- [ ] Comandos de Avante disponibles
- [ ] No hay errores en `:messages`

## 🆘 Si Nada Funciona

1. **Reinstalar Avante**:
   ```vim
   :Lazy clean avante.nvim
   :Lazy install avante.nvim
   ```

2. **Verificar logs**:
   ```vim
   :messages
   :lua print(vim.inspect(require('avante')))
   ```

3. **Usar modo debug**:
   ```vim
   :lua vim.g.avante_debug = true
   ```

4. **Test con archivo simple**:
   - Crear archivo nuevo con código básico
   - Seleccionar todo el código
   - Intentar `:AvanteEdit`

---

**Próximo paso**: Ejecuta el script de diagnóstico automático para identificar el problema específico.

