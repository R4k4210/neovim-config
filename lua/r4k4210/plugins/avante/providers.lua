return {
  ["openrouter-gpt5"] = {
    __inherited_from = "openai",
    endpoint = "https://openrouter.ai/api/v1",
    api_key_name = "OPENROUTER_API_KEY",
    model = "openai/gpt-5-mini",
    max_tokens = 8192,
    timeout = 30000,
  },
  ["claudio-sonnet-4.5"] = {
    __inherited_from = "openai",
    endpoint = "https://openrouter.ai/api/v1",
    api_key_name = "OPENROUTER_API_KEY",
    model = "anthropic/claude-sonnet-4.5",
    max_tokens = 8192,
    timeout = 30000,
  },
  ["claudio-opus-4.5"] = {
    __inherited_from = "openai",
    endpoint = "https://openrouter.ai/api/v1",
    api_key_name = "OPENROUTER_API_KEY",
    model = "anthropic/claude-opus-4.5",
    max_tokens = 8192,
    timeout = 30000,
  },
}
