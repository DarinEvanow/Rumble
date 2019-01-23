defmodule RumbleWeb.VideoViewTest do
  use RumbleWeb.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    videos = [
      %Rumble.Multimedia.Video{id: "1", title: "dogs"},
      %Rumble.Multimedia.Video{id: "1", title: "cats"},
    ]

    content = render_to_string(RumbleWeb.VideoView, "index.html", conn: conn, videos: videos)

    assert String.contains?(content, "Listing Videos")

    for video <- videos do
      assert String.contains?(content, video.title)
    end
  end

  test "renders new.html", %{conn: conn} do
    owner = %Rumble.Accounts.User{}
    changeset = Rumble.Multimedia.change_video(owner, %Rumble.Multimedia.Video{})
    categories = [%Rumble.Multimedia.Category{id: 123, name: "cats"}]

    content =
      render_to_string(RumbleWeb.VideoView, "new.html",
        conn: conn,
        changeset: changeset,
        categories: categories
      )

    assert String.contains?(content, "New Video")
  end
end
