defmodule Skygarden.Repo.Migrations.CreateTicketPayments do
  use Ecto.Migration

  def change do
    create table(:ticket_payments) do
      add :price, :float
      add :phone_number, :string
      add :email, :string
      add :payment_method, :string
      add :transaction_id, :string
      add :ticket_id, references(:tickets, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:ticket_payments, [:ticket_id])
    create index(:ticket_payments, [:event_id])
  end
end
