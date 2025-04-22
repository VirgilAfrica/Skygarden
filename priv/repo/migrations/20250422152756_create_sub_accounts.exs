defmodule Skygarden.Repo.Migrations.CreateSubAccounts do
  use Ecto.Migration

  def change do
    create table(:sub_accounts) do
      add :account_name, :string
      add :account_number, :string
      add :currency, :string
      add :settlement_bank, :string
      add :subaccount_code, :string
      add :percentage_split, :integer
      add :bank_code, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:sub_accounts, [:user_id])
  end
end
