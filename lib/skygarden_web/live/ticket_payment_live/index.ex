defmodule SkygardenWeb.TicketPaymentLive.Index do
  use SkygardenWeb, :live_view

  alias Skygarden.Events
  alias Skygarden.Events.TicketPayment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :ticket_payments, Events.list_ticket_payments())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ticket payment")
    |> assign(:ticket_payment, Events.get_ticket_payment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ticket payment")
    |> assign(:ticket_payment, %TicketPayment{})
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

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ticket_payment = Events.get_ticket_payment!(id)
    {:ok, _} = Events.delete_ticket_payment(ticket_payment)

    {:noreply, stream_delete(socket, :ticket_payments, ticket_payment)}
  end
end
