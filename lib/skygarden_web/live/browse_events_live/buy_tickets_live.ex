defmodule SkygardenWeb.BuyTicketsLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col lg:flex-row gap-8 w-full px-4 lg:px-12 py-6">
      <!-- Select Tickets -->
      <div class="w-full lg:w-2/3 space-y-6">
        <div class="border rounded p-4">
          <h1 class="font-bold text-lg mb-2">Select Tickets</h1>
          <h2 class="text-sm text-gray-600">Tech Conference 2025</h2>
          <h1 class="text-3xl lg:text-4xl font-bold text-gray-900 mb-2">Tech Conference 2025</h1>
          <div class="flex items-center text-gray-500 text-sm mb-6">
            <span>15 May · 10:00 – 18:00</span>
            <span class="mx-2">|</span>
            <span>Nairobi, Kenya</span>
          </div>

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
        </div>
      </div>

      <!-- Order Summary -->
      <div class="w-full lg:w-1/3 flex justify-end">
        <aside class="lg:w-[360px] w-full lg:sticky lg:top-6 bg-white rounded-xl shadow-lg border border-gray-200 p-6 flex flex-col gap-6">
          <h3 class="text-lg font-semibold text-gray-900 mb-2">Order Summary</h3>

          <div class="space-y-4">
            <div class="border border-gray-200 rounded-lg p-4">
              <div class="flex justify-between mb-1">
                <span class="font-semibold"> Standard Pass</span>
                <span class="text-[#5D3FD3] font-semibold">KES 4400</span>
              </div>
            </div>

            <div class="border border-gray-200 rounded-lg p-4">
              <div class="flex justify-between mb-1">
                <span class="font-semibold">Ultimate Experience</span>
                <span class="text-[#5D3FD3] font-semibold">KES 4500</span>
              </div>
            </div>
          </div>

          <.link
            navigate={"/browse-events/buy-tickets"}
            class="mt-2 bg-[#5D3FD3] text-white font-semibold py-2 px-4 rounded hover:bg-white hover:text-[#5D3FD3] hover:border-[#5D3FD3] border transition duration-300 text-center"
          >
            Proceed to checkout
          </.link>
        </aside>
      </div>
    </div>
    """
  end
end
