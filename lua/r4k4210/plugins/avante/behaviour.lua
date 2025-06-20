return {
  auto_suggestions = false, -- Experimental feature
  auto_set_highlight_group = true,
  auto_set_keymaps = true,
  auto_apply_diff_after_generation = false,
  support_paste_from_clipboard = false,
  minimize_diff = true, -- Removes unchanged lines when applying a code block
  enable_token_counting = false, -- Enables token counting (default: true) | Esto previene que ande lento al escribir
  enable_cursor_planning_mode = true, -- Habilitar Cursor Planning Mode para mejor compatibilidad
  auto_approve_tool_permissions = false, -- Mostrar prompts de permisos para herramientas
  streaming = false, -- CRÍTICO: Deshabilitar streaming para evitar crashes con OpenRouter
}
