defmodule Rumble.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Rumble.Repo
  alias Rumble.Accounts.User

  @doc """
  Returns a list of all of our users.
  """
  def list_users, do: Repo.all(User)

  @doc """
  Returns a user with the ID that is passed in.
  """
  def get_user(id), do: Repo.get(User, id)
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Returns a user with the params that are passed in.
  """
  def get_user_by(params), do: Repo.get_by(User, params)
  def get_user_by!(params), do: Repo.get_by!(User, params)
end
