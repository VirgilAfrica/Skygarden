defmodule SkygardenWeb.EventPosterLive.FormComponent do
  use SkygardenWeb, :live_component

  alias Skygarden.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage event_poster records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="event_poster-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:image]} type="text" label="Image" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Event poster</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{event_poster: event_poster} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Events.change_event_poster(event_poster))
     end)}
  end

  @impl true
  def handle_event("validate", %{"event_poster" => event_poster_params}, socket) do
    changeset = Events.change_event_poster(socket.assigns.event_poster, event_poster_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"event_poster" => event_poster_params}, socket) do
    save_event_poster(socket, socket.assigns.action, event_poster_params)
  end

  defp save_event_poster(socket, :edit, event_poster_params) do
    case Events.update_event_poster(socket.assigns.event_poster, event_poster_params) do
      {:ok, event_poster} ->
        notify_parent({:saved, event_poster})

        {:noreply,
         socket
         |> put_flash(:info, "Event poster updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_event_poster(socket, :new, event_poster_params) do
    case Events.create_event_poster(event_poster_params) do
      {:ok, event_poster} ->
        notify_parent({:saved, event_poster})

        {:noreply,
         socket
         |> put_flash(:info, "Event poster created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
