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
    field :quantity, :integer, default: 1
    field :ticketid, :string
    field :transaction_id, :string
    field :maximum_price, :float, virtual: true
    field :price, :float, virtual: true
    field :bnpl, :boolean, default: false
    field :fully_paid, :boolean, default: false
    field :formatted_phone_number, :string, virtual: true
    field :event_id, :id
    field :ticket_type_id, :id
    belongs_to :event, Skygarden.Events.Event
    belongs_to :ticket_type, Skygarden.Tickets.TicketType

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [
      :name,
      :phone_number,
      :email,
      :total_price,
      :remaining_price,
      :complimentary,
      :quantity,
      :ticketid,
      :transaction_id,
      :bnpl,
      :fully_paid,
      :event_id,
      :ticket_type_id
      ])
    |> validate_required([
      :name,
      :phone_number,
      :email,
      :total_price,
      :remaining_price,
      :complimentary,
      :quantity,
      :ticketid,
      :transaction_id,
      :bnpl,
      :fully_paid,
      :event_id,
      :ticket_type_id
      ])
  end

  def buy_ticket_changeset(ticket, attrs)do
    ticket
    |> cast(attrs, [
      :name,
      :email,
      :quantity,
      :maximum_price,
      :formatted_phone_number
    ])
    |> validate_required([
      :name,
      :email,
      :quantity,
      :maximum_price,
      :formatted_phone_number
    ])
    |> validate_format(
      :formatted_phone_number,
      ~r/^[17]\d{8}$/,
      message: "Number has to start with 7 or 1 and have 9 digits"
    )
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
  end

  def top_up_ticket_changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [
      :price,
      :maximum_price,
    ])
    |> validate_required([
      :price,
      :maximum_price,
    ])
    |> validate_top_up_not_more_than_maximum_price()

  end

  def buy_bnpl_ticket_changeset(ticket,attrs)do
    ticket
    |> cast(attrs, [
      :name,
      :email,
      :quantity,
      :event_id,
      :formatted_phone_number
    ])
    |> validate_required([
      :name,
      :email,
      :quantity,
      :event_id,
      :formatted_phone_number
    ])
    |> validate_format(
      :formatted_phone_number,
      ~r/^[17]\d{8}$/,
      message: "Number has to start with 7 or 1 and have 9 digits"
    )
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_unique_bnpl_phone_number_for_event()
  end

  defp validate_unique_bnpl_phone_number_for_event(changeset) do
    event_id = get_field(changeset, :event_id)
    formatted_phone_number = get_field(changeset, :formatted_phone_number)

    phone_number = get_phone_number(formatted_phone_number)

    case Tickets.get_bnpl_ticket_by_event_and_phone_number(
      event_id,
      phone_number
      ) do
      [] ->
        changeset

      _ ->
        add_error(
          changeset,
          :formatted_phone_number,
          "Phone number already exists for this event")
    end
  end

  defp get_phone_number(nil)do
    ""
  end

  defp get_phone_number(formatted_phone_number)do
    "254" <> formatted_phone_number
  end

  def validate_top_up_not_more_than_maximum_price(changeset) do
    price = get_field(changeset, :price)
    maximum_price = get_field(changeset, :maximum_price)

    if price > maximum_price do
      add_error(
        changeset,
        :price, "Top up amount cannot be more than the maximum price")
    else
      changeset
    end
  end
end
