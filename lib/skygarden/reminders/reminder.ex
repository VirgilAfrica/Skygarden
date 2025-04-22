defmodule Skygarden.Reminders.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reminders" do
    field :text, :string
    field :sent_via, :string
    field :email, :string
    field :phone_number, :string
    field :ticket_id, :id
    field :event_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(reminder, attrs) do
    reminder
    |> cast(attrs, [:text, :sent_via, :email, :phone_number])
    |> validate_required([:text, :sent_via, :email, :phone_number])
  end
end
