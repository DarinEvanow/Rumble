defmodule Rumble.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Rumble.Accounts.User

  @doc """
  Returns a list of all of our users.

  ## Examples
    iex> Rumble.Accounts.list_users()
    [
      %Rumble.Accounts.User{id: "1", name: "Darin", username: "darin-evanow"},
      %Rumble.Accounts.User{id: "2", name: "Marina", username: "marina-nattinger"},
      %Rumble.Accounts.User{id: "3", name: "Grant", username: "grant-ivison-lane"}
    ]
  """
  def list_users do
    [
      %User{id: "1", name: "Darin", username: "darin-evanow"},
      %User{id: "2", name: "Marina", username: "marina-nattinger"},
      %User{id: "3", name: "Grant", username: "grant-ivison-lane"}
    ]
  end

  @doc """
  Returns a user with the ID that is passed in.

  ## Examples
    iex> Rumble.Accounts.get_user("3")
    %Rumble.Accounts.User{id: "3", name: "Grant", username: "grant-ivison-lane"}

    iex> Rumble.Accounts.get_user("4")
    nil
  """
  def get_user(id) do
    Enum.find(list_users(), fn map -> map.id == id end)
  end

  @doc """
  Returns a user with the params that are passed in.

  ## Examples
    iex> Rumble.Accounts.get_user_by(name: "Darin")
    %Rumble.Accounts.User{id: "1", name: "Darin", username: "darin-evanow"}
  """
  def get_user_by(params) do
    Enum.find(list_users(), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end)
  end
end
