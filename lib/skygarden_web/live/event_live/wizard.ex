defmodule SkygardenWeb.EventLive.Wizard do
  use SkygardenWeb, :admin_live_view

  alias Skygarden.Events
  alias Skygarden.Events.Event

  @event_types [
    {"Concert or Performance", "Music, theater, dance, or other live performances"},
    {"Conference or Convention", "Business events, conventions, or professional gatherings"},
    {"Festival or Fair", "Multi-day events with various activities and performances."},
    {"Class or Workshop", "Educational events, workshops, or training sessions"},
    {"Food & Drink Event", "Culinary events, tastings, or food festivals."},
    {"Fundraiser or Charity", "Nonprofit events or fundraising activities."},
    {"Screening or Premiere", "Film screenings, premieres, or viewing events."},
    {"Exhibition or Expo", "Art exhibitions, trade shows, or expositions."},
    {"Corporate Event", "Team building, company retreats, or meetings"}
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      assign(socket,
        step: :select_type,
        event_type: nil,
        event_params: %{},
        event_changeset: Events.change_event(%Event{}),
        event_types: @event_types
      )}
  end

  @impl true
  def handle_event("select_type", %{"event_type" => event_type}, socket) do
    case event_type do
      "" ->
        socket = put_flash(socket, :error, "Please select an event type to continue.")
        {:noreply, socket}
      _ ->
        {:noreply,
          assign(socket,
          step: :event_details,
            event_type: event_type,
            event_params: Map.put(socket.assigns.event_params, "event_type", event_type),
            event_changeset: Events.change_event(%Event{event_type: event_type})
          )}
    end
  end

  @impl true
  def handle_event("save_details", %{"event" => event_params}, socket) do
    # Combine date and times into timestamps
    merged_params =
      socket.assigns.event_params
      |> Map.merge(event_params)
      |> Map.put("event_type", socket.assigns.event_type)
      |> combine_date_and_times()

    changeset = Events.change_event(%Event{}, merged_params)

      IO.inspect(changeset, label: "Changeset")

      {:noreply,
        assign(socket,
          event_params: merged_params,
          step: :upload_media,
          event_changeset: changeset
        )}
      # {:noreply, assign(socket, event_changeset: changeset)}
  end

  defp combine_date_and_times(params) do
    date = Map.get(params, "date")
    start_time = Map.get(params, "start_time")
    end_time = Map.get(params, "end_time")

    params
    |> maybe_put_datetime("start_datetime", date, start_time)
    |> maybe_put_datetime("end_datetime", date, end_time)
    |> Map.drop(["date", "start_time", "end_time"])
  end

  defp maybe_put_datetime(params, _key, nil, _), do: params
  defp maybe_put_datetime(params, _key, _, nil), do: params
  defp maybe_put_datetime(params, key, date, time) do
    # time may be "" if not filled
    if time == "" do
      params
    else
      case NaiveDateTime.from_iso8601("#{date} #{time}:00") do
        {:ok, ndt} -> Map.put(params, key, ndt)
        _ -> params
      end
    end
  end

  @impl true
  def handle_event("skip_upload", _params, socket) do
    {:noreply, assign(socket, step: :launch)}
  end

  @impl true
  def handle_event("launch", _params, socket) do
    IO.inspect(socket.assigns.event_params, label: "Launching with params")

    case Events.create_event(socket.assigns.event_params) do
      {:ok, _event} ->
        {:noreply, assign(socket, step: :congratulations)}

      {:error, changeset} ->
        {:noreply,
         assign(socket,
           event_changeset: changeset,
           step: :event_details
         )}
    end
  end

  @impl true
  def handle_event("back", _params, socket) do
    prev_step =
      case socket.assigns.step do
        :event_details -> :select_type
        :upload_media -> :event_details
        :launch -> :upload_media
        :congratulations -> :launch
        _ -> :select_type
      end

    {:noreply, assign(socket, step: prev_step)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.wizard_layout
      step={@step}
      event_type={@event_type}
      event_changeset={@event_changeset}
      event_types={@event_types}
    />
    """
  end
end
