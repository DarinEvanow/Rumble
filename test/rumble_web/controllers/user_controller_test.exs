defmodule RumbleWeb.UserControllerTest do
  use RumbleWeb.ConnCase

  test "GET /users", %{conn: conn} do
    conn = get(conn, "/users")
    assert html_response(conn, 200) =~ "Listing Users"
  end
end
