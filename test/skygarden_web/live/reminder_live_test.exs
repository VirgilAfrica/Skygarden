defmodule SkygardenWeb.ReminderLiveTest do
  use SkygardenWeb.ConnCase

  import Phoenix.LiveViewTest
  import Skygarden.EventsFixtures

  @create_attrs %{text: "some text", sent_via: "some sent_via", email: "some email", phone_number: "some phone_number"}
  @update_attrs %{text: "some updated text", sent_via: "some updated sent_via", email: "some updated email", phone_number: "some updated phone_number"}
  @invalid_attrs %{text: nil, sent_via: nil, email: nil, phone_number: nil}

  defp create_reminder(_) do
    reminder = reminder_fixture()
    %{reminder: reminder}
  end

  describe "Index" do
    setup [:create_reminder]

    test "lists all reminders", %{conn: conn, reminder: reminder} do
      {:ok, _index_live, html} = live(conn, ~p"/reminders")

      assert html =~ "Listing Reminders"
      assert html =~ reminder.text
    end

    test "saves new reminder", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/reminders")

      assert index_live |> element("a", "New Reminder") |> render_click() =~
               "New Reminder"

      assert_patch(index_live, ~p"/reminders/new")

      assert index_live
             |> form("#reminder-form", reminder: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#reminder-form", reminder: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/reminders")

      html = render(index_live)
      assert html =~ "Reminder created successfully"
      assert html =~ "some text"
    end

    test "updates reminder in listing", %{conn: conn, reminder: reminder} do
      {:ok, index_live, _html} = live(conn, ~p"/reminders")

      assert index_live |> element("#reminders-#{reminder.id} a", "Edit") |> render_click() =~
               "Edit Reminder"

      assert_patch(index_live, ~p"/reminders/#{reminder}/edit")

      assert index_live
             |> form("#reminder-form", reminder: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#reminder-form", reminder: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/reminders")

      html = render(index_live)
      assert html =~ "Reminder updated successfully"
      assert html =~ "some updated text"
    end

    test "deletes reminder in listing", %{conn: conn, reminder: reminder} do
      {:ok, index_live, _html} = live(conn, ~p"/reminders")

      assert index_live |> element("#reminders-#{reminder.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#reminders-#{reminder.id}")
    end
  end

  describe "Show" do
    setup [:create_reminder]

    test "displays reminder", %{conn: conn, reminder: reminder} do
      {:ok, _show_live, html} = live(conn, ~p"/reminders/#{reminder}")

      assert html =~ "Show Reminder"
      assert html =~ reminder.text
    end

    test "updates reminder within modal", %{conn: conn, reminder: reminder} do
      {:ok, show_live, _html} = live(conn, ~p"/reminders/#{reminder}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Reminder"

      assert_patch(show_live, ~p"/reminders/#{reminder}/show/edit")

      assert show_live
             |> form("#reminder-form", reminder: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#reminder-form", reminder: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/reminders/#{reminder}")

      html = render(show_live)
      assert html =~ "Reminder updated successfully"
      assert html =~ "some updated text"
    end
  end
end
