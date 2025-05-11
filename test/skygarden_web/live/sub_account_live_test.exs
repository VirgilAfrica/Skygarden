defmodule SkygardenWeb.SubAccountLiveTest do
  use SkygardenWeb.ConnCase

  import Phoenix.LiveViewTest
  import Skygarden.PaymentsFixtures

  @create_attrs %{currency: "some currency", account_name: "some account_name", account_number: "some account_number", settlement_bank: "some settlement_bank", subaccount_code: "some subaccount_code", percentage_split: 42, bank_code: 42}
  @update_attrs %{currency: "some updated currency", account_name: "some updated account_name", account_number: "some updated account_number", settlement_bank: "some updated settlement_bank", subaccount_code: "some updated subaccount_code", percentage_split: 43, bank_code: 43}
  @invalid_attrs %{currency: nil, account_name: nil, account_number: nil, settlement_bank: nil, subaccount_code: nil, percentage_split: nil, bank_code: nil}

  defp create_sub_account(_) do
    sub_account = sub_account_fixture()
    %{sub_account: sub_account}
  end

  describe "Index" do
    setup [:create_sub_account]

    test "lists all sub_accounts", %{conn: conn, sub_account: sub_account} do
      {:ok, _index_live, html} = live(conn, ~p"/sub_accounts")

      assert html =~ "Listing Sub accounts"
      assert html =~ sub_account.currency
    end

    test "saves new sub_account", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/sub_accounts")

      assert index_live |> element("a", "New Sub account") |> render_click() =~
               "New Sub account"

      assert_patch(index_live, ~p"/sub_accounts/new")

      assert index_live
             |> form("#sub_account-form", sub_account: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sub_account-form", sub_account: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sub_accounts")

      html = render(index_live)
      assert html =~ "Sub account created successfully"
      assert html =~ "some currency"
    end

    test "updates sub_account in listing", %{conn: conn, sub_account: sub_account} do
      {:ok, index_live, _html} = live(conn, ~p"/sub_accounts")

      assert index_live |> element("#sub_accounts-#{sub_account.id} a", "Edit") |> render_click() =~
               "Edit Sub account"

      assert_patch(index_live, ~p"/sub_accounts/#{sub_account}/edit")

      assert index_live
             |> form("#sub_account-form", sub_account: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sub_account-form", sub_account: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sub_accounts")

      html = render(index_live)
      assert html =~ "Sub account updated successfully"
      assert html =~ "some updated currency"
    end

    test "deletes sub_account in listing", %{conn: conn, sub_account: sub_account} do
      {:ok, index_live, _html} = live(conn, ~p"/sub_accounts")

      assert index_live |> element("#sub_accounts-#{sub_account.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sub_accounts-#{sub_account.id}")
    end
  end

  describe "Show" do
    setup [:create_sub_account]

    test "displays sub_account", %{conn: conn, sub_account: sub_account} do
      {:ok, _show_live, html} = live(conn, ~p"/sub_accounts/#{sub_account}")

      assert html =~ "Show Sub account"
      assert html =~ sub_account.currency
    end

    test "updates sub_account within modal", %{conn: conn, sub_account: sub_account} do
      {:ok, show_live, _html} = live(conn, ~p"/sub_accounts/#{sub_account}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sub account"

      assert_patch(show_live, ~p"/sub_accounts/#{sub_account}/show/edit")

      assert show_live
             |> form("#sub_account-form", sub_account: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#sub_account-form", sub_account: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/sub_accounts/#{sub_account}")

      html = render(show_live)
      assert html =~ "Sub account updated successfully"
      assert html =~ "some updated currency"
    end
  end
end
