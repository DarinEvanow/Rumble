defmodule RumbleWeb.WatchController do
  use RumbleWeb, :controller

  alias Rumble.Multimedia

  def show(conn, %{"id" => id}) do
    video = Multimedia.get_video!(id)
    render(conn, "show.html", video: video)
  end
end
