defmodule Mix.Tasks.ImportMeps do
  use Mix.Task

  @shortdoc "Download all available meps and save them into the database"
  def run(_) do
    Mix.EctoSQL.ensure_started(MepMemory.Repo, [])
    MepMemory.Feed.Mep.save_all_meps()
  end
end
