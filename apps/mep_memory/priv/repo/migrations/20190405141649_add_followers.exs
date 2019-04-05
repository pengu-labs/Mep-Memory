defmodule MepMemory.Repo.Migrations.AddFollowers do
  use Ecto.Migration

  def change do
    alter table(:mep_contacts) do
      add :followers, :integer
      add :likes, :integer
    end
  end
end
