defmodule Skygarden.EventBulkMessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Skygarden.EventBulkMessages` context.
  """

  @doc """
  Generate a event_bulk_message.
  """
  def event_bulk_message_fixture(attrs \\ %{}) do
    {:ok, event_bulk_message} =
      attrs
      |> Enum.into(%{
        active: true,
        number_of_users_sent_to: 42,
        send_at: ~N[2025-04-21 16:23:00],
        send_to_a_specific_ticket_group: true,
        send_via: "some send_via",
        sent: true,
        text: "some text"
      })
      |> Skygarden.EventBulkMessages.create_event_bulk_message()

    event_bulk_message
  end
end
