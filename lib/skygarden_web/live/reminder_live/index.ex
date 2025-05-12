defmodule SkygardenWeb.ReminderLive.Index do
  use SkygardenWeb, :live_view

  alias Skygarden.Events
  alias Skygarden.Events.Reminder

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :reminders, Events.list_reminders())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Reminder")
    |> assign(:reminder, Events.get_reminder!(id))
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

  @impl true
  def handle_info({SkygardenWeb.ReminderLive.FormComponent, {:saved, reminder}}, socket) do
    {:noreply, stream_insert(socket, :reminders, reminder)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    reminder = Events.get_reminder!(id)
    {:ok, _} = Events.delete_reminder(reminder)

    {:noreply, stream_delete(socket, :reminders, reminder)}
  end
end
