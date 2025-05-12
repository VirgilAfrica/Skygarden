defmodule SkygardenWeb.EventPosterLive.Show do
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
     |> assign(:event_poster, Events.get_event_poster!(id))}
  end

  defp page_title(:show), do: "Show Event poster"
  defp page_title(:edit), do: "Edit Event poster"
end
