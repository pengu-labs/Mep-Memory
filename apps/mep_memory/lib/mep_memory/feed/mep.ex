defmodule MepMemory.Feed.Mep do
  import SweetXml
  alias MepMemory.Repo

  @mep_list_base_url "http://www.europarl.europa.eu/meps/en/odp/detailed-list-xml/"

  def save_all_meps do
    {:ok, _} = Application.ensure_all_started(:inets)
    {:ok, _} = Application.ensure_all_started(:ssl)

    fetch_meps()
  end

  defp fetch_meps do
    Enum.each(
      ?a..?z,
      fn c ->
        {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}} =
          :httpc.request(:get, {to_charlist(@mep_list_base_url <> <<c::utf8>>), []}, [], [])

        parse_mep_document(to_string(:erlang.list_to_binary(body))).results
        |> Enum.each(fn mep ->
          insert_mep(mep)
        end)
      end
    )
  end

  defp parse_mep_document(content) do
    content
    |> xmap(
      results: [
        ~x"//meps/mep"l,
        mep_id: ~x"./id/text()"i,
        full_name: ~x"./fullName/text()"s,
        country_code: ~x"./country/@countryCode"s,
        political_group_code: ~x"./politicalGroup/@bodyCode"s,
        national_political_group_code: ~x"./nationalPoliticalGroup/@bodyCode"s,
        birth_date: ~x"./birthDate/text()"s,
        birth_place: ~x"./birthPlace/text()"s,
        contacts: [~x"./eContact"l, type: ~x"./@type"s, contact: ~x"./text()"s]
      ]
    )
  end

  defp insert_mep(mep) do
    {:ok, mep_model} =
      case Repo.get_by(MepMemory.Mep, mep_id: mep.mep_id) do
        nil -> %MepMemory.Mep{mep_id: mep.mep_id}
        m -> m
      end
      |> MepMemory.Mep.changeset(mep)
      |> Repo.insert_or_update()

    insert_contacts(mep_model, mep)
    MepMemory.Feed.SocialMedia.save_follower(mep_model.mep_id)
  end

  defp insert_contacts(mep, mep_data) do
    Enum.each(mep_data.contacts, fn contact ->
      case Repo.get_by(MepMemory.MepContact, mep_id: mep.id, type: contact.type) do
        nil -> Ecto.build_assoc(mep, :mep_contacts)
        c -> c
      end
      |> Ecto.Changeset.change(contact)
      |> Repo.insert_or_update()
    end)
  end
end
