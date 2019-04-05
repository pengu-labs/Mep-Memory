defmodule MepMemoryWeb.PageController do
  use MepMemoryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", meps: MepMemory.list_meps() |> Enum.take_random(50))
  end
end
