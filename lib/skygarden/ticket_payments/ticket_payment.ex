defmodule Skygarden.TicketPayments.TicketPayment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ticket_payments" do
    field :price, :float
    field :phone_number, :string
    field :email, :string
    field :payment_method, :string
    field :transaction_id, :string
    belongs_to :ticket, Skygarden.Tickets.Ticket
    belongs_to :event, Skygarden.Events.Event

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket_payment, attrs) do
    ticket_payment
    |> cast(attrs, [
      :price,
      :phone_number,
      :email,
      :payment_method,
      :transaction_id,
      :event_id,
      :ticket_id
      ])
    |> validate_required([
      :price,
      :phone_number,
      :email,
      :payment_method,
      :transaction_id,
      :event_id,
      :ticket_id
      ])
  end
end
