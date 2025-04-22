defmodule Skygarden.EventsTest do
  use Skygarden.DataCase

  alias Skygarden.Events

  describe "events" do
    alias Skygarden.Events.Event

    import Skygarden.EventsFixtures

    @invalid_attrs %{active: nil, name: nil, date: nil, description: nil, location: nil, poster_image: nil, start_time: nil, end_time: nil, remind_time: nil, slug: nil, remind_after: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{active: true, name: "some name", date: ~D[2025-04-21], description: "some description", location: "some location", poster_image: "some poster_image", start_time: ~T[14:00:00], end_time: ~T[14:00:00], remind_time: ~T[14:00:00], slug: "some slug", remind_after: 42}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.active == true
      assert event.name == "some name"
      assert event.date == ~D[2025-04-21]
      assert event.description == "some description"
      assert event.location == "some location"
      assert event.poster_image == "some poster_image"
      assert event.start_time == ~T[14:00:00]
      assert event.end_time == ~T[14:00:00]
      assert event.remind_time == ~T[14:00:00]
      assert event.slug == "some slug"
      assert event.remind_after == 42
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{active: false, name: "some updated name", date: ~D[2025-04-22], description: "some updated description", location: "some updated location", poster_image: "some updated poster_image", start_time: ~T[15:01:01], end_time: ~T[15:01:01], remind_time: ~T[15:01:01], slug: "some updated slug", remind_after: 43}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.active == false
      assert event.name == "some updated name"
      assert event.date == ~D[2025-04-22]
      assert event.description == "some updated description"
      assert event.location == "some updated location"
      assert event.poster_image == "some updated poster_image"
      assert event.start_time == ~T[15:01:01]
      assert event.end_time == ~T[15:01:01]
      assert event.remind_time == ~T[15:01:01]
      assert event.slug == "some updated slug"
      assert event.remind_after == 43
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
