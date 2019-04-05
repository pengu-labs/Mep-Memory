defmodule MepMemory.Feed.SocialMedia do
  alias MepMemory.Repo

  def save_follower(mep_id) do
    mep = Repo.get_by(MepMemory.Mep, mep_id: mep_id) |> Repo.preload(:mep_contacts)

    Enum.each(mep.mep_contacts, fn contact ->
      fetch_follower(contact)
    end)
  end

  defp fetch_follower(%{type: "Twitter Profile", contact: contact} = mep_contact) do
    case request(contact) do
      nil ->
        nil

      body ->
        follower_count =
          Floki.find(to_string(body), "a[data-nav=followers] .ProfileNav-value")
          |> Floki.attribute("data-count")

        likes =
          Floki.find(to_string(body), "a[data-nav=favorites] .ProfileNav-value")
          |> Floki.attribute("data-count")

        MepMemory.MepContact.changeset(mep_contact, %{
          followers: Enum.at(follower_count, 0, 0),
          likes: Enum.at(likes, 0, 0)
        })
        |> Repo.update()
    end
  end

  defp fetch_follower(_) do
  end

  defp request(url) do
    try do
      case :httpc.request(:get, {to_charlist(url), []}, [], []) do
        {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}} -> to_string(body)
        {:error, _} -> nil
      end
    rescue
      _ -> nil
    end
  end
end
