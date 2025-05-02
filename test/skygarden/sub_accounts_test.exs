defmodule Skygarden.SubAccountsTest do
  use Skygarden.DataCase

  alias Skygarden.SubAccounts

  describe "sub_accounts" do
    alias Skygarden.SubAccounts.SubAccount

    import Skygarden.SubAccountsFixtures

    @invalid_attrs %{
      currency: nil,
      account_name: nil,
      account_number: nil,
      settlement_bank: nil,
      subaccount_code: nil,
      percentage_split: nil,
      bank_code: nil
    }

    test "list_sub_accounts/0 returns all sub_accounts" do
      sub_account = sub_account_fixture()
      assert SubAccounts.list_sub_accounts() == [sub_account]
    end

    test "get_sub_account!/1 returns the sub_account with given id" do
      sub_account = sub_account_fixture()
      assert SubAccounts.get_sub_account!(sub_account.id) == sub_account
    end

    test "create_sub_account/1 with valid data creates a sub_account" do
      valid_attrs = %{
        currency: "some currency",
        account_name: "some account_name",
        account_number: "some account_number",
        settlement_bank: "some settlement_bank",
        subaccount_code: "some subaccount_code",
        percentage_split: 42,
        bank_code: 42
      }

      assert {:ok, %SubAccount{} = sub_account} = SubAccounts.create_sub_account(valid_attrs)
      assert sub_account.currency == "some currency"
      assert sub_account.account_name == "some account_name"
      assert sub_account.account_number == "some account_number"
      assert sub_account.settlement_bank == "some settlement_bank"
      assert sub_account.subaccount_code == "some subaccount_code"
      assert sub_account.percentage_split == 42
      assert sub_account.bank_code == 42
    end

    test "create_sub_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SubAccounts.create_sub_account(@invalid_attrs)
    end

    test "update_sub_account/2 with valid data updates the sub_account" do
      sub_account = sub_account_fixture()

      update_attrs = %{
        currency: "some updated currency",
        account_name: "some updated account_name",
        account_number: "some updated account_number",
        settlement_bank: "some updated settlement_bank",
        subaccount_code: "some updated subaccount_code",
        percentage_split: 43,
        bank_code: 43
      }

      assert {:ok, %SubAccount{} = sub_account} =
               SubAccounts.update_sub_account(sub_account, update_attrs)

      assert sub_account.currency == "some updated currency"
      assert sub_account.account_name == "some updated account_name"
      assert sub_account.account_number == "some updated account_number"
      assert sub_account.settlement_bank == "some updated settlement_bank"
      assert sub_account.subaccount_code == "some updated subaccount_code"
      assert sub_account.percentage_split == 43
      assert sub_account.bank_code == 43
    end

    test "update_sub_account/2 with invalid data returns error changeset" do
      sub_account = sub_account_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SubAccounts.update_sub_account(sub_account, @invalid_attrs)

      assert sub_account == SubAccounts.get_sub_account!(sub_account.id)
    end

    test "delete_sub_account/1 deletes the sub_account" do
      sub_account = sub_account_fixture()
      assert {:ok, %SubAccount{}} = SubAccounts.delete_sub_account(sub_account)
      assert_raise Ecto.NoResultsError, fn -> SubAccounts.get_sub_account!(sub_account.id) end
    end

    test "change_sub_account/1 returns a sub_account changeset" do
      sub_account = sub_account_fixture()
      assert %Ecto.Changeset{} = SubAccounts.change_sub_account(sub_account)
    end
  end
end
