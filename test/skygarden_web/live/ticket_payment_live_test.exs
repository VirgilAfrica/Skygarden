defmodule SkygardenWeb.TicketPaymentLiveTest do
  use SkygardenWeb.ConnCase

  import Phoenix.LiveViewTest
  import Skygarden.EventsFixtures

  @create_attrs %{price: 120.5, phone_number: "some phone_number", email: "some email", payment_method: "some payment_method", transaction_id: "some transaction_id"}
  @update_attrs %{price: 456.7, phone_number: "some updated phone_number", email: "some updated email", payment_method: "some updated payment_method", transaction_id: "some updated transaction_id"}
  @invalid_attrs %{price: nil, phone_number: nil, email: nil, payment_method: nil, transaction_id: nil}

  defp create_ticket_payment(_) do
    ticket_payment = ticket_payment_fixture()
    %{ticket_payment: ticket_payment}
  end

  describe "Index" do
    setup [:create_ticket_payment]

    test "lists all ticket_payments", %{conn: conn, ticket_payment: ticket_payment} do
      {:ok, _index_live, html} = live(conn, ~p"/ticket_payments")

      assert html =~ "Listing Ticket payments"
      assert html =~ ticket_payment.phone_number
    end

    test "saves new ticket_payment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/ticket_payments")

      assert index_live |> element("a", "New Ticket payment") |> render_click() =~
               "New Ticket payment"

      assert_patch(index_live, ~p"/ticket_payments/new")

      assert index_live
             |> form("#ticket_payment-form", ticket_payment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ticket_payment-form", ticket_payment: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ticket_payments")

      html = render(index_live)
      assert html =~ "Ticket payment created successfully"
      assert html =~ "some phone_number"
    end

    test "updates ticket_payment in listing", %{conn: conn, ticket_payment: ticket_payment} do
      {:ok, index_live, _html} = live(conn, ~p"/ticket_payments")

      assert index_live |> element("#ticket_payments-#{ticket_payment.id} a", "Edit") |> render_click() =~
               "Edit Ticket payment"

      assert_patch(index_live, ~p"/ticket_payments/#{ticket_payment}/edit")

      assert index_live
             |> form("#ticket_payment-form", ticket_payment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ticket_payment-form", ticket_payment: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ticket_payments")

      html = render(index_live)
      assert html =~ "Ticket payment updated successfully"
      assert html =~ "some updated phone_number"
    end

    test "deletes ticket_payment in listing", %{conn: conn, ticket_payment: ticket_payment} do
      {:ok, index_live, _html} = live(conn, ~p"/ticket_payments")

      assert index_live |> element("#ticket_payments-#{ticket_payment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ticket_payments-#{ticket_payment.id}")
    end
  end

  describe "Show" do
    setup [:create_ticket_payment]

    test "displays ticket_payment", %{conn: conn, ticket_payment: ticket_payment} do
      {:ok, _show_live, html} = live(conn, ~p"/ticket_payments/#{ticket_payment}")

      assert html =~ "Show Ticket payment"
      assert html =~ ticket_payment.phone_number
    end

    test "updates ticket_payment within modal", %{conn: conn, ticket_payment: ticket_payment} do
      {:ok, show_live, _html} = live(conn, ~p"/ticket_payments/#{ticket_payment}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ticket payment"

      assert_patch(show_live, ~p"/ticket_payments/#{ticket_payment}/show/edit")

      assert show_live
             |> form("#ticket_payment-form", ticket_payment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#ticket_payment-form", ticket_payment: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/ticket_payments/#{ticket_payment}")

      html = render(show_live)
      assert html =~ "Ticket payment updated successfully"
      assert html =~ "some updated phone_number"
    end
  end
end
