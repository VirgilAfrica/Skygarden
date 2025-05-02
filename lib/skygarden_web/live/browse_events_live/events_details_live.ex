defmodule SkygardenWeb.EventsDetailsLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
  ~H"""
    <%!-- hero section --%>
    <div class="w-full h-full bg-cover bg-center h-screen" style="background-image: url(/images/eventshero.jpg)">
      <div class="flex items-center space-x-6 text-white font-semibold px-6 py-10 text-sm">
         <h1>Back To Events</h1>
      </div>
    </div>


      <div class="relative">
      <div class="absolute inset-0 bg-gradient-to-b from-white to-white opacity-10"></div>
      <div class="relative z-20 flex w-full justify-between px-6 gap-6">
      <div class="w-[60%]">
        <%!-- About Event & Event Details Section --%>
        <div class="w-full h-full bg-cover bg-center h-screen py-10 ">
          <div>
            <h1 class="flex  text-black font-semibold px-6 text-sm">
              About This Event
            </h1>
            <h2 class="flex items-center w-[65%] text-black px-6 text-xs">
              The premier tech conference for developers, designers, and tech enthusiasts.
              Learn from the industy leaders, network with peers, and explore the latest
              innovations.
            </h2>
          </div>
          <div>
            <h1 class="flex text-black font-semibold px-6 py-10 text-sm">
              Event Details
            </h1>
          </div>

          <div class="">
          </div>
        </div>
      </div>
      </div>

      <%!-- Get Tickets --%>
          <div class="w-[36%] flex flex-col items-start shadow-md rounded-lg p-4 m-4 space-y-4">
            <h1 class="text-black font-semibold text-sm">Get Tickets</h1>

            <div class="flex flex-col border border-gray-300 rounded-lg p-3 space-y-2">
              <div class="flex justify-between">
                <h1 class="text-black font-semibold text-sm">Standard Pass</h1>
                <p class="text-[#5D3FD3] font-semibold text-sm">KES 2200</p>
              </div>
              <p class="text-black text-sm">Access to all talks and exhibition area. 5000 Tickets Available</p>
            </div>

            <div class="flex flex-col border border-gray-300 rounded-lg p-3 space-y-2">
              <div class="flex justify-between">
                <h1 class="text-black font-semibold text-sm">Business Pass</h1>
                <p class="text-[#5D3FD3] font-semibold text-sm">KES 4500</p>
              </div>
              <p class="text-black text-sm">Standard access plus networking events and lunch. 800 tickets available</p>
            </div>

            <div class="flex flex-col border border-gray-300 rounded-lg p-3 space-y-2">
              <div class="flex justify-between">
                <h1 class="text-black font-semibold text-sm">Ultimate Experience</h1>
                <p class="text-[#5D3FD3] font-semibold text-sm">KES 10000</p>
              </div>
              <p class="text-black text-sm">All access including VIP lounge and exclusive sessions with other perks. 100 tickets available</p>
            </div>

            <.link
              navigate={"/browse-events/buy-tickets"}
              class="mt-4 bg-[#5D3FD3] text-white font-semibold py-2 px-4 rounded
                    hover:bg-white hover:text-[#5D3FD3] hover:border-[#5D3FD3] border transition duration-300"
            >
              Buy Tickets
            </.link>
          </div>


      </div>




  """
  end

end
