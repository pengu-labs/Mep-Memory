defmodule MepMemory.Game.Memory do
  def init_game() do
    meps = MepMemory.list_meps() |> Enum.take_random(5)

    meps =
      Enum.shuffle(meps ++ meps)
      |> build_cards()
      |> hide_all()

    %MepMemory.Game{meps: meps}
  end

  def clear_matched(game), do: %{game | matched_pair: nil}

  def hide_all(meps) do
    Enum.map(meps, fn mep ->
      %{mep | revealed: revealed?(mep), selected: false}
    end)
  end

  def toggle_mep(%{meps: meps} = game, position) do
    position = String.to_integer(position)
    selected = selected_mep(meps)
    toggled = toggled_mep(meps, position)
    meps = toggle(meps, position)

    {meps, matched_pair} =
      if revealed_meps(meps) > 2 do
        {hide_all(meps) |> toggle(position), nil}
      else
        if has_match?(toggled, selected) do
          {mark_matched(meps, toggled.mep_id), toggled}
        else
          {meps, nil}
        end
      end

    %{game | meps: meps, matched_pair: matched_pair}
  end

  defp build_cards(meps) do
    Enum.reduce(meps, [], fn mep, acc ->
      acc ++
        [
          %{
            position: length(acc),
            mep_id: mep.mep_id,
            full_name: mep.full_name,
            revealed: false,
            has_match: false,
            selected: false
          }
        ]
    end)
  end

  defp toggle(meps, position) do
    Enum.map(meps, fn mep ->
      if mep.position == position do
        %{mep | revealed: true, selected: true}
      else
        mep
      end
    end)
  end

  defp has_match?(_toggled, nil), do: false
  defp has_match?(toggled, selected), do: toggled.mep_id == selected.mep_id

  defp mark_matched(meps, mep_id) do
    Enum.map(meps, fn mep ->
      %{mep | has_match: mep.has_match || mep.mep_id == mep_id, selected: false}
    end)
  end

  defp selected_mep(meps) do
    Enum.find(meps, fn mep -> mep.selected end)
  end

  defp toggled_mep(meps, position) do
    Enum.find(meps, fn mep -> mep.position == position end)
  end

  defp revealed?(mep) do
    if mep.has_match do
      true
    else
      false
    end
  end

  defp revealed_meps(meps) do
    Enum.count(meps, fn mep -> mep.revealed && !mep.has_match end)
  end
end
