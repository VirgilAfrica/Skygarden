defmodule SkygardenWeb.EventLive.FormComponent do
  use SkygardenWeb, :live_component

  alias Skygarden.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage event records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="event-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <div class="hidden">
          <%= if @action == :new do %>
            <.input field={@form[:action]} value="new" />
          <% else %>
            <.input field={@form[:action]} value="edit" />
          <% end %>
        </div>
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="textarea" label="Description" />
        <.image_input
          ref={@uploads.poster_image.ref}
          entries={@uploads.poster_image.entries}
          image={@uploads.poster_image}
          image_name="Poster image"
          myself={@myself}
          current_image={@event && @event.poster_image}
        />
        <.input field={@form[:date]} type="date" label="Date" />
        <.input field={@form[:location]} type="text" label="Location" />
        <.input field={@form[:start_time]} type="time" label="Start time" />
        <.input field={@form[:end_time]} type="time" label="End time" />
        <.input field={@form[:remind_time]} type="time" label="Send Reminders at?" />
        <.input
          field={@form[:remind_after]}
          options={reminder_options()}
          type="select"
          label="Send Buy Now Pay Later Reminders Every"
        />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Event</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{event: event} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:uploaded_files, [])
     |> allow_upload(
      :poster_image,
      accept: ~w(.jpg .jpeg .png), max_entries: 1)
     |> assign_new(
      :form,
      fn ->
       to_form(Events.change_event(event))
     end
     )}
  end

  @impl true
  def handle_event("validate", %{"event" => event_params}, socket) do
    changeset = Events.change_event(socket.assigns.event, event_params)
    {:noreply,
    assign(
      socket,
      form: to_form(
        changeset,
        action:
        :validate
        ))}
  end

  def handle_event("cancel-upload",%{"ref"=> ref}, socket)do
    {
      :noreply,
      cancel_upload(
        socket,
        :poster_image,
        ref
        )}
  end

  def handle_event("save", %{"event" => event_params}, socket) do
    event_params=
      event_params
      |> Map.put(
        "user_id",
        socket.assigns.current_user.id
      )
      case uploaded_image(socket)do
        nil ->
            save_event(
              socket,
              socket.assigns.action,
              event_params
            )
        image ->
          save_event(
            socket,
            socket.assigns.action,
            event_params
            |> Map.put("poster_image", image)
          )
      end
  end

  defp save_event(socket, :edit, event_params) do
    event_params =
      if Map.has_key?(socket.assigns.form.source.changes, :name)do
        event_params
        |> Map.put(
          "slug",
          Slug.slugify(
            event_params["name"] <> "," <> event_params["date"],
            lowercase: false
          )
        )
      else
        event_params
      end

    case Events.update_event(socket.assigns.event, event_params) do
      {:ok, event} ->
        notify_parent({:saved, event})

        {:noreply,
         socket
         |> put_flash(:info, "Event updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_event(socket, :new, event_params) do
    event_params =
      event_params
      |> Map.put(
        "slug",
        Slug.slugify(
          event_params["name"] <> "," <> event_params["date"],
          lowercase: false
        )
      )
    case Events.create_event(event_params) do
      {:ok, event} ->
        notify_parent({:saved, event})

        {:noreply,
         socket
         |> put_flash(:info, "Event created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp reminder_options do
    [
      {"One Day", 1},
      {"Two Days", 2},
      {"Three Days", 3},
      {"Four Days", 4},
      {"Five Days", 5},
      {"One Week", 7},
      {"Two Weeks", 14},
      {"One Month", 30}
    ]
  end

  defp uploaded_image(socket)do
    uploaded_files =
      consume_uploaded_entries(
        socket,
        :poster_image,
        fn %{path: path},
        _entry ->
          dest = Path.join([:code.priv_dir(:skygarden), "static", "uploads", Path.basename(path)])

          File.cp!(path, dest)
          {
            :ok,
            "/uploads/" <> Path.basename(dest)
          }
        end
      )

      {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}

      List.first(uploaded_files)
  end
end
