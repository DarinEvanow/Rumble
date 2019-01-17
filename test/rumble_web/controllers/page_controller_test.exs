defmodule RumbleWeb.PageControllerTest do
  use RumbleWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Rumble.io!"
  end
end
