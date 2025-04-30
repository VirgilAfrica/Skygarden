defmodule SkygardenWeb.Landing.LandingLayout do
  use Phoenix.Component

  def landing_layout(assigns) do
    ~H"""
    <section class="w-full h-auto">
      <.hero_section />
      <.top_concerts />
      <.top_festivals />
      <.top_experiences />
      <.top_conferences />
      <.browse_category />
      <.events_list />
      <.get_started />
    </section>
    """
  end

  def hero_section(assigns) do
    ~H"""
    <section class="hidden dark:block dark:w-full dark:h-[80vh] dark:lg:h-screen dark:relative dark:overflow-hidden">
      <video
        class="dark:absolute dark:top-0 dark:left-0 dark:w-full dark:h-full  dark:object-cover dark:z-0"
        src="/images/landing/landing.mp4"
        autoplay
        loop
        muted
        playsinline
      >
      </video>
      <div class=" dark:absolute dark:top-0 dark:left-0 dark:w-full dark:h-full dark:bg-black/50 dark:z-10">
      </div>
      <div class="dark:max-w-[90%] dark:mx-auto dark:relative dark:z-20">
        <div class="dark:absolute dark:top-64 dark:md:top-56 dark:lg:top-40 dark:z-40">
          <.latest_event_card />
        </div>
      </div>
    </section>

    <section class="dark:hidden flex flex-col lg:flex-row items-start justify-between w-full h-auto lg:h-screen bg-[#5D3FD31A] px-4 py-8">
      <div class="max-w-[90%] mx-auto flex flex-col lg:flex-row items-start justify-between w-full space-y-8 lg:space-y-0 lg:space-x-12">
        <div class="w-full lg:w-1/2 flex flex-col space-y-6">
          <span class="inline-block py-2 px-4 bg-blue-200 rounded-full max-w-max">
            <p class="text-[10px] md:text-[12px] text-[#5D3FD3] font-medium">Discover Events</p>
          </span>

          <h1 class="text-[32px] md:text-[56px] font-bold leading-tight">
            Find your next experience.
          </h1>

          <p class="text-[16px] md:text-[18px] max-w-md">
            Discover our handpicked top 10 concerts in Kenya events worth checking out
          </p>

          <div class="flex  md:flex-row space-x-4  sm:space-y-0 w-full max-w-md ">
            <div class="relative flex-grow">
              <input
                type="text"
                placeholder="Search Events, venue or artists"
                class="w-full rounded-full p-4  placeholder:text-blue-300 placeholder:text-[12px] md:placeholder:text-[16px] bg-transparent border border-gray-300 caret-blue-700 focus:outline-2 focus:outline-blue-300"
              />
              <span class="absolute inset-y-0 right-4 flex items-center pointer-events-none text-blue-300">
                <i class="fas fa-search"></i>
              </span>
            </div>
            <button class="bg-blue-700 text-white md:px-6 md:py-3 rounded-full font-semibold text-[12px] md:text-[16px] px-4 py-2 lg:px-8 lg:py-4">
              Search
            </button>
          </div>

          <div class="flex flex-col space-y-2">
            <h4 class="font-medium text-black">Popular Categories:</h4>
            <ul class="flex flex-wrap space-x-4 text-blue-500">
              <li class="cursor-pointer underline underline-offset-4 hover:text-white">Music</li>
              <li class="cursor-pointer underline underline-offset-4 hover:text-white">Technology</li>
              <li class="cursor-pointer underline underline-offset-4 hover:text-white">Concert</li>
              <li class="cursor-pointer underline underline-offset-4 hover:text-white">Art</li>
            </ul>
          </div>
        </div>

        <div class="w-full lg:w-1/2 flex justify-center items-center">
          <.hero_event_card />
        </div>
      </div>
    </section>
    """
  end

  def top_concerts(assigns) do
    ~H"""
    <section class="w-full  mx-auto max-w-[90%] flex flex-col justify-between items-center">
      <div class="w-full flex flex-col space-y-4 items-start justify-start py-8 md:py-12">
        <div class="w-full flex flex-col lg:flex-row items-start justify-between">
          <div class="flex flex-col space-y-2">
            <h1 class="flex space-y-2 text-[24px] md:text-[32px] font-bold">
              Top 10 concerts in Kenya today
            </h1>
            <p>Discover our handpicked top 10 concerts in Kenya events worth checking out</p>
          </div>
          <div class="flex items-center justify-center">
            <button class="text-blu">
              View all events
            </button>
          </div>
        </div>
      </div>
      <div class="w-full overflow-x-auto grid lg:grid-cols-5 gap-4 w-full place-items-center">
        <%= for concert <- concert_images() do %>
          <img src={concert} alt={concert} class="w-full lg:w-56 h-56 rounded-md cursor-pointer" />
        <% end %>
      </div>
    </section>
    """
  end

  def top_festivals(assigns) do
    ~H"""
    <section class="w-full  mx-auto max-w-[90%] flex flex-col justify-between items-center">
      <div class="w-full flex flex-col space-y-4 items-start justify-start py-8 md:py-12">
        <div class="w-full flex flex-col lg:flex-row items-start justify-between">
          <div class="flex flex-col space-y-2">
            <h1 class="flex space-y-2 text-[24px] md:text-[32px] font-bold">
              Top 10 Festivals in Kenya today
            </h1>
            <p>Discover our handpicked top 10 concerts in Kenya events worth checking out</p>
          </div>
          <div class="flex items-center justify-center">
            <button class="text-blu">
              View all events
            </button>
          </div>
        </div>
      </div>
      <div class="w-full overflow-x-auto grid lg:grid-cols-5 gap-4 w-full place-items-center">
        <%= for concert <- concert_images() do %>
          <img src={concert} alt={concert} class="w-full lg:w-56 h-56 rounded-md cursor-pointer" />
        <% end %>
      </div>
    </section>
    """
  end

  def top_experiences(assigns) do
    ~H"""
    <section class="w-full  mx-auto max-w-[90%] flex flex-col justify-between items-center">
      <div class="w-full flex flex-col space-y-4 items-start justify-start py-8 md:py-12">
        <div class="w-full flex flex-col lg:flex-row items-start justify-between">
          <div class="flex flex-col space-y-2">
            <h1 class="flex space-y-2 text-[24px] md:text-[32px] font-bold">
              Top 10 experiences in Kenya today
            </h1>
            <p>Discover our handpicked top 10 concerts in Kenya events worth checking out</p>
          </div>
          <div class="flex items-center justify-center">
            <button class="text-blu">
              View all events
            </button>
          </div>
        </div>
      </div>
      <div class="w-full overflow-x-auto grid lg:grid-cols-5 gap-4 w-full place-items-center">
        <%= for concert <- concert_images() do %>
          <img src={concert} alt={concert} class="w-full lg:w-56 h-56 rounded-md cursor-pointer" />
        <% end %>
      </div>
    </section>
    """
  end

  def top_conferences(assigns) do
    ~H"""
    <section class="w-full  mx-auto max-w-[90%] flex flex-col justify-between items-center ">
      <div class="w-full flex flex-col space-y-4 items-start justify-start py-8 md:py-12">
        <div class="w-full flex flex-col lg:flex-row items-start justify-between">
          <div class="flex flex-col space-y-2">
            <h1 class="flex space-y-2 text-[24px] md:text-[32px] font-bold">
              Top 10 conferences in Kenya today
            </h1>
            <p>Discover our handpicked top 10 concerts in Kenya events worth checking
              out</p>
          </div>
          <div class="flex items-center justify-center">
            <button class="text-blu">
              View all events
            </button>
          </div>
        </div>
      </div>
      <div class="w-full overflow-x-auto grid md:grid-cols-3 lg:grid-cols-5 gap-4 w-full place-items-center">
        <%= for concert <- concert_images() do %>
          <img src={concert} alt={concert} class="w-full lg:w-56 h-56 rounded-md cursor-pointer" />
        <% end %>
      </div>
    </section>
    """
  end

  def latest_event_card(assigns) do
    ~H"""
    <div class="w-full h-auto  rounded-lg p-2 lg:p-4 flex flex-col space-y-4">
      <span class="w-1/4 py-2 px-4 bg-[#F7F8FA] rounded-full">
        <p class="w-auto text-[8px] md:text-[12px] text-[#5D3FD3] font-medium">
          Latest Event
        </p>
      </span>
      <span class="text-whit flex flex-row space-x-2">
        <%!-- fontawesome icon --%>
        <i class="fa-solid fa-calendar-days text-white"></i>
        <p class="font-medium">Apr 04, 2025 · 12:00 PM</p>
      </span>
      <h1 class="text-[24px] md:text-[32px] font-semibold text-whit">Summer Music Festival 2025</h1>
      <p class="text-[14px] md:text-[16px] text-whit">Central Park,Nairobi.</p>
      <div class="flex flex-row space-x-4 justify-between">
        <span class="flex flex-row space-x-4 text-whit items-center text-[12px] md:text-[14px] font-bold ">
          <p class="text-[12px] flex items-center justify-center">KES</p>
          <p class="text-[24px]">1,500.00</p>
        </span>
        <button class="bg-blue-700 font-semibold text-[#F7F8FA] px-4 py-2 rounded-md duration-300 ease-in hover:bg-blue-800">
          Get Ticket
        </button>
      </div>

      <div class="flex flex-col space-y-3">
        <h4 class="font-medium text-whit">Popular Categories:</h4>
        <ul class="flex flex-row space-x-2 text-blu">
          <li class="text-blu flex space-x-2 cursor-pointer">
            <p class="underline underline-offset-4 hover:text-whit">Music</p>
             <span>·</span>
          </li>
          <li class="text-blu flex space-x-2 cursor-pointer">
            <p class="underline underline-offset-4 hover:text-whit cursor-pointer">Technology</p>
             <span>·</span>
          </li>
          <li class="text-blu flex space-x-2 cursor-pointer">
            <p class="underline underline-offset-4 hover:text-whit cursor-pointer">Concert</p>
             <span>·</span>
          </li>
          <li class="text-blu flex space-x-2 cursor-pointer">
            <p class="underline underline-offset-4 hover:text-whit">Art</p>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  def browse_category(assigns) do
    ~H"""
    <section class="w-full h-auto bg-[#F7F8FA] py-8 my-8 lg:my-12">
      <div class="max-w-[90%] mx-auto flex flex-col space-y-4">
        <h1 class="text-center text-[24px] md:text-[32px] font-bold">Browse by Category</h1>
        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4 w-full">
          <%= for category <- category_data() do %>
            <.category_card category={category} />
          <% end %>
        </div>
      </div>
    </section>
    """
  end

  def events_list(assigns) do
    ~H"""
    <section class="w-full h-auto  py-8 my-8 lg:my-12">
      <div class="max-w-[90%] mx-auto flex flex-col space-y-4">
        <div class="flex flex-row items-center justify-between">
          <div class="flex flex-col space-y-2">
            <h1 class="text-[24px] md:text-[32px] font-bold">Events For You</h1>
            <p>Discover our handpicked events worth checking out</p>
          </div>
          <button class="text-blu">View all events</button>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-3 gap-4">
          <%= for event <- events_data() do %>
            <.event_card event={event} />
          <% end %>
        </div>
      </div>
    </section>
    """
  end

  def get_started(assigns) do
    ~H"""
    <section class="h-[50vh] w-full bg-blue-700 text-white py-20">
      <div class="max-w-[90%] mx-auto flex flex-col items-center justify-center space-y-4 h-full text-center">
        <h3 class="font-bold text-[32px] md:text-[40px]">Ready to create your own event?</h3>
        <p class="text-[16px] md:text-[18px] lg:max-w-[60%] mx-auto">
          Whether it's a concert, workshop, or conference, Sky Tickets has everything you need to organize and manage your event.
        </p>
        <button class="bg-[#F7F8FA] text-blue-500 font-semibold px-4 py-2 md:px-6 md:py-3 lg:px-8 lg:py-4 rounded-md duration-300 ease-in hover:bg-blue-600 hover:text-[#F7F8FA] uppercase">
          get started
        </button>
      </div>
    </section>
    """
  end

  defp concert_images do
    [
      "/images/landing/concert1.png",
      "/images/landing/concert2.png",
      "/images/landing/concert3.png",
      "/images/landing/concert4.png",
      "/images/landing/concert5.png"
    ]
  end

  def category_card(assigns) do
    ~H"""
    <div class="hover:-translate-y-[4px] duration-300 ease-in cursor-pointer bg-white rounded-md flex flex-col items-center justify-center space-y-4 p-4">
      <div class="rounded-full bg-[#5D3FD333] w-20 h-20 flex items-center justify-center">
        <%!-- laptop icon --%>
        <i class={@category.icon <> " text-[24px] text-blue-600"}></i>
      </div>
      <h4 class="font-bold">{@category.category}</h4>
      <p>{@category.events}</p>
    </div>
    """
  end

  def event_card(assigns) do
    ~H"""
    <div class="rounded-t-2xl bg-white w-full h-auto shadow-sm">
      <div
        class="relative bg-cover bg-center h-64 rounded-t-2xl"
        style="background-image: url('/images/landing/concert1.png');"
      >
        <div class="absolute rounded-t-2xl h-fit top-0 left-0 w-full h-full bg-black z-20"></div>
        <span class="absolute bg-blue-100 top-4 left-4 text-blu rounded-full p-2">
          <p class="font-medium text-[12px]">{@event.tag}</p>
        </span>
        <p class="absolute left-4 top-[80%] text-whit font-bold">{@event.title}</p>
      </div>
      <div class="max-w-[90%] mx-auto flex flex-col space-y-3 p-4">
        <span class="text-black flex flex-row space-x-2 items-center">
          <%!-- fontawesome icon --%>
          <i class="fa-solid fa-calendar-days text-black"></i>
          <p class="font-medium">Apr 04, 2025 · 12:00 PM</p>
        </span>
        <span class="items-center text-black flex flex-row space-x-2">
          <%!-- fontawesome icon --%>
          <i class="fa-solid fa-map-pin text-black"></i>
          <p class="font-medium">{@event.location}</p>
        </span>
        <div class="text-black flex flex-row justify-between items-start">
          <h4 class="font-medium">{@event.price}</h4>
          <button class="text-blu">View Details</button>
        </div>
      </div>
    </div>
    """
  end

  def hero_event_card(assigns) do
    ~H"""
    <div class="rounded-t-2xl bg-white w-full h-fit shadow-sm">
      <div
        class="relative bg-cover bg-center h-64 rounded-t-2xl"
        style="background-image: url('/images/landing/concert1.png');"
      >
        <div class="absolute rounded-t-2xl h-fit top-0 left-0 w-full h-full bg-black z-20"></div>
        <span class="absolute bg-blue-100 top-4 left-4 text-blu rounded-full p-2">
          <p class="font-medium text-[12px]">Upcoming</p>
        </span>
        <p class="absolute left-4 top-[80%] text-whit font-bold">Summer Music Festival 2025</p>
      </div>
      <div class="max-w-[90%] mx-auto flex flex-col space-y-3 p-4">
        <span class="text-black flex flex-row space-x-2 items-center">
          <%!-- fontawesome icon --%>
          <i class="fa-solid fa-calendar-days text-black"></i>
          <p class="font-medium">Apr 04, 2025 · 12:00 PM</p>
        </span>
        <span class="items-center text-black flex flex-row space-x-2">
          <%!-- fontawesome icon --%>
          <i class="fa-solid fa-map-pin text-black"></i>
          <p class="font-medium">Central Park, Nairobi</p>
        </span>
        <div class="text-black flex flex-row justify-between items-center">
          <h4 class="font-medium">KES 1,500</h4>
          <button class="bg-blu text-white px-4 py-2 rounded-md">Get Ticket</button>
        </div>
      </div>
    </div>
    """
  end

  defp category_data do
    [
      %{
        category: "Technology",
        # Laptop icon
        icon: "fa-solid fa-television",
        events: "10 Events",
        path: ""
      },
      %{
        category: "Music",
        # Music icon
        icon: "fa-solid fa-music",
        events: "10 Events",
        path: ""
      },
      %{
        category: "Art",
        # Art icon
        icon: "fa-solid fa-palette",
        events: "10 Events",
        path: ""
      },
      %{
        category: "Sport",
        # Sport icon
        icon: "fa-solid fa-running",
        events: "10 Events",
        path: ""
      },
      %{
        category: "Business",
        # Business icon
        icon: "fa-solid fa-briefcase",
        events: "10 Events",
        path: ""
      },
      %{
        category: "Health",
        # Health icon
        icon: "fa-solid fa-heartbeat",
        events: "10 Events",
        path: ""
      },
      %{
        category: "Entertainement",
        # Entertainment icon
        icon: "fa-solid fa-film",
        events: "10 Events",
        path: ""
      },
      %{
        category: "Food and Drinks",
        # Food and Drinks icon
        icon: "fa-solid fa-utensils",
        events: "10 Events",
        path: ""
      },
      %{
        category: "Comedy",
        # Comedy icon
        icon: "fa-solid fa-laugh-squint",
        events: "10 Events",
        path: ""
      },
      %{
        category: "Workshops",
        # Workshops icon
        icon: "fa-solid fa-tools",
        events: "10 Events",
        path: ""
      }
    ]
  end

  defp events_data do
    [
      %{
        tag: "Technology",
        title: "Tech Conference 2025",
        date: "Apr 04, 2025",
        time: "12:00 PM",
        location: "Central Park, Nairobi",
        price: "KES 1,500.00",
        image: "/images/landing/concert1.png"
      },
      %{
        tag: "Entertainment",
        title: "Music Festival 2025",
        date: "May 10, 2025",
        time: "2:00 PM",
        location: "Uhuru Park, Nairobi",
        price: "KES 2,000.00",
        image: "/images/landing/concert2.png"
      },
      %{
        tag: "Entertainment",
        title: "Music Festival 2025",
        date: "May 10, 2025",
        time: "2:00 PM",
        location: "Uhuru Park, Nairobi",
        price: "KES 2,000.00",
        image: "/images/landing/concert2.png"
      },
      %{
        tag: "Sport",
        title: "Music Festival 2025",
        date: "May 10, 2025",
        time: "2:00 PM",
        location: "Uhuru Park, Nairobi",
        price: "KES 2,000.00",
        image: "/images/landing/concert2.png"
      },
      %{
        tag: "sport",
        title: "Music Festival 2025",
        date: "May 10, 2025",
        time: "2:00 PM",
        location: "Uhuru Park, Nairobi",
        price: "KES 2,000.00",
        image: "/images/landing/concert2.png"
      },
      %{
        tag: "Technology",
        title: "Music Festival 2025",
        date: "May 10, 2025",
        time: "2:00 PM",
        location: "Uhuru Park, Nairobi",
        price: "KES 2,000.00",
        image: "/images/landing/concert2.png"
      }
    ]
  end
end
