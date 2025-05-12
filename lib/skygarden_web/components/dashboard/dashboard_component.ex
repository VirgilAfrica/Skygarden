defmodule SkygardenWeb.Dashboard.DashboardComponent do
  use Phoenix.Component


  def dashboard_layout(assigns)do
    ~H"""
    <section class="w-full">
      <.dashboard_section />
    </section>
   """
  end

  def dashboard_section(assigns)do
    ~H"""
    <section class="w-full space-y-4 flex flex-col lg:items-start items-center justify-center">
    <div class="flex flex-col space-y-4 w-full">
      <div class="flex  w-full">
        <h1 class="text-[32px] md:text-[40px] font-bold text-start">Upcoming Events</h1>
      </div>
      <div class="w-full">
      <.events_card/>
      </div>
      <div class="w-full flex items-center justify-center">
        <button class="flex items-center justify-center h-full hover:text-blue-800  hover:bg-blue-100 rounded-md px-4 py-2 md:px-6 md:py-3 lg:px-8 lg:py-4 border-2 border-blue-300">
         View all tickets
        </button>
      </div>
      </div>
      <div class="flex flex-col space-y-4 w-full">
      <div class="flex  w-full">
        <h1 class="text-[32px] md:text-[40px] font-bold text-start">Saved Events</h1>
      </div>
      <div class="w-full">
      <.events_card/>
      </div>
      <div class="w-full flex items-center justify-center">
        <button class="flex items-center justify-center h-full hover:text-blue-800  hover:bg-blue-100 rounded-md px-4 py-2 md:px-6 md:py-3 lg:px-8 lg:py-4 border-2 border-blue-300">
         View all tickets
        </button>
      </div>
      </div>

    </section>
   """
  end

  def events_card(assigns)do
    ~H"""
    <div class="border-[1px] border-gray-300 rounded-xl p-4 w-full ">
      <div class="flex flex-col lg:flex-row space-x-8 items-center justify-center">
        <img src="" alt="" class="rounded-xl bg-black lg:w-32 w-full h-64 lg:h-32" />
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
