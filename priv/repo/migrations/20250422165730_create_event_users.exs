defmodule Skygarden.Repo.Migrations.CreateEventUsers do
  use Ecto.Migration

  def change do
    create table(:event_users) do
      add :role, :string, default: "admin"
      add :event_id, references(:events, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:event_users, [:event_id])
    create index(:event_users, [:user_id])
  end
end
