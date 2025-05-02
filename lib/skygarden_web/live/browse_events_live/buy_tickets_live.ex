defmodule SkygardenWeb.BuyTicketsLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full min-h-screen p-6 bg-gray-50">
      <h1 class="text-2xl font-bold text-[#5D3FD3] mb-4">Complete Your Ticket Purchase</h1>
      <p class="text-sm text-gray-700 mb-6">Please confirm your ticket selection and proceed with the payment process.</p>

      <button
        class="bg-[#5D3FD3] text-white font-semibold py-2 px-4 rounded hover:bg-white hover:text-[#5D3FD3] hover:border-[#5D3FD3] border transition duration-300"
        phx-click="continue"
      >
        Proceed to Payment
      </button>
    </div>
    """
  end
end
