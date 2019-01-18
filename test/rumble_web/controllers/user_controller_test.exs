defmodule RumbleWeb.UserControllerTest do
  use RumbleWeb.ConnCase

  test "GET /users", %{conn: conn} do
    conn = get(conn, "/users")
    assert html_response(conn, 200) =~ "Listing Users"
  end

  test "GET /users/:id", %{conn: conn} do
    conn = get(conn, "/users/1")
    assert html_response(conn, 200) =~ "Showing User"
    assert html_response(conn, 200) =~ "Darin"
  end
end
