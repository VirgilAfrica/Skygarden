defmodule SkygardenWeb.EventPosterLive.Index do
  use SkygardenWeb, :super_admin_live_view

  alias Skygarden.EventPosters
  alias Skygarden.EventPosters.EventPoster
  alias Skygarden.Events
  alias Skygarden.EventUsers

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, stream(socket, :event_posters, EventPosters.list_event_posters_for_event(id))}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _url, socket) do
    event = Events.get_event!(id)

    {:noreply,
     socket
     |> assign(:event, event)
     |> assign(:show_event_posters, show_event_posters(socket.assigns.current_user, event))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"event_poster_id" => event_poster_id}) do
    socket
    |> assign(:page_title, "Edit Event poster")
    |> assign(:event_poster, EventPosters.get_event_poster!(event_poster_id))
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
    event_poster = EventPosters.get_event_poster!(id)
    {:ok, _} = EventPosters.delete_event_poster(event_poster)

    {:noreply, stream_delete(socket, :event_posters, event_poster)}
  end

  defp show_event_posters(user, event) do
    if user.super_admin == true or user.id == event.user_id or
         user.id in EventUsers.list_admin_user_ids_for_event(event.id) do
      true
    else
      false
    end
  end
end
