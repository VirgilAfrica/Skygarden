defmodule Skygarden.TicketTypes.TicketType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ticket_types" do
    field :active, :boolean, default: false
    field :name, :string
    field :description, :string
    field :price, :float
    field :activate_on, :naive_datetime
    field :deactivate_on, :naive_datetime
    field :ticket_cap, :integer
    field :admits, :integer
    field :display_bnpl_option, :boolean, default: false
    field :event_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket_type, attrs) do
    ticket_type
    |> cast(attrs, [:name, :price, :active, :description, :activate_on, :deactivate_on, :ticket_cap, :admits, :display_bnpl_option])
    |> validate_required([:name, :price, :active, :description, :activate_on, :deactivate_on, :ticket_cap, :admits, :display_bnpl_option])
  end
end
