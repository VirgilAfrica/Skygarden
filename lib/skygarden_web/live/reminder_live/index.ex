defmodule SkygardenWeb.ReminderLive.Index do
  use SkygardenWeb, :super_admin_live_view

  alias Skygarden.Reminders
  alias Skygarden.Reminders.Reminder
  alias Skygarden.Tickets
  alias Skygarden.Events
  alias Skygarden.EventUsers

  @impl true
  def mount(_, _session, socket) do
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
      Reminders.list_reminders_for_ticket(id, params)

    ticket = Tickets.get_ticket!(id)
    event = Events.get_event!(ticket.event_id)

    {:noreply,
     socket
     |> assign(:page_number, page_number)
     |> assign(:ticket, ticket)
     |> assign(:page_size, page_size)
     |> assign(:total_entries, total_entries)
     |> assign(:total_pages, total_pages)
     |> stream(:reminders, entries, reset: true)
     |> assign(:show_reminders, show_reminders(socket.assigns.current_user, event))
     |> apply_action(socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("nav", %{"page" => page}, socket) do
    {:noreply,
     socket
     |> push_patch(to: "/tickets/show/#{socket.assigns.ticket.id}/reminders?page=#{page}")}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Reminder")
    |> assign(:reminder, Reminders.get_reminder!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Reminder")
    |> assign(:reminder, %Reminder{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Reminders")
    |> assign(:reminder, nil)
  end

  defp format_date(date) do
    Timex.format!(date, "{WDshort} {Mshort} {D}, {YYYY}")
  end

  defp show_reminders(user, event) do
    if user.super_admin == true or user.id == event.user_id or
         user.id in EventUsers.list_admin_user_ids_for_event(event.id) do
      true
    else
      false
    end
  end
end
