defmodule SkygardenWeb.EventBulkMessageLive.Index do
  use SkygardenWeb, :super_admin_live_view

  alias Skygarden.EventBulkMessages
  alias Skygarden.EventBulkMessages.EventBulkMessage
  alias Skygarden.Events
  alias Skygarden.EventUsers

  @impl true
  def mount(%{"id" => event_id} = _params, _session, socket) do
    event = Events.get_event!(event_id)

    {:ok,
     socket
     |> assign(:event, event)
     |> assign(
       :show_event_bulk_messages,
       show_event_bulk_messages(socket.assigns.current_user, event)
     )
     |> stream(
       :event_bulk_messages,
       EventBulkMessages.list_event_bulk_messages_for_event(event_id)
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"event_bulk_message_id" => id}) do
    socket
    |> assign(:page_title, "Edit Event bulk message")
    |> assign(:event_bulk_message, EventBulkMessages.get_event_bulk_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Event bulk message")
    |> assign(:event_bulk_message, %EventBulkMessage{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Event bulk messages")
    |> assign(:event_bulk_message, nil)
  end

  @impl true
  def handle_info(
        {SkygardenWeb.EventBulkMessageLive.FormComponent, {:saved, event_bulk_message}},
        socket
      ) do
    event_bulk_message = EventBulkMessages.get_event_bulk_message!(event_bulk_message.id)
    {:noreply, stream_insert(socket, :event_bulk_messages, event_bulk_message)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    event_bulk_message = EventBulkMessages.get_event_bulk_message!(id)
    {:ok, _} = EventBulkMessages.delete_event_bulk_message(event_bulk_message)

    {:noreply, stream_delete(socket, :event_bulk_messages, event_bulk_message)}
  end

  defp show_event_bulk_messages(user, event) do
    if user.super_admin == true or user.id == event.user_id or
         user.id in EventUsers.list_admin_user_ids_for_event(event.id) do
      true
    else
      false
    end
  end
end
