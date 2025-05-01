defmodule SkygardenWeb.BrowseEvents.BrowseEvents do
  use Phoenix.Component
  use Phoenix.VerifiedRoutes, endpoint: SkygardenWeb.Endpoint, router: SkygardenWeb.Router

  def event_layout(assigns) do
    assigns =
      assign(assigns, :events, [
        %{
          id: 1,
          img: "https://via.placeholder.com/400x200",
          name: "Tech Conference",
          location: "Central Park, Nairobi",
          date: "Apr 04, 2025",
          time: "12:00 PM",
          price: "KES 1,500"
        },
        %{
          id: 2,
          img: "https://via.placeholder.com/400x200",
          name: "Comic Con 2025",
          location: "Central Park, Nairobi",
          date: "Apr 04, 2025",
          time: "12:00 PM",
          price: "KES 1,500"
        },
        %{
          id: 3,
          img: "https://via.placeholder.com/400x200",
          name: "African Cup Of Nations 2025",
          location: "Central Park, Nairobi",
          date: "Apr 04, 2025",
          time: "12:00 PM",
          price: "KES 1,500"
        },
        %{
          id: 4,
          img: "https://via.placeholder.com/400x200",
          name: "December Music Fest 2025",
          location: "Central Park, Nairobi",
          date: "Apr 04, 2025",
          time: "12:00 PM",
          price: "KES 1,500"
        },
        %{
          id: 5,
          img: "https://via.placeholder.com/400x200",
          name: "African Cup Of Nations 2025",
          location: "Central Park, Nairobi",
          date: "Apr 04, 2025",
          time: "12:00 PM",
          price: "KES 1,500"
        },
        %{
          id: 6,
          img: "https://via.placeholder.com/400x200",
          name: "Tech Conference",
          location: "Central Park, Nairobi",
          date: "Apr 04, 2025",
          time: "12:00 PM",
          price: "KES 1,500"
        }
      ])

    ~H"""
    <!-- Top Navigation Bar -->
    <div class="flex items-center justify-between px-6 py-10 bg-white">
      <!-- Left -->
      <div class="flex items-center space-x-6 text-[#5D3FD3] font-semibold text-sm">
        <span>SKY Tickets</span>
      </div>
      <!-- Center -->
      <div class="flex items-center space-x-6 font-semibold text-xs">
        <span>BROWSE EVENTS</span>
        <div class="relative group">
          <span class="cursor-pointer flex items-center">
            CATEGORIES
            <svg class="ml-1 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
          </span>
          <div class="absolute left-0 mt-2 w-40 bg-white border rounded-md shadow-md opacity-0 group-hover:opacity-100 transition-opacity duration-200 z-10">
            <ul>
              <li class="px-4 py-2 hover:bg-gray-100 cursor-pointer">Category 1</li>
              <li class="px-4 py-2 hover:bg-gray-100 cursor-pointer">Category 2</li>
              <li class="px-4 py-2 hover:bg-gray-100 cursor-pointer">Category 3</li>
            </ul>
          </div>
        </div>
        <span>RESOURCES</span>
      </div>
      <!-- Right -->
      <div class="flex space-x-3">
        <button class="bg-white text-[#5D3FD3] border border-[#5D3FD3] px-4 py-2 rounded text-xs font-medium hover:bg-[#5D3FD3] hover:text-white transition-colors">
          CREATE EVENT
        </button>
        <button class="bg-[#5D3FD3] text-white px-4 py-2 rounded text-xs font-medium">
          SIGN IN
        </button>
      </div>
    </div>

    <!-- Events Header + Search -->
    <div class="flex items-center justify-between px-6 py-6 bg-white">
      <div>
        <h1 class="text-3xl font-bold text-gray-900">Events</h1>
        <p class="text-sm text-black">discover and book amazing events</p>
      </div>
      <div class="flex items-center space-x-2 w-full max-w-xl">
        <div class="flex items-center px-3 py-2 bg-white w-full border rounded">
          <input
            type="text"
            placeholder="Search events, venue or artist"
            class="w-full bg-white outline-none text-sm text-gray-800"
          />
          <svg class="w-5 h-5 text-gray-400 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M21 21l-4.35-4.35M16 10a6 6 0 11-12 0 6 6 0 0112 0z" />
          </svg>
        </div>
        <button class="bg-[#5D3FD3] text-white px-4 py-2 rounded text-sm font-medium hover:bg-[#4b30ad]">
          Search
        </button>
      </div>
    </div>

    <!-- Filters -->
    <div class="flex items-center justify-between px-4 py-3 border border-gray-300 rounded-md bg-white mx-6 mt-4">
      <div class="flex items-center space-x-2 text-black text-sm font-medium">
        <svg class="w-5 h-5 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
            d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2a1 1 0 01-.293.707L15 13.414V19a1 1 0 01-1.447.894l-4-2A1 1 0 019 17v-3.586L3.293 6.707A1 1 0 013 6V4z" />
        </svg>
        <span>Filters</span>
      </div>
      <div class="flex items-center space-x-4 text-sm font-semibold">
        <div class="relative">
          <button class="flex items-center border border-gray-300 rounded px-3 py-2 bg-white text-black">
            Category: All
            <svg class="ml-2 w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
          </button>
        </div>
        <div class="relative">
          <button class="flex items-center border border-gray-300 rounded px-3 py-2 bg-white text-black">
            Price: All
            <svg class="ml-2 w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
          </button>
        </div>
        <div class="relative">
          <button class="flex items-center border border-gray-300 rounded px-3 py-2 bg-white text-black">
            Sort: Relevance
            <svg class="ml-2 w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
          </button>
        </div>
      </div>
    </div>

    <!-- Events Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 px-6 py-8">
      <%= for event <- @events do %>
        <div class="relative bg-white border border-gray-200 rounded-lg shadow hover:shadow-md transition-shadow duration-200">
          <img src={event.img} alt={event.name} class="w-full h-48 object-cover rounded-t-lg" />
          <div class="p-4 space-y-2">
            <h3 class="text-lg font-semibold text-gray-800"><%= event.name %></h3>

            <div class="flex items-center text-sm text-gray-600 space-x-2">
              <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M17.657 16.657L13 21.314 8.343 16.657a8 8 0 1111.314 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
              <span><%= event.location %></span>
            </div>

            <div class="flex items-center text-sm text-gray-600 space-x-2">
              <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M8 7V3m8 4V3m-9 8h10m-9 5h.01M4 5h16a2 2 0 012 2v12a2 2 0 01-2 2H4a2 2 0 01-2-2V7a2 2 0 012-2z" />
              </svg>
              <span><%= event.date %> • <%= event.time %></span>
            </div>

            <div class="flex items-center justify-between pt-2">
              <span class="text-sm font-medium text-[#5D3FD3]"><%= event.price %></span>
              <.link navigate={~p"/browse-events/#{event.id}"} class="bg-white text-[#5D3FD3] px-4 py-1.5 text-sm rounded hover:bg-[#5D3FD3] hover:text-white transition-colors">
                View Details
              </.link>
            </div>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
