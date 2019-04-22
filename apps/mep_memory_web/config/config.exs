# Since configuration is shared in umbrella projects, this file
# should only configure the :mep_memory_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :mep_memory_web,
  ecto_repos: [MepMemory.Repo],
  generators: [context_app: :mep_memory]

# Configures the endpoint
config :mep_memory_web, MepMemoryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MesBMS796u9ym7zCWsOq8chmCsE9X8DA3qrNjKpnwZ8ayuSDAslNBdazcP9f4BIh",
  render_errors: [view: MepMemoryWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MepMemoryWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "pM6BE8ufqBtfYRhwkR8/ikP1B61EPDJLStpBS7mVW9ZvLMiCqQg0/pQc/iPPyv2N"]

# render liveview templates
config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
