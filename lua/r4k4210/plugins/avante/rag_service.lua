return {
  enabled = false, -- Habilitar el servicio RAG
  host_mount = os.getenv("HOME"), -- Ruta de montaje del host para el servicio RAG
  runner = "docker", -- Runner para el servicio RAG (docker o nix)
  llm = {
    provider = "openrouter",
    endpoint = "https://openrouter.ai/api/v1",
    api_key_name = "OPENROUTER_API_KEY",
    model = "anthropic/claude-3-sonnet",
  },
  embed = {
    provider = "openai",
    endpoint = "https://api.openai.com/v1",
    api_key_name = "OPENAI_API_KEY",
    model = "text-embedding-3-large",
  },
  docker_extra_args = "", -- Argumentos extra para el comando docker
}
