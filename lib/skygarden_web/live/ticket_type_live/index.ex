defmodule SkygardenWeb.TicketTypeLive.Index do
  use SkygardenWeb, :super_admin_live_view

  alias Skygarden.TicketTypes
  alias Skygarden.TicketTypes.TicketType
  alias Skygarden.Events
  alias Skygarden.EventUsers

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, stream(socket, :ticket_types, TicketTypes.list_ticket_types_for_event(id))}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _url, socket) do
    event = Events.get_event!(id)

    {:noreply,
     socket
     |> assign(:event, event)
     |> assign(:show_ticket_types, show_ticket_types(socket.assigns.current_user, event))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"ticket_type_id" => ticket_type_id}) do
    socket
    |> assign(:page_title, "Edit Ticket type")
    |> assign(:ticket_type, TicketTypes.get_ticket_type!(ticket_type_id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ticket type")
    |> assign(:ticket_type, %TicketType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ticket types")
    |> assign(:ticket_type, nil)
  end

  @impl true
  def handle_info({SkygardenWeb.TicketTypeLive.FormComponent, {:saved, ticket_type}}, socket) do
    {:noreply, stream_insert(socket, :ticket_types, ticket_type)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ticket_type = TicketTypes.get_ticket_type!(id)
    {:ok, _} = TicketTypes.delete_ticket_type(ticket_type)

    {:noreply, stream_delete(socket, :ticket_types, ticket_type)}
  end

  defp show_ticket_types(user, event) do
    if user.super_admin == true or user.id == event.user_id or
         user.id in EventUsers.list_admin_user_ids_for_event(event.id) do
      true
    else
      false
    end
  end
end
