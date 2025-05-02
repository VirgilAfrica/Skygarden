defmodule Skygarden.SubAccounts.SubAccount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sub_accounts" do
    field :currency, :string
    field :account_name, :string
    field :account_number, :string
    field :settlement_bank, :string
    field :subaccount_code, :string
    field :percentage_split, :integer
    field :bank_code, :integer
    field :bank_name, :string
    belongs_to :user, Skygarden.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sub_account, attrs) do
    sub_account
    |> cast(attrs, [
      :account_name,
      :account_number,
      :currency,
      :settlement_bank,
      :subaccount_code,
      :percentage_split,
      :bank_code,
      :user_id,
      :bank_name
    ])
    |> validate_required([
      :account_name,
      :account_number,
      :currency,
      :settlement_bank,
      :subaccount_code,
      :percentage_split,
      :bank_code,
      :user_id,
      :bank_name
    ])
  end
end
