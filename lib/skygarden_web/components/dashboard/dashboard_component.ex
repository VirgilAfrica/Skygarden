defmodule SkygardenWeb.Dashboard.DashboardComponent do
  use Phoenix.Component


  def dashboard_layout(assigns)do
    ~H"""
    <section class="">
      <.dashboard_section />
    </section>
   """
  end

  def dashboard_section(assigns)do
    ~H"""
    <section class="">
      <div class="">
      This is the admin section of the dashboard
      </div>
    </section>
   """
  end
end
