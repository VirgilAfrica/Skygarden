defmodule Skygarden.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :active, :boolean, default: false
    field :name, :string
    field :date, :date
    field :description, :string
    field :location, :string
    field :poster_image, :string
    field :start_time, :time
    field :end_time, :time
    field :remind_time, :time
    field :slug, :string
    field :remind_after, :integer 
    field :user_id, :id
    field :event_type, :string


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [
      :name,
      :description,
      :poster_image,
      :date,
      :start_time,
      :location,
      :end_time,
      :remind_time,
      :slug,
      :active,
      :remind_after,
      :event_type
      ])
    |> validate_required([
      :name,
      :description,
      :poster_image,
      :date,
      :start_time,
      :location,
      :end_time,
      :remind_time,
      :slug,
      :active,
      :remind_after,
      :event_type
      ])
  end
end
