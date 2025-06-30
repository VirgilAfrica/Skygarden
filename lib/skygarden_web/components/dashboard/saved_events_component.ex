defmodule SkygardenWeb.Dashboard.SavedEventsComponent do
  use Phoenix.Component


  def saved_events_layout(assigns)do
    ~H"""
    <section class="w-full">
      Saved tickets
    </section>
   """
  end
end
