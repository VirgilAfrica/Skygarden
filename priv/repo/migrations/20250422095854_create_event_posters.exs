defmodule Skygarden.Repo.Migrations.CreateEventPosters do
  use Ecto.Migration

  def change do
    create table(:event_posters) do
      add :image, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:event_posters, [:user_id])
    create index(:event_posters, [:event_id])
  end
end
