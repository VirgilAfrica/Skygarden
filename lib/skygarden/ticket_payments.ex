defmodule Skygarden.TicketPayments do
  @moduledoc """
  The TicketPayments context.
  """

  import Ecto.Query, warn: false
  alias Skygarden.Repo

  alias Skygarden.TicketPayments.TicketPayment

  @doc """
  Returns the list of ticket_payments.

  ## Examples

      iex> list_ticket_payments()
      [%TicketPayment{}, ...]

  """
  def list_ticket_payments do
    Repo.all(TicketPayment)
  end

  @doc """
  Gets a single ticket_payment.

  Raises `Ecto.NoResultsError` if the Ticket payment does not exist.

  ## Examples

      iex> get_ticket_payment!(123)
      %TicketPayment{}

      iex> get_ticket_payment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ticket_payment!(id), do: Repo.get!(TicketPayment, id)

  @doc """
  Creates a ticket_payment.

  ## Examples

      iex> create_ticket_payment(%{field: value})
      {:ok, %TicketPayment{}}

      iex> create_ticket_payment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ticket_payment(attrs \\ %{}) do
    %TicketPayment{}
    |> TicketPayment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ticket_payment.

  ## Examples

      iex> update_ticket_payment(ticket_payment, %{field: new_value})
      {:ok, %TicketPayment{}}

      iex> update_ticket_payment(ticket_payment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticket_payment(%TicketPayment{} = ticket_payment, attrs) do
    ticket_payment
    |> TicketPayment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ticket_payment.

  ## Examples

      iex> delete_ticket_payment(ticket_payment)
      {:ok, %TicketPayment{}}

      iex> delete_ticket_payment(ticket_payment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ticket_payment(%TicketPayment{} = ticket_payment) do
    Repo.delete(ticket_payment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ticket_payment changes.

  ## Examples

      iex> change_ticket_payment(ticket_payment)
      %Ecto.Changeset{data: %TicketPayment{}}

  """
  def change_ticket_payment(%TicketPayment{} = ticket_payment, attrs \\ %{}) do
    TicketPayment.changeset(ticket_payment, attrs)
  end
end
