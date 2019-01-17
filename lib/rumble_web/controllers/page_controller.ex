defmodule RumbleWeb.PageController do
  use RumbleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
