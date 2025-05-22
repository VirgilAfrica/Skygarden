defmodule Skygarden.Reminders do
  @moduledoc """
  The Reminders context.
  """

  import Ecto.Query, warn: false
  alias Skygarden.Repo

  alias Skygarden.Reminders.Reminder
  alias Skygarden.Tickets
  alias Skygarden.Events
  alias Skygarden.Scheduler
  alias Skygarden.Notify

  @doc """
  Returns the list of reminders.

  ## Examples

      iex> list_reminders()
      [%Reminder{}, ...]

  """

  def list_reminders_for_tickets(ticket_id)do
    from(r in Reminder,
      where: r.ticket_id == ^ticket_id,
      select: r
    )

    |> Repo.all()
  end
  @doc """
  Returns the list of reminders.

  ## Examples

      iex> list_reminders()
      [%Reminder{}, ...]

  """

  def reminders_for_ticket(ticket_id, params)do
    from(
      r in Reminder,
      where: r.ticket_id == ^ticket_id,
      select: r
    )
    |> Repo.paginate(params)
  end
  @doc """
  Returns the list of reminders.

  ## Examples

      iex> list_reminders()
      [%Reminder{}, ...]

  """


  def list_reminders do
    Repo.all(Reminder)
  end

  @doc """
  Gets a single reminder.

  Raises `Ecto.NoResultsError` if the Reminder does not exist.

  ## Examples

      iex> get_reminder!(123)
      %Reminder{}

      iex> get_reminder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reminder!(id), do: Repo.get!(Reminder, id)

  @doc """
  Creates a reminder.

  ## Examples

      iex> create_reminder(%{field: value})
      {:ok, %Reminder{}}

      iex> create_reminder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reminder(attrs \\ %{}) do
    %Reminder{}
    |> Reminder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of reminders.

  ## Examples

      iex> list_reminders()
      [%Reminder{}, ...]

  """
  def create_and_send_reminder(id, "sms")do
    ticket = Tickets.get_ticket!(id)
    event = Event.get_event!(ticket.event_id)

    reminder_params = create_reminder_params(ticket, event, "sms")

    case create_reminder(reminder_params) do
      {:ok, _reminder} ->
        case Notify
        {:ok, reminder}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Updates a reminder.

  ## Examples

      iex> update_reminder(reminder, %{field: new_value})
      {:ok, %Reminder{}}

      iex> update_reminder(reminder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reminder(%Reminder{} = reminder, attrs) do
    reminder
    |> Reminder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reminder.

  ## Examples

      iex> delete_reminder(reminder)
      {:ok, %Reminder{}}

      iex> delete_reminder(reminder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reminder(%Reminder{} = reminder) do
    Repo.delete(reminder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reminder changes.

  ## Examples

      iex> change_reminder(reminder)
      %Ecto.Changeset{data: %Reminder{}}

  """
  def change_reminder(%Reminder{} = reminder, attrs \\ %{}) do
    Reminder.changeset(reminder, attrs)


    defp create_reminder_params(ticket,event, sent_via)do
      %{
      text: get_reminder_text(ticket, event),
      event_id: event.id,
      ticket_id: ticket.id,
      phone_number: ticket.phone_number,
      email: ticket.email,
      sent_via: sent_via
    }
    end
end
