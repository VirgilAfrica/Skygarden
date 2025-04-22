defmodule Skygarden.EventPosters.EventPoster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "event_posters" do
    field :image, :string
    field :user_id, :id
    field :event_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event_poster, attrs) do
    event_poster
    |> cast(attrs, [:image])
    |> validate_required([:image])
  end
end
