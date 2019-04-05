defmodule MepMemory.Repo.Migrations.CreateMepContacts do
  use Ecto.Migration

  def change do
    create table(:mep_contacts) do
      add :type, :string
      add :contact, :string
      add :mep_id, references(:meps, on_delete: :nothing)

      timestamps()
    end

    create index(:mep_contacts, [:mep_id])
    create unique_index(:mep_contacts, [:mep_id, :type])
  end
end
