defmodule SkygardenWeb.LandingLive.Index do
  use SkygardenWeb, :live_view


  @impl true
  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign(:page_title, "Landing Page")
    |> assign(:active_tab, "Landing")
  }
  end


  @impl true
  def render(assigns) do
    ~H"""
    <.navbar />
    <.landing_layout/>
    <.footer/>
    """
  end
end
