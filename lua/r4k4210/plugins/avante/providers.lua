return {
  copilot = false,
  openrouter = {
    __inherited_from = "openai",
    endpoint = "https://openrouter.ai/api/v1",
    api_key_name = "OPENROUTER_API_KEY",
    model = "anthropic/claude-sonnet-4",
    -- Optimized configurations to prevent double responses
    timeout = 30000, -- Reduced timeout to prevent response delays
    max_tokens = 4096, -- Reduced token limit to prevent overly long responses
    -- temperature = 0.7, -- Add temperature control for consistent responses
    -- Disable tools that might conflict with MCP
    -- disabled_tools = { "bash", "python", "read_file", "write_file" },
  },
}
