defmodule MepMemory do
  alias MepMemory.Repo

  import MepMemory.Feed.SocialMediaTypes

  def list_meps do
    Repo.all(MepMemory.Mep)
    |> Repo.preload(:mep_contacts)
  end

  def twitter_contact(mep) do
    Enum.filter(mep.mep_contacts, fn contact -> contact.type === twitter() end)
    |> Enum.at(0)
  end
end
