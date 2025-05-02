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
      <div class="flex  items-start justify-between">
        <h1 class="text-[32px] md:text-[40px] font-bold">Upcoming Events</h1>
      </div>
      <div class="">
      <.events_card/>
      </div>
    </section>
   """
  end

  def events_card(assigns)do
    ~H"""
    <div class="border-[1px] border-gray-300 rounded-xl p-4 ">
      <div class="flex flex-row space-x-8 items-center justify-center">
        <img src="" alt="" class="rounded-xl bg-black w-32 h-32" />
        <div class="flex flex-row w-full items-center justify-between">
        <div class="space-y-2 flex flex-col" >
          <h2 class="text-[24px] font-medium">Tech Conference 2025</h2>
          <div class="flex space-x-2">
          <span class="flex space-x-2 items-center justify-center">
            <i class="fa fa-calendar text-gray-400"></i>
            <p>May 4, 2025</p>
          </span>
            <p class="text-[16px] font-bold">·</p>
          <span class="flex space-x-2 items-center justify-center">
            <i class="fa fa-clock text-gray-400"></i>
            <p>9:00 AM</p>
          </span>
          </div>
          <div class="flex flex-row">
          <span class="flex flex-row space-x-2 items-center justify-center">
          <i class="far fa-map-pin text-gray-400"></i>
          <p>Central Park, Nairobi.</p>
          </span>
        </div>
        </div>
        <div class="flex items-center justify-center">
          <button class="flex items-center justify-center h-full hover:text-blue-800  hover:bg-blue-100 rounded-md px-4 py-2 md:px-6 md:py-3 lg:px-8 lg:py-4">
            <i class="fa fa-chevron-right "></i>
          </button>
        </div>
        </div>
      </div>
    </div>
    """
  end

end
