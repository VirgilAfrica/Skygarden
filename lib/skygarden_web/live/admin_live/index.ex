defmodule SkygardenWeb.AdminLive.Index do
  use SkygardenWeb, :admin_live_view

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
  def render(assigns)do
    ~H"""
    <.navbar/>
    <.admin_layout/>
    <.footer/>
    """
  end
end
