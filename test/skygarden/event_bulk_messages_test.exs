defmodule Skygarden.EventBulkMessagesTest do
  use Skygarden.DataCase

  alias Skygarden.EventBulkMessages

  describe "event_bulk_messages" do
    alias Skygarden.EventBulkMessages.EventBulkMessage

    import Skygarden.EventBulkMessagesFixtures

    @invalid_attrs %{active: nil, text: nil, sent: nil, send_at: nil, number_of_users_sent_to: nil, send_via: nil, send_to_a_specific_ticket_group: nil}

    test "list_event_bulk_messages/0 returns all event_bulk_messages" do
      event_bulk_message = event_bulk_message_fixture()
      assert EventBulkMessages.list_event_bulk_messages() == [event_bulk_message]
    end

    test "get_event_bulk_message!/1 returns the event_bulk_message with given id" do
      event_bulk_message = event_bulk_message_fixture()
      assert EventBulkMessages.get_event_bulk_message!(event_bulk_message.id) == event_bulk_message
    end

    test "create_event_bulk_message/1 with valid data creates a event_bulk_message" do
      valid_attrs = %{active: true, text: "some text", sent: true, send_at: ~N[2025-04-21 16:23:00], number_of_users_sent_to: 42, send_via: "some send_via", send_to_a_specific_ticket_group: true}

      assert {:ok, %EventBulkMessage{} = event_bulk_message} = EventBulkMessages.create_event_bulk_message(valid_attrs)
      assert event_bulk_message.active == true
      assert event_bulk_message.text == "some text"
      assert event_bulk_message.sent == true
      assert event_bulk_message.send_at == ~N[2025-04-21 16:23:00]
      assert event_bulk_message.number_of_users_sent_to == 42
      assert event_bulk_message.send_via == "some send_via"
      assert event_bulk_message.send_to_a_specific_ticket_group == true
    end

    test "create_event_bulk_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EventBulkMessages.create_event_bulk_message(@invalid_attrs)
    end

    test "update_event_bulk_message/2 with valid data updates the event_bulk_message" do
      event_bulk_message = event_bulk_message_fixture()
      update_attrs = %{active: false, text: "some updated text", sent: false, send_at: ~N[2025-04-22 16:23:00], number_of_users_sent_to: 43, send_via: "some updated send_via", send_to_a_specific_ticket_group: false}

      assert {:ok, %EventBulkMessage{} = event_bulk_message} = EventBulkMessages.update_event_bulk_message(event_bulk_message, update_attrs)
      assert event_bulk_message.active == false
      assert event_bulk_message.text == "some updated text"
      assert event_bulk_message.sent == false
      assert event_bulk_message.send_at == ~N[2025-04-22 16:23:00]
      assert event_bulk_message.number_of_users_sent_to == 43
      assert event_bulk_message.send_via == "some updated send_via"
      assert event_bulk_message.send_to_a_specific_ticket_group == false
    end

    test "update_event_bulk_message/2 with invalid data returns error changeset" do
      event_bulk_message = event_bulk_message_fixture()
      assert {:error, %Ecto.Changeset{}} = EventBulkMessages.update_event_bulk_message(event_bulk_message, @invalid_attrs)
      assert event_bulk_message == EventBulkMessages.get_event_bulk_message!(event_bulk_message.id)
    end

    test "delete_event_bulk_message/1 deletes the event_bulk_message" do
      event_bulk_message = event_bulk_message_fixture()
      assert {:ok, %EventBulkMessage{}} = EventBulkMessages.delete_event_bulk_message(event_bulk_message)
      assert_raise Ecto.NoResultsError, fn -> EventBulkMessages.get_event_bulk_message!(event_bulk_message.id) end
    end

    test "change_event_bulk_message/1 returns a event_bulk_message changeset" do
      event_bulk_message = event_bulk_message_fixture()
      assert %Ecto.Changeset{} = EventBulkMessages.change_event_bulk_message(event_bulk_message)
    end
  end
end
