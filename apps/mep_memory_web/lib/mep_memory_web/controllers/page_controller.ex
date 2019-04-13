defmodule MepMemoryWeb.PageController do
  use MepMemoryWeb, :controller

  def index(conn, %{"order" => "followers"}) do
    render(conn, "index.html", meps: MepMemory.list_meps() |> sort_by_followers |> Enum.take(50))
  end

  def index(conn, %{"order" => "likes"}) do
    render(conn, "index.html", meps: MepMemory.list_meps() |> sort_by_likes |> Enum.take(50))
  end

  def index(conn, _params) do
    render(conn, "index.html", meps: MepMemory.list_meps() |> Enum.take_random(50))
  end

  defp sort_by_followers(meps) do
    Enum.sort(meps, fn a, b ->
      aggregate_key(a.mep_contacts, :followers) >= aggregate_key(b.mep_contacts, :followers)
    end)
  end

  defp sort_by_likes(meps) do
    Enum.sort(meps, fn a, b ->
      aggregate_key(a.mep_contacts, :likes) >= aggregate_key(b.mep_contacts, :likes)
    end)
  end

  defp aggregate_key(contacts, key) do
    Enum.reduce(contacts, 0, fn contact, acc ->
      v =
        case Map.get(contact, key) do
          nil -> 0
          c -> c
        end

      acc + v
    end)
  end
end
