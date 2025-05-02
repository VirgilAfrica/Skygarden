defmodule SkygardenWeb.EventsDetailsLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
  ~H"""
    <%!-- Hero Section --%>
    <section class="relative w-full h-[320px] bg-cover bg-center" style="background-image: url(/images/eventshero.jpg)">
      <div class="absolute inset-0 bg-black bg-opacity-40"></div>
      <div class="relative z-10 flex flex-col justify-end h-full px-6 pt-6 pb-8">
        <.link navigate="/browse-events" class="text-white text-xs flex items-center mb-4 hover:underline">
          ← Back to Events
        </.link>
        <%!-- Optionally, add hero title here if needed --%>
      </div>
    </section>

    <%!-- Main Content with Gradient Overlay --%>
    <div class="relative bg-gradient-to-b from-white/10 to-white pb-16">
      <div class="max-w-7xl mx-auto flex flex-col lg:flex-row gap-8 px-4 lg:px-8 -mt-16">

        <%!-- Left: Event Details --%>
        <div class="flex-1 rounded-xl  p-8">
          <span class="inline-block bg-gray-100 text-gray-700 text-xs px-3 py-1 rounded-full mb-4">Technology</span>
          <h1 class="text-3xl lg:text-4xl font-bold text-gray-900 mb-2">Tech Conference 2025</h1>
          <div class="flex items-center text-gray-500 text-sm mb-6">
            <span>15 May · 10:00 – 18:00</span>
            <span class="mx-2">|</span>
            <span>Nairobi, Kenya</span>
          </div>
          <h2 class="text-lg font-semibold text-gray-800 mb-2">About This Event</h2>
          <p class="text-gray-600 mb-6">
            The premier tech conference for developers, designers, and tech enthusiasts.
            Learn from the industry leaders, network with peers, and explore the latest innovations.
          </p>
          <h2 class="text-lg font-semibold text-gray-800 mb-2">Event Details</h2>
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 text-sm text-gray-700">
            <div>
              <div class="font-semibold">Date & Time</div>
              <div>15 May · 10:00 – 18:00</div>
            </div>
            <div>
              <div class="font-semibold">Location</div>
              <div>Nairobi, Kenya</div>
            </div>
            <div>
              <div class="font-semibold">Category</div>
              <div>Technology</div>
            </div>
            <div>
              <div class="font-semibold">Attendees</div>
              <div>5000+</div>
            </div>
          </div>
        </div>

        <%!-- Right: Ticket Card --%>
        <aside class="lg:w-[360px] w-full lg:sticky lg:top-8 bg-white rounded-xl shadow-lg border border-gray-200 p-6 flex flex-col gap-6">
          <h3 class="text-lg font-semibold text-gray-900 mb-2">Get Tickets</h3>
          <div class="space-y-4">
            <div class="border border-gray-200 rounded-lg p-4">
              <div class="flex justify-between mb-1">
                <span class="font-semibold">Standard Pass</span>
                <span class="text-[#5D3FD3] font-semibold">KES 2200</span>
              </div>
              <div class="text-gray-600 text-sm">Access to all talks and exhibition area. 5000 Tickets Available</div>
            </div>
            <div class="border border-gray-200 rounded-lg p-4">
              <div class="flex justify-between mb-1">
                <span class="font-semibold">Business Pass</span>
                <span class="text-[#5D3FD3] font-semibold">KES 4500</span>
              </div>
              <div class="text-gray-600 text-sm">Standard access plus networking events and lunch. 800 tickets available</div>
            </div>
            <div class="border border-gray-200 rounded-lg p-4">
              <div class="flex justify-between mb-1">
                <span class="font-semibold">Ultimate Experience</span>
                <span class="text-[#5D3FD3] font-semibold">KES 10000</span>
              </div>
              <div class="text-gray-600 text-sm">All access including VIP lounge and exclusive sessions with other perks. 100 tickets available</div>
            </div>
          </div>
          <.link
            navigate={"/browse-events/buy-tickets"}
            class="w-full mt-2 bg-[#5D3FD3] text-white font-semibold py-2 px-4 rounded hover:bg-white hover:text-[#5D3FD3] hover:border-[#5D3FD3] border transition duration-300 text-center"
          >
            Buy Ticket
          </.link>
        </aside>
      </div>
    </div>
  """
  end
end
