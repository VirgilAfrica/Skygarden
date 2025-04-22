defmodule Skygarden.Repo.Migrations.CreateReminders do
  use Ecto.Migration

  def change do
    create table(:reminders) do
      add :text, :text
      add :sent_via, :string
      add :email, :string
      add :phone_number, :string
      add :ticket_id, references(:tickets, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:reminders, [:ticket_id])
    create index(:reminders, [:event_id])
    create index(:reminders, [:sent_via])
    create index(:reminders, [:email])
    create index(:reminders, [:phone_number])
  end
end
