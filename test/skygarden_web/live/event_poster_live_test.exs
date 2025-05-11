defmodule SkygardenWeb.EventPosterLiveTest do
  use SkygardenWeb.ConnCase

  import Phoenix.LiveViewTest
  import Skygarden.EventsFixtures

  @create_attrs %{image: "some image"}
  @update_attrs %{image: "some updated image"}
  @invalid_attrs %{image: nil}

  defp create_event_poster(_) do
    event_poster = event_poster_fixture()
    %{event_poster: event_poster}
  end

  describe "Index" do
    setup [:create_event_poster]

    test "lists all event_posters", %{conn: conn, event_poster: event_poster} do
      {:ok, _index_live, html} = live(conn, ~p"/event_posters")

      assert html =~ "Listing Event posters"
      assert html =~ event_poster.image
    end

    test "saves new event_poster", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/event_posters")

      assert index_live |> element("a", "New Event poster") |> render_click() =~
               "New Event poster"

      assert_patch(index_live, ~p"/event_posters/new")

      assert index_live
             |> form("#event_poster-form", event_poster: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#event_poster-form", event_poster: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/event_posters")

      html = render(index_live)
      assert html =~ "Event poster created successfully"
      assert html =~ "some image"
    end

    test "updates event_poster in listing", %{conn: conn, event_poster: event_poster} do
      {:ok, index_live, _html} = live(conn, ~p"/event_posters")

      assert index_live |> element("#event_posters-#{event_poster.id} a", "Edit") |> render_click() =~
               "Edit Event poster"

      assert_patch(index_live, ~p"/event_posters/#{event_poster}/edit")

      assert index_live
             |> form("#event_poster-form", event_poster: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#event_poster-form", event_poster: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/event_posters")

      html = render(index_live)
      assert html =~ "Event poster updated successfully"
      assert html =~ "some updated image"
    end

    test "deletes event_poster in listing", %{conn: conn, event_poster: event_poster} do
      {:ok, index_live, _html} = live(conn, ~p"/event_posters")

      assert index_live |> element("#event_posters-#{event_poster.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#event_posters-#{event_poster.id}")
    end
  end

  describe "Show" do
    setup [:create_event_poster]

    test "displays event_poster", %{conn: conn, event_poster: event_poster} do
      {:ok, _show_live, html} = live(conn, ~p"/event_posters/#{event_poster}")

      assert html =~ "Show Event poster"
      assert html =~ event_poster.image
    end

    test "updates event_poster within modal", %{conn: conn, event_poster: event_poster} do
      {:ok, show_live, _html} = live(conn, ~p"/event_posters/#{event_poster}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Event poster"

      assert_patch(show_live, ~p"/event_posters/#{event_poster}/show/edit")

      assert show_live
             |> form("#event_poster-form", event_poster: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#event_poster-form", event_poster: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/event_posters/#{event_poster}")

      html = render(show_live)
      assert html =~ "Event poster updated successfully"
      assert html =~ "some updated image"
    end
  end
end
