defmodule SkygardenWeb.EventLive.Show do
  use SkygardenWeb, :admin_live_view

  alias Skygarden.Events

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    event = Events.get_event!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:event, event)}
     |> assign(:show_event, show_event(socket.assigns.current_user, event))
  end

  defp show_event(user, event)do
    # Add super admins later
    if user.id == event.user_id do
      true
    else
      false
    end
  end

  defp page_title(:show), do: "Show Event"
  defp page_title(:edit), do: "Edit Event"
end
