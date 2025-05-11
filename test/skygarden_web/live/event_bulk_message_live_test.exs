defmodule SkygardenWeb.EventBulkMessageLiveTest do
  use SkygardenWeb.ConnCase

  import Phoenix.LiveViewTest
  import Skygarden.EventsFixtures

  @create_attrs %{active: true, text: "some text", sent: true, send_at: "2025-05-10T14:25:00", number_of_users_sent_to: 42, send_via: "some send_via", send_to_a_specific_ticket_group: true}
  @update_attrs %{active: false, text: "some updated text", sent: false, send_at: "2025-05-11T14:25:00", number_of_users_sent_to: 43, send_via: "some updated send_via", send_to_a_specific_ticket_group: false}
  @invalid_attrs %{active: false, text: nil, sent: false, send_at: nil, number_of_users_sent_to: nil, send_via: nil, send_to_a_specific_ticket_group: false}

  defp create_event_bulk_message(_) do
    event_bulk_message = event_bulk_message_fixture()
    %{event_bulk_message: event_bulk_message}
  end

  describe "Index" do
    setup [:create_event_bulk_message]

    test "lists all event_bulk_messages", %{conn: conn, event_bulk_message: event_bulk_message} do
      {:ok, _index_live, html} = live(conn, ~p"/event_bulk_messages")

      assert html =~ "Listing Event bulk messages"
      assert html =~ event_bulk_message.text
    end

    test "saves new event_bulk_message", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/event_bulk_messages")

      assert index_live |> element("a", "New Event bulk message") |> render_click() =~
               "New Event bulk message"

      assert_patch(index_live, ~p"/event_bulk_messages/new")

      assert index_live
             |> form("#event_bulk_message-form", event_bulk_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#event_bulk_message-form", event_bulk_message: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/event_bulk_messages")

      html = render(index_live)
      assert html =~ "Event bulk message created successfully"
      assert html =~ "some text"
    end

    test "updates event_bulk_message in listing", %{conn: conn, event_bulk_message: event_bulk_message} do
      {:ok, index_live, _html} = live(conn, ~p"/event_bulk_messages")

      assert index_live |> element("#event_bulk_messages-#{event_bulk_message.id} a", "Edit") |> render_click() =~
               "Edit Event bulk message"

      assert_patch(index_live, ~p"/event_bulk_messages/#{event_bulk_message}/edit")

      assert index_live
             |> form("#event_bulk_message-form", event_bulk_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#event_bulk_message-form", event_bulk_message: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/event_bulk_messages")

      html = render(index_live)
      assert html =~ "Event bulk message updated successfully"
      assert html =~ "some updated text"
    end

    test "deletes event_bulk_message in listing", %{conn: conn, event_bulk_message: event_bulk_message} do
      {:ok, index_live, _html} = live(conn, ~p"/event_bulk_messages")

      assert index_live |> element("#event_bulk_messages-#{event_bulk_message.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#event_bulk_messages-#{event_bulk_message.id}")
    end
  end

  describe "Show" do
    setup [:create_event_bulk_message]

    test "displays event_bulk_message", %{conn: conn, event_bulk_message: event_bulk_message} do
      {:ok, _show_live, html} = live(conn, ~p"/event_bulk_messages/#{event_bulk_message}")

      assert html =~ "Show Event bulk message"
      assert html =~ event_bulk_message.text
    end

    test "updates event_bulk_message within modal", %{conn: conn, event_bulk_message: event_bulk_message} do
      {:ok, show_live, _html} = live(conn, ~p"/event_bulk_messages/#{event_bulk_message}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Event bulk message"

      assert_patch(show_live, ~p"/event_bulk_messages/#{event_bulk_message}/show/edit")

      assert show_live
             |> form("#event_bulk_message-form", event_bulk_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#event_bulk_message-form", event_bulk_message: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/event_bulk_messages/#{event_bulk_message}")

      html = render(show_live)
      assert html =~ "Event bulk message updated successfully"
      assert html =~ "some updated text"
    end
  end
end
