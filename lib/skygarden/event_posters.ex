defmodule Skygarden.EventPosters do
  @moduledoc """
  The EventPosters context.
  """

  import Ecto.Query, warn: false
  alias Skygarden.Repo

  alias Skygarden.EventPosters.EventPoster

  @doc """
  Returns the list of event_posters.

  ## Examples

      iex> list_event_posters()
      [%EventPoster{}, ...]

  """
  def list_event_posters do
    Repo.all(EventPoster)
  end

  @doc """
  Returns the list of event_posters.

  ## Examples

      iex> list_event_posters()
      [%EventPoster{}, ...]

  """

  def list_event_posters_for_event(event_id)do
    Repo.all(
      from ep in EventPoster,
        where: ep.event_id == ^event_id
    )
    
  end

  @doc """
  Gets a single event_poster.

  Raises `Ecto.NoResultsError` if the Event poster does not exist.

  ## Examples

      iex> get_event_poster!(123)
      %EventPoster{}

      iex> get_event_poster!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event_poster!(id), do: Repo.get!(EventPoster, id)

  @doc """
  Creates a event_poster.

  ## Examples

      iex> create_event_poster(%{field: value})
      {:ok, %EventPoster{}}

      iex> create_event_poster(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event_poster(attrs \\ %{}) do
    %EventPoster{}
    |> EventPoster.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event_poster.

  ## Examples

      iex> update_event_poster(event_poster, %{field: new_value})
      {:ok, %EventPoster{}}

      iex> update_event_poster(event_poster, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event_poster(%EventPoster{} = event_poster, attrs) do
    event_poster
    |> EventPoster.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event_poster.

  ## Examples

      iex> delete_event_poster(event_poster)
      {:ok, %EventPoster{}}

      iex> delete_event_poster(event_poster)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event_poster(%EventPoster{} = event_poster) do
    Repo.delete(event_poster)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event_poster changes.

  ## Examples

      iex> change_event_poster(event_poster)
      %Ecto.Changeset{data: %EventPoster{}}

  """
  def change_event_poster(%EventPoster{} = event_poster, attrs \\ %{}) do
    EventPoster.changeset(event_poster, attrs)
  end
end
