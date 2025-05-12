defmodule SkygardenWeb.EventUserLiveTest do
  use SkygardenWeb.ConnCase

  import Phoenix.LiveViewTest
  import Skygarden.EventsFixtures

  @create_attrs %{role: "some role"}
  @update_attrs %{role: "some updated role"}
  @invalid_attrs %{role: nil}

  defp create_event_user(_) do
    event_user = event_user_fixture()
    %{event_user: event_user}
  end

  describe "Index" do
    setup [:create_event_user]

    test "lists all event_users", %{conn: conn, event_user: event_user} do
      {:ok, _index_live, html} = live(conn, ~p"/event_users")

      assert html =~ "Listing Event users"
      assert html =~ event_user.role
    end

    test "saves new event_user", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/event_users")

      assert index_live |> element("a", "New Event user") |> render_click() =~
               "New Event user"

      assert_patch(index_live, ~p"/event_users/new")

      assert index_live
             |> form("#event_user-form", event_user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#event_user-form", event_user: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/event_users")

      html = render(index_live)
      assert html =~ "Event user created successfully"
      assert html =~ "some role"
    end

    test "updates event_user in listing", %{conn: conn, event_user: event_user} do
      {:ok, index_live, _html} = live(conn, ~p"/event_users")

      assert index_live |> element("#event_users-#{event_user.id} a", "Edit") |> render_click() =~
               "Edit Event user"

      assert_patch(index_live, ~p"/event_users/#{event_user}/edit")

      assert index_live
             |> form("#event_user-form", event_user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#event_user-form", event_user: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/event_users")

      html = render(index_live)
      assert html =~ "Event user updated successfully"
      assert html =~ "some updated role"
    end

    test "deletes event_user in listing", %{conn: conn, event_user: event_user} do
      {:ok, index_live, _html} = live(conn, ~p"/event_users")

      assert index_live |> element("#event_users-#{event_user.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#event_users-#{event_user.id}")
    end
  end

  describe "Show" do
    setup [:create_event_user]

    test "displays event_user", %{conn: conn, event_user: event_user} do
      {:ok, _show_live, html} = live(conn, ~p"/event_users/#{event_user}")

      assert html =~ "Show Event user"
      assert html =~ event_user.role
    end

    test "updates event_user within modal", %{conn: conn, event_user: event_user} do
      {:ok, show_live, _html} = live(conn, ~p"/event_users/#{event_user}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Event user"

      assert_patch(show_live, ~p"/event_users/#{event_user}/show/edit")

      assert show_live
             |> form("#event_user-form", event_user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#event_user-form", event_user: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/event_users/#{event_user}")

      html = render(show_live)
      assert html =~ "Event user updated successfully"
      assert html =~ "some updated role"
    end
  end
end
