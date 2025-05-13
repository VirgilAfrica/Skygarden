defmodule Skygarden.EventBulkMessages do
  @moduledoc """
  The EventBulkMessages context.
  """

  import Ecto.Query, warn: false
  alias Skygarden.Repo

  alias Skygarden.EventBulkMessages.EventBulkMessage
  

  @doc """
  Returns the list of event_bulk_messages.

  ## Examples

      iex> list_event_bulk_messages()
      [%EventBulkMessage{}, ...]

  """
  def list_event_bulk_messages do
    Repo.all(EventBulkMessage)
  end

  @doc """
  Gets a single event_bulk_message.

  Raises `Ecto.NoResultsError` if the Event bulk message does not exist.

  ## Examples

      iex> get_event_bulk_message!(123)
      %EventBulkMessage{}

      iex> get_event_bulk_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event_bulk_message!(id), do: Repo.get!(EventBulkMessage, id)

  @doc """
  Creates a event_bulk_message.

  ## Examples

      iex> create_event_bulk_message(%{field: value})
      {:ok, %EventBulkMessage{}}

      iex> create_event_bulk_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event_bulk_message(attrs \\ %{}) do
    %EventBulkMessage{}
    |> EventBulkMessage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event_bulk_message.

  ## Examples

      iex> update_event_bulk_message(event_bulk_message, %{field: new_value})
      {:ok, %EventBulkMessage{}}

      iex> update_event_bulk_message(event_bulk_message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event_bulk_message(%EventBulkMessage{} = event_bulk_message, attrs) do
    event_bulk_message
    |> EventBulkMessage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event_bulk_message.

  ## Examples

      iex> delete_event_bulk_message(event_bulk_message)
      {:ok, %EventBulkMessage{}}

      iex> delete_event_bulk_message(event_bulk_message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event_bulk_message(%EventBulkMessage{} = event_bulk_message) do
    Repo.delete(event_bulk_message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event_bulk_message changes.

  ## Examples

      iex> change_event_bulk_message(event_bulk_message)
      %Ecto.Changeset{data: %EventBulkMessage{}}

  """
  def change_event_bulk_message(%EventBulkMessage{} = event_bulk_message, attrs \\ %{}) do
    EventBulkMessage.changeset(event_bulk_message, attrs)
  end
end
