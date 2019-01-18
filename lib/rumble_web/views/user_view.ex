defmodule RumbleWeb.UserView do
  use RumbleWeb, :view

  alias Rumble.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
