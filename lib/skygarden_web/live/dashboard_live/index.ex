defmodule SkygardenWeb.Dashboard.Index do
  use SkygardenWeb, :dashboard_live_view

  @impl true
  def mount(_params, _session, socket) do
    {
        :ok,
        socket
        |> assign(:active_tab , "Dashboard")
        |> assign(:page_title, "Admin Dashboard")
      }

  end


  @impl true
  def render(assigns) do
    ~H"""
    <.dashboard_layout/>
    """
  end
end
