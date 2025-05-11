defmodule SkygardenWeb.CheckoutLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok,socket}
  end

  def render(assigns) do
    ~H"""
    <div>
    <h1>
    Checkout
    </h1>
    <p>
    Secure your tickets in ust a few steps
    </p>
    <%!-- contact information --%>
    <div>
    <h1>Contact information</h1>
    <p>First Name</p>
    <p>Last Name</p>
    <p>Email Address</p>
    <p>We'll send the tickets to this email address</p>
    <p>Phone Number</p>
    </div>
    <%!-- Payment methods --%>
    <%!-- order summary --%>
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
            Complete Purchase
          </.link>
        </aside>
      </div>
    </div>
    """
  end

end
