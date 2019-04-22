defmodule MepMemory.Game.MemoryTest do
  use MepMemory.DataCase, async: true
  alias MepMemory.Game.Memory

  test "hide all meps" do
    meps = [%{}, %{}]
    assert Memory.hide_all(meps) == [%{revealed: false}, %{revealed: false}]
  end

  test "toggle mep" do
    meps = [%{position: 1, revealed: false}, %{position: 2, revealed: false}]

    assert Memory.toggle_mep(meps, 1) == [
             %{position: 1, revealed: true},
             %{position: 2, revealed: false}
           ]
  end
end
