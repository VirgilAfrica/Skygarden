defmodule SkygardenWeb.Admin.AdminComponent do
  use Phoenix.Component

  def admin_layout(assigns)do
    ~H"""
    <section class="w-full h-auto w-full h-auto bg-black">
    <div class="max-w-[90%] mx-auto space-y-8">
    <.dashboard/>
    <.analytics_card/>
    <.sales_analytics/>
      <%!-- <.create_event/> --%>
      </div>
    </section>
    """
  end

  def dashboard(assigns)do
    ~H"""
    <section class="">
      <div class="flex flex-col space-y-4 pt-8 lg:pt-12">
        <header class="flex flex-col lg:flex-row items-start justify-between text-white">
          <div class="flex flex-col space-y-4">
            <h1 class="text-[32px] md:text-[40px] font-bold ">Manage Ticket Sales</h1>
            <p class="text-[16px] md:text-[18px]">Track and manage sales for Summer Music Festival 2025 </p>
          </div>
          <div class="flex flex-col md:flex-row space-x-4">
            <button class="px-4 py-2 md:px-6 md:py-3 lg:px-8 lg:py-4 border-blue-700 text-blue-600 border-2 rounded-md cursor-pointer font-bold">
            <i class="fas fa-download w-4 h-4"></i>
            Export
            </button>
            <button class="group flex items-center space-x-2 px-4 py-2 md:px-6 md:py-3 lg:px-8 lg:py-4 border-blue-700 text-white border-2 bg-blue-700 rounded-md cursor-pointer font-bold transition-all duration-300">
            <i class="fas fa-arrow-up w-4 h-4 transform transition-transform duration-300 group-hover:rotate-45 "></i>
            <p>
              View Events
            </p>
            </button>
          </div>
        </header>
        <div class="flex flex-col md:flex-row items-center justify-between w-full text-white border-[1px] rounded-xl p-4">
          <div class="flex  space-x-2 items-center justify-center">
            <i class="fas fa-filter"></i>
            <p class="font-bold ">Filters</p>
          </div>
          <div>
          <div class="flex flex-wrap gap-4 items-center ">

          <div class="relative inline-block text-left">
            <div id="category-toggle" class="border-[1px] rounded-xl font-bold p-2 cursor-pointer flex items-center justify-between">
              <span id="selected-category">Category: All</span>
              <i class="fas fa-chevron-down ml-2 text-gray-700"></i>
            </div>
            <div id="category-dropdown" class="hidden absolute z-10 mt-2 w-40 bg-white border border-gray-200 rounded-xl shadow-lg">
              <ul class="py-2 text-sm text-gray-700">
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">All</li>
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">Technology</li>
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">Education</li>
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">Music</li>
              </ul>
            </div>
          </div>

          <div class="relative inline-block text-left">
            <div id="price-toggle" class="border-[1px] rounded-xl font-bold p-2 cursor-pointer flex items-center justify-between ">
              <span id="selected-price">Price: All</span>
              <i class="fas fa-chevron-down ml-2 text-gray-700"></i>
            </div>
            <div id="price-dropdown" class="hidden absolute z-10 mt-2 w-24 bg-white border border-gray-200 rounded-xl shadow-lg">
              <ul class="py-2 text-sm text-gray-700">
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">All</li>
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">Free</li>
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">Paid</li>
              </ul>
            </div>
          </div>

          <div class="relative inline-block text-left">
            <div id="sort-toggle" class="border-[1px] rounded-xl font-bold p-2 cursor-pointer flex items-center justify-between w-48 ">
              <span id="selected-sort">Sort: Recent</span>
              <i class="fas fa-chevron-down ml-2 text-gray-700"></i>
            </div>
            <div id="sort-dropdown" class="hidden absolute z-10 mt-2 w-48 bg-white border border-gray-200 rounded-xl shadow-lg">
              <ul class="py-2 text-sm text-gray-700">
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">Recent</li>
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">Oldest</li>
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">Lowest Price</li>
                <li class="dropdown-item px-4 py-2 hover:bg-gray-100 cursor-pointer">Highest Price</li>
              </ul>
            </div>
          </div>
        </div>
          </div>
        </div>

      </div>
    </section>
    """
  end

  def analytics_card(assigns)do
    ~H"""
      <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
      <%!-- total sales --%>
        <div class="px-3 py-6 space-y-2 border-[1px] border-white rounded-md">
          <div class="flex space-x-2 items-center">
            <i class="fas fa-dollar-sign text-white"></i>
          <p class="text-gray-700">Total Sales</p>
          </div>
          <div class="space-y-4 flex flex-col ">
            <h2 class="text-[24px] md:text-[32px] font-bold text-white">KES 254,250</h2>
            <p class="text-green-500">
            +12.5% from last week</p>
          </div>
        </div>

         <%!-- Tickets --%>
        <div class="px-3 py-6 space-y-2 border-[1px] border-white rounded-md">
          <div class="flex space-x-2 items-center">
            <i class="fas fa-ticket-alt text-white "></i>
          <p class="text-gray-700">Tickets Sold</p>
          </div>
          <div class="space-y-4 flex flex-col ">
            <h2 class="text-[24px] md:text-[32px] font-bold text-white">128</h2>
            <p class="text-green-500">
            +8.5% from last week</p>
          </div>
        </div>
        <%!-- price --%>
        <div class="px-3 py-6 space-y-2 border-[1px] border-white rounded-md">
            <div class="flex space-x-2 items-center">
            <i class="fas fa-tags text-white"></i>
          <p class="text-gray-700">Average Price</p>
          </div>
          <div class="space-y-4 flex flex-col ">
            <h2 class="text-[24px] md:text-[32px] font-bold text-white">KES 254,250</h2>
            <p class="text-gray-500">
            per ticket</p>
          </div>
        </div>
        <%!-- Event --%>
        <div class="px-3 py-6 space-y-2 border-[1px] border-white rounded-md">
          <div class="flex space-x-2 items-center">

            <i class="fas fa-calendar text-white"></i>
          <p class="text-gray-700">Total Sales</p>
          </div>
          <div class="space-y-4 flex flex-col ">
            <h2 class="text-[24px] md:text-[32px] font-bold text-white">July 15,2025</h2>
            <p class="text-green-500">
            34 days remaining</p>
          </div>
        </div>

      </div>
    """
  end

  def sales_analytics(assigns)do
    ~H"""
    <section class="border-2 border-white px-4 h-screen rounded-sm border-[1px]">
      <div class="mx-auto flex flex-col space-y-4">
        <div class="flex flex-col space-y-4 py-8 lg:py-12">
          <header class="flex flex-col lg:flex-row items-start justify-between text-white">
            <div class="flex flex-col space-y-4">
              <h1 class="text-[32px] md:text-[40px] font-bold ">Sales Overview</h1>
            </div>
            <div class="flex items-center space-x-4">
            <p class="text-[16px] md:text-[18px] font-bold">Timeframe: </p>
            <button class="px-4 py-2 md:px-6 md:py-3 lg:px-6 lg:py-4 border-blue-700 text-blue-600 border-2 rounded-md cursor-pointer font-bold flex space-x-2 items-center">
              <p>Last 7 days</p>
              <i class="fas fa-chevron-down ml-2 text-blue-700"></i>
             </button>
            </div>
          </header>
          <div class="w-full h-[50vh] border-[1px] border-dashed border-gray-400 rounded-md">
            <div class="flex flex-col items-center justify-center h-full space-y-4">
              <i class="fas fa-chart-line text-gray-500 text-[40px] bg-slate-800 rounded-full p-4 text-white"></i>
              <p class="text-white text-center">Sales chart visualisation would appear here</p>
            </div>
          </div>
        </div>
      </div>
      </section>
    """
  end

  def create_event(assigns)do
    ~H"""
    <section class="w-full py-20 bg-black h-auto">
      <div class="w-full max-w-[90%] mx-auto">
        <div class="w-full flex flex-col space-y-4 text-white text-center py-8 md:py-12">
          <h1 class="text-[32px] md:text-[40px] font-bold">Create a New Event</h1>
          <div class="max-w-[60%] mx-auto w-full">
            <p class="text-[14px] md:text-[18px]">
            Let's start by selecting the type of event you're organizing. This will help us customize the setup process for your specific needs
            </p>
          </div>
        </div>
        <div class="flex flex-col space-y-4 text-white">
          <div class="w-full">
          <h3 class="text-[20px] md:text-[24px] font-bold ">What type of event are you creating?</h3>
          </div>
          <div class="">

          </div>
        </div>
      </div>
    </section>
    """
  end


end
