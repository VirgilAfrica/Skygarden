defmodule SkygardenWeb.EventBulkMessageLive.FormComponent do
  use SkygardenWeb, :live_component

  alias Skygarden.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage event_bulk_message records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="event_bulk_message-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:text]} type="text" label="Text" />
        <.input field={@form[:send_at]} type="datetime-local" label="Send at" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:sent]} type="checkbox" label="Sent" />
        <.input field={@form[:number_of_users_sent_to]} type="number" label="Number of users sent to" />
        <.input field={@form[:send_via]} type="text" label="Send via" />
        <.input field={@form[:send_to_a_specific_ticket_group]} type="checkbox" label="Send to a specific ticket group" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Event bulk message</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{event_bulk_message: event_bulk_message} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Events.change_event_bulk_message(event_bulk_message))
     end)}
  end

  @impl true
  def handle_event("validate", %{"event_bulk_message" => event_bulk_message_params}, socket) do
    changeset = Events.change_event_bulk_message(socket.assigns.event_bulk_message, event_bulk_message_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"event_bulk_message" => event_bulk_message_params}, socket) do
    save_event_bulk_message(socket, socket.assigns.action, event_bulk_message_params)
  end

  defp save_event_bulk_message(socket, :edit, event_bulk_message_params) do
    case Events.update_event_bulk_message(socket.assigns.event_bulk_message, event_bulk_message_params) do
      {:ok, event_bulk_message} ->
        notify_parent({:saved, event_bulk_message})

        {:noreply,
         socket
         |> put_flash(:info, "Event bulk message updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_event_bulk_message(socket, :new, event_bulk_message_params) do
    case Events.create_event_bulk_message(event_bulk_message_params) do
      {:ok, event_bulk_message} ->
        notify_parent({:saved, event_bulk_message})

        {:noreply,
         socket
         |> put_flash(:info, "Event bulk message created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
