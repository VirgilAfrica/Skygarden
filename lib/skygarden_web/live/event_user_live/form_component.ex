defmodule SkygardenWeb.EventUserLive.FormComponent do
  use SkygardenWeb, :live_component

  alias Skygarden.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage event_user records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="event_user-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:role]} type="text" label="Role" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Event user</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{event_user: event_user} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Events.change_event_user(event_user))
     end)}
  end

  @impl true
  def handle_event("validate", %{"event_user" => event_user_params}, socket) do
    changeset = Events.change_event_user(socket.assigns.event_user, event_user_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"event_user" => event_user_params}, socket) do
    save_event_user(socket, socket.assigns.action, event_user_params)
  end

  defp save_event_user(socket, :edit, event_user_params) do
    case Events.update_event_user(socket.assigns.event_user, event_user_params) do
      {:ok, event_user} ->
        notify_parent({:saved, event_user})

        {:noreply,
         socket
         |> put_flash(:info, "Event user updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_event_user(socket, :new, event_user_params) do
    case Events.create_event_user(event_user_params) do
      {:ok, event_user} ->
        notify_parent({:saved, event_user})

        {:noreply,
         socket
         |> put_flash(:info, "Event user created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
