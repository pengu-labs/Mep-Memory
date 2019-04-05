defmodule MepMemory.Repo do
  use Ecto.Repo,
    otp_app: :mep_memory,
    adapter: Ecto.Adapters.Postgres
end
