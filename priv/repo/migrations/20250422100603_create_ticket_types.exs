defmodule Skygarden.Repo.Migrations.CreateTicketTypes do
  use Ecto.Migration

  def change do
    create table(:ticket_types) do
      add :name, :string
      add :price, :float
      add :active, :boolean, default: false, null: false
      add :complimentary, :boolean, default: false, null: false

      add :description, :text
      add :activate_on, :naive_datetime
      add :deactivate_on, :naive_datetime
      add :ticket_cap, :integer
      add :admits, :integer
      add :display_bnpl_option, :boolean, default: false, null: false
      add :event_id, references(:events, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:ticket_types, [:event_id])
    create index(:ticket_types, [:user_id])
    create index(:ticket_types, [:active])
    create index(:ticket_types, [:complimentary])
  end
end
