return {
  auto_suggestions = false, -- Experimental feature
  auto_set_highlight_group = true,
  auto_set_keymaps = true,
  auto_apply_diff_after_generation = false,
  support_paste_from_clipboard = false,
  minimize_diff = true, -- Removes unchanged lines when applying a code block
  enable_token_counting = true, -- Helpful for monitoring usage
  enable_cursor_planning_mode = false, -- Disable to prevent conflicts with MCP
  auto_approve_tool_permissions = false, -- Show permission prompts for tools
  streaming = true, -- Better UX with real-time responses
  debounce_delay = 400, -- More responsive delay
  response_timeout = 30000, -- Match provider timeout
}
