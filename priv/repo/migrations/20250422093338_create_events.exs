defmodule Skygarden.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :description, :text
      add :poster_image, :text
      add :date, :date
      add :start_time, :time
      add :location, :string
      add :end_time, :time
      add :remind_time, :time
      add :slug, :text
      add :event_type, :string, null: false
      add :active, :boolean, default: false, null: false
      add :remind_after, :integer, default: 3
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:events, [:user_id])
    create index(:events, [:slug])
  end
end
