defmodule SkygardenWeb.OrganizersLive.Index do
  use , :live_view


  @impl true
  def mount( _params,  _session,  socket) do

    {:ok, socket}
  end
  @impl true
  def render(assigns) do
    ~H"""
    this is the Organizers
    """
  end
end
