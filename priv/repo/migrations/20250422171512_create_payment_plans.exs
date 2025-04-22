defmodule Skygarden.Repo.Migrations.CreatePaymentPlans do
  use Ecto.Migration

  def change do
    create table(:payment_plans) do
      add :installments, :integer
      add :interest, :float
      add :user_id, references(:users, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:payment_plans, [:user_id])
    create index(:payment_plans, [:event_id])
  end
end
