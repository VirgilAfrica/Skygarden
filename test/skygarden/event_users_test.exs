defmodule Skygarden.EventUsersTest do
  use Skygarden.DataCase

  alias Skygarden.EventUsers

  describe "event_users" do
    alias Skygarden.EventUsers.EventUser

    import Skygarden.EventUsersFixtures

    @invalid_attrs %{role: nil}

    test "list_event_users/0 returns all event_users" do
      event_user = event_user_fixture()
      assert EventUsers.list_event_users() == [event_user]
    end

    test "get_event_user!/1 returns the event_user with given id" do
      event_user = event_user_fixture()
      assert EventUsers.get_event_user!(event_user.id) == event_user
    end

    test "create_event_user/1 with valid data creates a event_user" do
      valid_attrs = %{role: "some role"}

      assert {:ok, %EventUser{} = event_user} = EventUsers.create_event_user(valid_attrs)
      assert event_user.role == "some role"
    end

    test "create_event_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EventUsers.create_event_user(@invalid_attrs)
    end

    test "update_event_user/2 with valid data updates the event_user" do
      event_user = event_user_fixture()
      update_attrs = %{role: "some updated role"}

      assert {:ok, %EventUser{} = event_user} = EventUsers.update_event_user(event_user, update_attrs)
      assert event_user.role == "some updated role"
    end

    test "update_event_user/2 with invalid data returns error changeset" do
      event_user = event_user_fixture()
      assert {:error, %Ecto.Changeset{}} = EventUsers.update_event_user(event_user, @invalid_attrs)
      assert event_user == EventUsers.get_event_user!(event_user.id)
    end

    test "delete_event_user/1 deletes the event_user" do
      event_user = event_user_fixture()
      assert {:ok, %EventUser{}} = EventUsers.delete_event_user(event_user)
      assert_raise Ecto.NoResultsError, fn -> EventUsers.get_event_user!(event_user.id) end
    end

    test "change_event_user/1 returns a event_user changeset" do
      event_user = event_user_fixture()
      assert %Ecto.Changeset{} = EventUsers.change_event_user(event_user)
    end
  end
end
