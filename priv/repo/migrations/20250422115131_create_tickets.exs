defmodule Skygarden.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :name, :string
      add :phone_number, :string
      add :email, :string
      add :total_price, :float
      add :remaining_price, :float
      add :complimentary, :boolean, default: false, null: false
      add :quantity, :integer
      add :ticketid, :text
      add :transaction_id, :text
      add :bnpl, :boolean, default: false, null: false
      add :event_id, references(:events, on_delete: :nothing)
      add :ticket_type_id, references(:ticket_types, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:tickets, [:event_id])
    create index(:tickets, [:ticket_type_id])
    create index(:tickets, [:transaction_id])
  end
end
