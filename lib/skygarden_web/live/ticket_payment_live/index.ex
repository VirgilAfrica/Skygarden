defmodule SkygardenWeb.TicketPaymentLive.Index do
  use SkygardenWeb, :super_admin_live_view

  alias Skygarden.TicketPayments
  alias Skygarden.Tickets
  alias Skygarden.Events
  alias Skygarden.EventUsers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _url, socket) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } =
      TicketPayments.list_ticket_payments_for_ticket(id, params)

    ticket = Tickets.get_ticket!(id)
    event = Events.get_event!(ticket.event_id)

    {:noreply,
     socket
     |> assign(:page_number, page_number)
     |> assign(:ticket, ticket)
     |> assign(:page_size, page_size)
     |> assign(:total_entries, total_entries)
     |> assign(:show_ticket_payments, show_ticket_payments(socket.assigns.current_user, event))
     |> assign(:total_pages, total_pages)
     |> stream(:ticket_payments, entries, reset: true)
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ticket payments")
    |> assign(:ticket_payment, nil)
  end

  @impl true
  def handle_info({SkygardenWeb.TicketPaymentLive.FormComponent, {:saved, ticket_payment}}, socket) do
    {:noreply, stream_insert(socket, :ticket_payments, ticket_payment)}
  end

  defp format_date(date) do
    Timex.format!(date, "{WDshort} {Mshort} {D}, {YYYY}")
  end

  defp show_ticket_payments(user, event) do
    if user.super_admin == true or user.id == event.user_id or
         user.id in EventUsers.list_admin_user_ids_for_event(event.id) do
      true
    else
      false
    end
  end
end
