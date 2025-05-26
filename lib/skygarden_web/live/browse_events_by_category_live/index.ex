defmodule SkygardenWeb.BrowseEventsByCategoryLive.Index do
  use SkygardenWeb, :live_view


  @impl true
  def mount(params, session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns)do
    ~H"""
    <.navbar/>
   <.category_layout/>
   <.footer/>
    """
  end
end
