defmodule MepMemory.MepContact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mep_contacts" do
    field :contact, :string
    field :type, :string
    field :followers, :integer
    field :likes, :integer

    timestamps()

    belongs_to :mep, MepMemory.Mep
  end

  @doc false
  def changeset(mep_contact, attrs) do
    mep_contact
    |> cast(attrs, [:type, :contact, :followers, :likes])
    |> validate_required([:type, :contact])
  end
end
