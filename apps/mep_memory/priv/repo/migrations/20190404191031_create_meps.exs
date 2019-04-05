defmodule MepMemory.Repo.Migrations.CreateMeps do
  use Ecto.Migration

  def change do
    create table(:meps) do
      add :full_name, :string
      add :country_code, :string
      add :political_group_code, :string
      add :national_political_group_code, :string
      add :mep_id, :integer

      timestamps()
    end

    create unique_index(:meps, [:mep_id])
  end
end
