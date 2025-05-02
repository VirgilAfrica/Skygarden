defmodule Skygarden.EventPostersTest do
  use Skygarden.DataCase

  alias Skygarden.EventPosters

  describe "event_posters" do
    alias Skygarden.EventPosters.EventPoster

    import Skygarden.EventPostersFixtures

    @invalid_attrs %{image: nil}

    test "list_event_posters/0 returns all event_posters" do
      event_poster = event_poster_fixture()
      assert EventPosters.list_event_posters() == [event_poster]
    end

    test "get_event_poster!/1 returns the event_poster with given id" do
      event_poster = event_poster_fixture()
      assert EventPosters.get_event_poster!(event_poster.id) == event_poster
    end

    test "create_event_poster/1 with valid data creates a event_poster" do
      valid_attrs = %{image: "some image"}

      assert {:ok, %EventPoster{} = event_poster} = EventPosters.create_event_poster(valid_attrs)
      assert event_poster.image == "some image"
    end

    test "create_event_poster/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EventPosters.create_event_poster(@invalid_attrs)
    end

    test "update_event_poster/2 with valid data updates the event_poster" do
      event_poster = event_poster_fixture()
      update_attrs = %{image: "some updated image"}

      assert {:ok, %EventPoster{} = event_poster} =
               EventPosters.update_event_poster(event_poster, update_attrs)

      assert event_poster.image == "some updated image"
    end

    test "update_event_poster/2 with invalid data returns error changeset" do
      event_poster = event_poster_fixture()

      assert {:error, %Ecto.Changeset{}} =
               EventPosters.update_event_poster(event_poster, @invalid_attrs)

      assert event_poster == EventPosters.get_event_poster!(event_poster.id)
    end

    test "delete_event_poster/1 deletes the event_poster" do
      event_poster = event_poster_fixture()
      assert {:ok, %EventPoster{}} = EventPosters.delete_event_poster(event_poster)
      assert_raise Ecto.NoResultsError, fn -> EventPosters.get_event_poster!(event_poster.id) end
    end

    test "change_event_poster/1 returns a event_poster changeset" do
      event_poster = event_poster_fixture()
      assert %Ecto.Changeset{} = EventPosters.change_event_poster(event_poster)
    end
  end
end
