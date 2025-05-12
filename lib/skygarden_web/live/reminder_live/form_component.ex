defmodule SkygardenWeb.ReminderLive.FormComponent do
  use SkygardenWeb, :live_component

  alias Skygarden.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage reminder records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="reminder-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:text]} type="text" label="Text" />
        <.input field={@form[:sent_via]} type="text" label="Sent via" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:phone_number]} type="text" label="Phone number" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Reminder</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{reminder: reminder} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Events.change_reminder(reminder))
     end)}
  end

  @impl true
  def handle_event("validate", %{"reminder" => reminder_params}, socket) do
    changeset = Events.change_reminder(socket.assigns.reminder, reminder_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"reminder" => reminder_params}, socket) do
    save_reminder(socket, socket.assigns.action, reminder_params)
  end

  defp save_reminder(socket, :edit, reminder_params) do
    case Events.update_reminder(socket.assigns.reminder, reminder_params) do
      {:ok, reminder} ->
        notify_parent({:saved, reminder})

        {:noreply,
         socket
         |> put_flash(:info, "Reminder updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_reminder(socket, :new, reminder_params) do
    case Events.create_reminder(reminder_params) do
      {:ok, reminder} ->
        notify_parent({:saved, reminder})

        {:noreply,
         socket
         |> put_flash(:info, "Reminder created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
