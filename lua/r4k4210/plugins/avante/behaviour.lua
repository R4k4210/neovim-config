return {
  auto_suggestions = false, -- Experimental feature
  auto_set_highlight_group = true,
  auto_set_keymaps = true,
  auto_apply_diff_after_generation = false,
  support_paste_from_clipboard = false,
  minimize_diff = true, -- Removes unchanged lines when applying a code block
  enable_token_counting = false, -- Prevents slowness while typing
  enable_cursor_planning_mode = false, -- Disable to prevent conflicts with MCP
  auto_approve_tool_permissions = false, -- Show permission prompts for tools
  streaming = false, -- CRITICAL: Disable streaming to prevent crashes and double responses
  -- Additional settings to prevent double responses
  debounce_delay = 800, -- Increase debounce to prevent rapid-fire requests
  response_timeout = 25000, -- Shorter timeout to prevent hanging responses
}
