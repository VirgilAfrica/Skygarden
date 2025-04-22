defmodule Skygarden.SubAccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.SubAccounts` context.
  """

  @doc """
  Generate a sub_account.
  """
  def sub_account_fixture(attrs \\ %{}) do
    {:ok, sub_account} =
      attrs
      |> Enum.into(%{
        account_name: "some account_name",
        account_number: "some account_number",
        bank_code: 42,
        currency: "some currency",
        percentage_split: 42,
        settlement_bank: "some settlement_bank",
        subaccount_code: "some subaccount_code"
      })
      |> Skygarden.SubAccounts.create_sub_account()

    sub_account
  end
end
