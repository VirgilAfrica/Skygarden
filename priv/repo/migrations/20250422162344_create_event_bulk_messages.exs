defmodule Skygarden.Repo.Migrations.CreateEventBulkMessages do
  use Ecto.Migration

  def change do
    create table(:event_bulk_messages) do
      add :text, :text
      add :send_at, :naive_datetime
      add :active, :boolean, default: false, null: false
      add :sent, :boolean, default: false, null: false
      add :number_of_users_sent_to, :integer
      add :send_via, :string
      add :send_to_a_specific_ticket_group, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)
      add :ticket_type_id, references(:ticket_types, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:event_bulk_messages, [:user_id])
    create index(:event_bulk_messages, [:event_id])
    create index(:event_bulk_messages, [:ticket_type_id])
  end
end
