defmodule SkygardenWeb.AboutLive.Index do
  use SkygardenWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.navbar/>
    <.about_layout/>
    <.footer/>
    """
  end
end
