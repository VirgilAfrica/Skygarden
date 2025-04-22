defmodule Skygarden.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :name, :string
    field :phone_number, :string
    field :email, :string
    field :total_price, :float
    field :remaining_price, :float
    field :complimentary, :boolean, default: false
    field :quantity, :integer
    field :ticketid, :string
    field :transaction_id, :string
    field :bnpl, :boolean, default: false
    field :event_id, :id
    field :ticket_type_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:name, :phone_number, :email, :total_price, :remaining_price, :complimentary, :quantity, :ticketid, :transaction_id, :bnpl])
    |> validate_required([:name, :phone_number, :email, :total_price, :remaining_price, :complimentary, :quantity, :ticketid, :transaction_id, :bnpl])
  end
end
