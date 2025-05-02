defmodule SkygardenWeb.BrowseventsLive.Index do
  use SkygardenWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Browsevents Page")
     |> assign(:active_tab, "Browsevents")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.event_layout/>
    """
  end
end
