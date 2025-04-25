defmodule SkygardenWeb.Common.NavbarComponent do
  use Phoenix.Component

  def navbar(assigns) do
    ~H"""
    <nav class=" dark:bg-[#0f0f0f] shadow-md">
  <div class="max-w-[90%] mx-auto flex items-center justify-between py-4">
    <a href="/" class="text-xl font-bold text-blue-500">Sky Tickets</a>
    <button id="navbar-toggle" class="md:hidden text-black dark:text-white focus:outline-none">
      <!-- Hamburger icon (three bars) -->
    <i class="fas fa-hamburger"></i>

    </button>
    <div id="navbar-menu" class="hidden md:flex flex-col md:flex-row items-center space-y-4 md:space-y-0 md:space-x-6 fixed md:static top-0 left-0 w-full md:w-auto bg-[#0f0f0f] md:bg-transparent z-50 p-4">
      <ul class="flex flex-col md:flex-row w-full md:w-auto">
        <li><a href="/events" class="text-black dark:text-white hover:text-blue-500 block px-4 py-2">Events</a></li>
        <li class="relative group" id="categories-menu">
          <a href="/categories" class="text-black dark:text-white  hover:text-blue-500 block px-4 py-2 flex items-center">
            Categories
            <svg class="ml-1 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M19 9l-7 7-7-7"/>
            </svg>
          </a>
          <ul class="dropdown-menu absolute left-0 top-full mt-2 bg-white text-black dark:text-white  text-black rounded shadow-lg min-w-[150px] hidden group-hover:block md:group-hover:block z-50">
            <li><a href="/categories/music" class="block px-4 py-2 hover:bg-blue-100">Music</a></li>
            <li><a href="/categories/sports" class="block px-4 py-2 hover:bg-blue-100">Sports</a></li>
            <li><a href="/categories/arts" class="block px-4 py-2 hover:bg-blue-100">Arts</a></li>
          </ul>
        </li>
        <li><a href="/upcoming" class="text-black hover:text-blue-500 block px-4 py-2 dark:text-white  ">Upcoming</a></li>
      </ul>
       <div class="lg:hidden flex flex-col md:flex-row space-y-2 md:space-y-0 md:space-x-4 w-full md:w-auto">
        <a href="/create_event" class="hover:text-blue-500 font-bold text-blue-700 border-[1px] border-blue-700 rounded-md px-4 py-2 text-blue-300 dark:hover:text-white dark:hover:border-white transition">Create Event</a>
        <a href="/register" class="bg-blue-700 text-white px-4 py-2 rounded hover:bg-blue-600 font-bold">Sign In</a>
      </div>
    </div>
     <div class="hidden lg:flex flex-col md:flex-row space-y-2 md:space-y-0 md:space-x-4 w-full md:w-auto">
        <a href="/login" class=" hover:text-blue-500 font-bold text-blue-700 border-[1px] border-blue-700 rounded-md px-4 py-2 dark:hover:text-white dark:hover:border-white transition">Create Event</a>
        <a href="/register" class="bg-blue-700 text-white px-4 py-2 rounded hover:bg-blue-600 font-bold">Sign In</a>
      </div>
  </div>
</nav>
    """
  end
end
