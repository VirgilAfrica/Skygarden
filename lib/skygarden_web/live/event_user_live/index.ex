defmodule SkygardenWeb.EventUserLive.Index do
  use SkygardenWeb, :super_admin_live_view

  alias Skygarden.EventUsers
  alias Skygarden.EventUsers.EventUser
  alias Skygarden.Accounts
  alias Skygarden.Events

  @impl true
  def mount(%{"id" => id} = _params, _session, socket) do
    event = Events.get_event!(id)

    {:ok,
     socket
     |> assign(:event, event)
     |> assign(
       :show_event_users,
       show_event_users(socket.assigns.current_user, event)
     )
     |> stream(
       :event_users,
       EventUsers.list_event_users_for_a_user(id)
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    users_for_dropdown_selection = Accounts.list_users_for_dropdown_selection()

    {:noreply,
     socket
     |> assign(:users_for_dropdown_selection, users_for_dropdown_selection)
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"event_user_id" => id}) do
    socket
    |> assign(:page_title, "Edit Event user")
    |> assign(:event_user, EventUsers.get_event_user!(id))
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
    event_user = EventUsers.get_event_user!(event_user.id)

    {:noreply, stream_insert(socket, :event_users, event_user)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    event_user = EventUsers.get_event_user!(id)
    {:ok, _} = EventUsers.delete_event_user(event_user)

    {:noreply, stream_delete(socket, :event_users, event_user)}
  end

  defp show_event_users(user, event) do
    if user.super_admin == true or user.id == event.user_id or
         user.id in EventUsers.list_admin_user_ids_for_event(event.id) do
      true
    else
      false
    end
  end
end
