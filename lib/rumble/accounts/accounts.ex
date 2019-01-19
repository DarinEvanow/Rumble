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

  @doc """
  Serves as the public API call to change a User using the changeset defined in User, which
  will be used in our form to hold new user data before submission
  """
  def change_user(%User{} = user), do: User.changeset(user, %{})

  @doc """
  Serves as the public API call to create a User using the changeset defined in User, which
  will be used in our form to insert the new user data after submission
  """
  def create_user(attrs \\ %{}) do
    %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
  end
end
