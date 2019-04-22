defmodule MepMemoryWeb.MemoryGameView do
  use Phoenix.LiveView
  alias MepMemory.Game.Memory

  def render(assigns) do
    MepMemoryWeb.PageView.render("memory_game.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, :game, Memory.init_game())}
  end

  def handle_event("toggle_card", position, socket) do
    {:noreply, update(socket, :game, fn game -> Memory.toggle_mep(game, position) end)}
  end

  def handle_event("close_dialog", _, socket) do
    {:noreply, update(socket, :game, fn game -> Memory.clear_matched(game) end)}
  end
end
