defmodule Skygarden.EventUsers.EventUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "event_users" do
    field :role, :string, default: "admin"
    belongs_to :user, Skygarden.Accounts.User
    belongs_to :event, Skygarden.Events.Event

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event_user, attrs) do
    event_user
    |> cast(attrs, [:role, :event_id, :user_id])
    |> validate_required([:role, :event_id, :user_id])
  end
end
