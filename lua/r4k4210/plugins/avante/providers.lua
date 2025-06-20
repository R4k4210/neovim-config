return {
  copilot = false,
  openrouter = {
    __inherited_from = "openai",
    endpoint = "https://openrouter.ai/api/v1",
    api_key_name = "OPENROUTER_API_KEY",
    model = "anthropic/claude-sonnet-4",
    -- Configuraciones específicas para evitar problemas con edit mode
    timeout = 60000, -- Timeout más largo para edit mode
    max_tokens = 8192, -- Límite de tokens para evitar respuestas muy largas
    -- Tools específicamente habilitadas para edit mode
    -- disabled_tools = {}, -- Mantener todas las herramientas habilitadas
  },
}
