# Since configuration is shared in umbrella projects, this file
# should only configure the :mep_memory application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :mep_memory,
  ecto_repos: [MepMemory.Repo]

import_config "#{Mix.env()}.exs"
