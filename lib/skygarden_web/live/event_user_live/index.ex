defmodule SkygardenWeb.EventUserLive.Index do
  use SkygardenWeb, :live_view

  alias Skygarden.Events
  alias Skygarden.Events.EventUser

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :event_users, Events.list_event_users())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Event user")
    |> assign(:event_user, Events.get_event_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Event user")
    |> assign(:event_user, %EventUser{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Event users")
    |> assign(:event_user, nil)
  end

  @impl true
  def handle_info({SkygardenWeb.EventUserLive.FormComponent, {:saved, event_user}}, socket) do
    {:noreply, stream_insert(socket, :event_users, event_user)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    event_user = Events.get_event_user!(id)
    {:ok, _} = Events.delete_event_user(event_user)

    {:noreply, stream_delete(socket, :event_users, event_user)}
  end
end
