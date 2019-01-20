defmodule Rumble.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query

  alias Rumble.Repo
  alias Rumble.Accounts.User
  alias Rumble.Accounts.Credential

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

  @doc """
  Serves as the public API call to register a user through our web interface
  """
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

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
  Returns a user that contains the given email, and preloads the Credential
  associated if they are found.
  """
  def get_user_by_email(email) do
    from(u in User, join: c in assoc(u, :credential), where: c.email == ^email)
    |> Repo.one()
    |> Repo.preload(:credential)
  end

  @doc """
  Used to check if the email and password combination given is valid. If it is
  not, we use Comeonin to simulate a password check, to help prevent timing
  attacks
  """
  def authenticate_by_email_and_pass(email, given_pass) do
    user = get_user_by_email(email)

    cond do
      user && Comeonin.Pbkdf2.check_pass(given_pass, user.credential.password) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Comeonin.Bcrypt.dummy_checkpw()
        {:error, :not_found}
    end
  end

  @doc """
  Returns the list of credentials.

  ## Examples

      iex> list_credentials()
      [%Credential{}, ...]

  """
  def list_credentials do
    Repo.all(Credential)
  end

  @doc """
  Gets a single credential.

  Raises `Ecto.NoResultsError` if the Credential does not exist.

  ## Examples

      iex> get_credential!(123)
      %Credential{}

      iex> get_credential!(456)
      ** (Ecto.NoResultsError)

  """
  def get_credential!(id), do: Repo.get!(Credential, id)

  @doc """
  Creates a credential.

  ## Examples

      iex> create_credential(%{field: value})
      {:ok, %Credential{}}

      iex> create_credential(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a credential.

  ## Examples

      iex> update_credential(credential, %{field: new_value})
      {:ok, %Credential{}}

      iex> update_credential(credential, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_credential(%Credential{} = credential, attrs) do
    credential
    |> Credential.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Credential.

  ## Examples

      iex> delete_credential(credential)
      {:ok, %Credential{}}

      iex> delete_credential(credential)
      {:error, %Ecto.Changeset{}}

  """
  def delete_credential(%Credential{} = credential) do
    Repo.delete(credential)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking credential changes.

  ## Examples

      iex> change_credential(credential)
      %Ecto.Changeset{source: %Credential{}}

  """
  def change_credential(%Credential{} = credential) do
    Credential.changeset(credential, %{})
  end
end
