defmodule Skygarden.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :active, :boolean, default: true
    field :name, :string
    field :date, :date
    field :description, :string
    field :location, :string
    field :poster_image, :string
    field :start_time, :time
    field :end_time, :time
    field :remind_time, :time, default: ~T[10:00:00]
    field :slug, :string
    field :remind_after, :integer, default: 3
    # field :user_id, :id
    belongs_to :user, Skygarden.Accounts.User

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
      :remind_after
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
      :remind_after
        ])
  end
end
