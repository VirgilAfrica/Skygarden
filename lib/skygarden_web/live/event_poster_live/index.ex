defmodule SkygardenWeb.EventPosterLive.Index do
  use SkygardenWeb, :live_view

  alias Skygarden.Events
  alias Skygarden.Events.EventPoster

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :event_posters, Events.list_event_posters())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Event poster")
    |> assign(:event_poster, Events.get_event_poster!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Event poster")
    |> assign(:event_poster, %EventPoster{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Event posters")
    |> assign(:event_poster, nil)
  end

  @impl true
  def handle_info({SkygardenWeb.EventPosterLive.FormComponent, {:saved, event_poster}}, socket) do
    {:noreply, stream_insert(socket, :event_posters, event_poster)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    event_poster = Events.get_event_poster!(id)
    {:ok, _} = Events.delete_event_poster(event_poster)

    {:noreply, stream_delete(socket, :event_posters, event_poster)}
  end
end
