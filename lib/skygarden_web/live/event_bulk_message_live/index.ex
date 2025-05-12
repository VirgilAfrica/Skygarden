defmodule SkygardenWeb.EventBulkMessageLive.Index do
  use SkygardenWeb, :live_view

  alias Skygarden.Events
  alias Skygarden.Events.EventBulkMessage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :event_bulk_messages, Events.list_event_bulk_messages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Event bulk message")
    |> assign(:event_bulk_message, Events.get_event_bulk_message!(id))
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
  def handle_info({SkygardenWeb.EventBulkMessageLive.FormComponent, {:saved, event_bulk_message}}, socket) do
    {:noreply, stream_insert(socket, :event_bulk_messages, event_bulk_message)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    event_bulk_message = Events.get_event_bulk_message!(id)
    {:ok, _} = Events.delete_event_bulk_message(event_bulk_message)

    {:noreply, stream_delete(socket, :event_bulk_messages, event_bulk_message)}
  end
end
