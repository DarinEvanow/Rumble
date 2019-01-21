defmodule Rumble.Multimedia do
  @moduledoc """
  The Multimedia context.
  """

  import Ecto.Query, warn: false
  alias Rumble.Repo

  alias Rumble.Multimedia.Video
  alias Rumble.Accounts

  @doc """
  Returns the list of videos.

  ## Examples

      iex> list_videos()
      [%Video{}, ...]

  """
  def list_videos do
    Video
    |> Repo.all()
    |> preload_user()
  end

  @doc """
  Gets a single video.

  Raises `Ecto.NoResultsError` if the Video does not exist.

  ## Examples

      iex> get_video!(123)
      %Video{}

      iex> get_video!(456)
      ** (Ecto.NoResultsError)

  """
  def get_video!(id) do
    Video
    |> Repo.get!(id)
    |> preload_user()
  end

  @doc """
  Creates a video.

  ## Examples

      iex> create_video(%{field: value})
      {:ok, %Video{}}

      iex> create_video(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_video(%Accounts.User{} = user, attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> put_user(user)
    |> Repo.insert()
  end

  @doc """
  Updates a video.

  ## Examples

      iex> update_video(video, %{field: new_value})
      {:ok, %Video{}}

      iex> update_video(video, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Video.

  ## Examples

      iex> delete_video(video)
      {:ok, %Video{}}

      iex> delete_video(video)
      {:error, %Ecto.Changeset{}}

  """
  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking video changes.

  ## Examples

      iex> change_video(video)
      %Ecto.Changeset{source: %Video{}}

  """
  def change_video(%Accounts.User{} = user, %Video{} = video) do
    video
    |> Video.changeset(%{})
    |> put_user(user)
  end

  @doc """
  Returns all of the videos associated with a user
  """
  def list_user_videos(%Accounts.User{} = user) do
    Video
    |> user_videos_query(user)
    |> Repo.all()
    |> preload_user()
  end

  @doc """
  Returns a specific user video by ID
  """
  def get_user_video!(%Accounts.User{} = user, id) do
    from(v in Video, where: v.id == ^id)
    |> user_videos_query(user)
    |> Repo.one!()
    |> preload_user()
  end

  # Helper function to encapsulate querying all the videos of a user
  defp user_videos_query(query, %Accounts.User{id: user_id}) do
    from(v in query, where: v.user_id == ^user_id)
  end

  # Helper function to use our user association as a change into the change changeset
  defp put_user(changeset, user) do
    Ecto.Changeset.put_assoc(changeset, :user, user)
  end

  # Helper function to make sure our Multimedia context always has knowledge
  # of our Accounts.User relationship
  defp preload_user(video_or_videos) do
    Repo.preload(video_or_videos, :user)
  end
end