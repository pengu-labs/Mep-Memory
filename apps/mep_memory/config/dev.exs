# Since configuration is shared in umbrella projects, this file
# should only configure the :mep_memory application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :mep_memory, MepMemory.Repo,
  username: "postgres",
  password: "postgres",
  database: "mep_memory_dev",
  hostname: "localhost",
  pool_size: 10
