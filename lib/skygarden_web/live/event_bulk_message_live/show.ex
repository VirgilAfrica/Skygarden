defmodule SkygardenWeb.EventBulkMessageLive.Show do
  use SkygardenWeb, :live_view

  alias Skygarden.Events

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:event_bulk_message, Events.get_event_bulk_message!(id))}
  end

  defp page_title(:show), do: "Show Event bulk message"
  defp page_title(:edit), do: "Edit Event bulk message"
end
