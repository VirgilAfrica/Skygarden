defmodule Skygarden.EventPosters.EventPoster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "event_posters" do
    field :image, :string
    belongs_to :user, Skygarden.Accounts.User
    belongs_to :event, Skygarden.Events.Event

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event_poster, attrs) do
    event_poster
    |> cast(attrs, [:image, :user_id, :event_id])
    |> validate_required([:image, :user_id, :event_id])
  end
end
