defmodule Skygarden.EventUsers do
  @moduledoc """
  The EventUsers context.
  """

  import Ecto.Query, warn: false
  alias Skygarden.Repo

  alias Skygarden.EventUsers.EventUser

  @doc """
  Returns the list of event_users.

  ## Examples

      iex> list_event_users()
      [%EventUser{}, ...]

  """
  def list_event_users do
    Repo.all(EventUser)
  end

  @doc """
  Gets a single event_user.

  Raises `Ecto.NoResultsError` if the Event user does not exist.

  ## Examples

      iex> get_event_user!(123)
      %EventUser{}

      iex> get_event_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event_user!(id), do: Repo.get!(EventUser, id)

  @doc """
  Creates a event_user.

  ## Examples

      iex> create_event_user(%{field: value})
      {:ok, %EventUser{}}

      iex> create_event_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event_user(attrs \\ %{}) do
    %EventUser{}
    |> EventUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event_user.

  ## Examples

      iex> update_event_user(event_user, %{field: new_value})
      {:ok, %EventUser{}}

      iex> update_event_user(event_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event_user(%EventUser{} = event_user, attrs) do
    event_user
    |> EventUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event_user.

  ## Examples

      iex> delete_event_user(event_user)
      {:ok, %EventUser{}}

      iex> delete_event_user(event_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event_user(%EventUser{} = event_user) do
    Repo.delete(event_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event_user changes.

  ## Examples

      iex> change_event_user(event_user)
      %Ecto.Changeset{data: %EventUser{}}

  """
  def change_event_user(%EventUser{} = event_user, attrs \\ %{}) do
    EventUser.changeset(event_user, attrs)
  end
end
