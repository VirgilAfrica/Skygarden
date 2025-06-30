defmodule SkygardenWeb.HelpCenterLive,Index do
  use , :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""

    """
  end

  @impl Phoenix.LiveView
  def mount( params,  session,  socket) do
    {:ok, socket}
  end
end
