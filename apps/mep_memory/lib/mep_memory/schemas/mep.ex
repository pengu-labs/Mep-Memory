defmodule MepMemory.Mep do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meps" do
    field :country_code, :string
    field :full_name, :string
    field :mep_id, :integer
    field :national_political_group_code, :string
    field :political_group_code, :string

    timestamps()

    has_many :mep_contacts, MepMemory.MepContact
  end

  @doc false
  def changeset(mep, attrs) do
    mep
    |> cast(attrs, [
      :full_name,
      :country_code,
      :political_group_code,
      :national_political_group_code,
      :mep_id
    ])
    |> validate_required([
      :full_name,
      :country_code,
      :political_group_code,
      :national_political_group_code,
      :mep_id
    ])
  end
end
