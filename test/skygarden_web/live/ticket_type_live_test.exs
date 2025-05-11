defmodule SkygardenWeb.TicketTypeLiveTest do
  use SkygardenWeb.ConnCase

  import Phoenix.LiveViewTest
  import Skygarden.EventsFixtures

  @create_attrs %{active: true, name: "some name", description: "some description", price: 120.5, complimentary: true, activate_on: "2025-05-10T14:31:00", deactivate_on: "2025-05-10T14:31:00", ticket_cap: 42, admits: 42, display_bnpl_option: true}
  @update_attrs %{active: false, name: "some updated name", description: "some updated description", price: 456.7, complimentary: false, activate_on: "2025-05-11T14:31:00", deactivate_on: "2025-05-11T14:31:00", ticket_cap: 43, admits: 43, display_bnpl_option: false}
  @invalid_attrs %{active: false, name: nil, description: nil, price: nil, complimentary: false, activate_on: nil, deactivate_on: nil, ticket_cap: nil, admits: nil, display_bnpl_option: false}

  defp create_ticket_type(_) do
    ticket_type = ticket_type_fixture()
    %{ticket_type: ticket_type}
  end

  describe "Index" do
    setup [:create_ticket_type]

    test "lists all ticket_types", %{conn: conn, ticket_type: ticket_type} do
      {:ok, _index_live, html} = live(conn, ~p"/ticket_types")

      assert html =~ "Listing Ticket types"
      assert html =~ ticket_type.name
    end

    test "saves new ticket_type", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/ticket_types")

      assert index_live |> element("a", "New Ticket type") |> render_click() =~
               "New Ticket type"

      assert_patch(index_live, ~p"/ticket_types/new")

      assert index_live
             |> form("#ticket_type-form", ticket_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ticket_type-form", ticket_type: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ticket_types")

      html = render(index_live)
      assert html =~ "Ticket type created successfully"
      assert html =~ "some name"
    end

    test "updates ticket_type in listing", %{conn: conn, ticket_type: ticket_type} do
      {:ok, index_live, _html} = live(conn, ~p"/ticket_types")

      assert index_live |> element("#ticket_types-#{ticket_type.id} a", "Edit") |> render_click() =~
               "Edit Ticket type"

      assert_patch(index_live, ~p"/ticket_types/#{ticket_type}/edit")

      assert index_live
             |> form("#ticket_type-form", ticket_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ticket_type-form", ticket_type: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ticket_types")

      html = render(index_live)
      assert html =~ "Ticket type updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes ticket_type in listing", %{conn: conn, ticket_type: ticket_type} do
      {:ok, index_live, _html} = live(conn, ~p"/ticket_types")

      assert index_live |> element("#ticket_types-#{ticket_type.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ticket_types-#{ticket_type.id}")
    end
  end

  describe "Show" do
    setup [:create_ticket_type]

    test "displays ticket_type", %{conn: conn, ticket_type: ticket_type} do
      {:ok, _show_live, html} = live(conn, ~p"/ticket_types/#{ticket_type}")

      assert html =~ "Show Ticket type"
      assert html =~ ticket_type.name
    end

    test "updates ticket_type within modal", %{conn: conn, ticket_type: ticket_type} do
      {:ok, show_live, _html} = live(conn, ~p"/ticket_types/#{ticket_type}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ticket type"

      assert_patch(show_live, ~p"/ticket_types/#{ticket_type}/show/edit")

      assert show_live
             |> form("#ticket_type-form", ticket_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#ticket_type-form", ticket_type: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/ticket_types/#{ticket_type}")

      html = render(show_live)
      assert html =~ "Ticket type updated successfully"
      assert html =~ "some updated name"
    end
  end
end
