defmodule SkygardenWeb.EventsDetailsLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, action: "details")} 
  end

  def handle_event("set_action", %{"action" => action}, socket) do
    {:noreply, assign(socket, action: action)}
  end

  def render(assigns) do
  ~H"""
    <%!-- Hero Section --%>
    <section class="relative w-full h-[700px] bg-cover bg-center" style="background-image: url(/images/eventshero.jpg)">
      <div class="absolute inset-0 bg-black bg-opacity-40"></div>
      <div class="relative z-10 flex flex-col justify-end h-full px-6 pt-6 pb-8">
        <.link navigate="/browse-events" class="px-6 py-4 text-white text-xs flex items-center mb-4 hover:underline">
          ← Back to Events
        </.link>
      </div>
    </section>


    <div class="relative bg-gradient-to-b from-white/10 to-white pb-16">
      <div class="max-w-7xl mx-auto flex flex-col lg:flex-row gap-8 px-4 lg:px-8 -mt-16">

        <%!--Event Details --%>
        <div class="flex-1 rounded-xl  p-8">
          <span class="inline-block bg-gray-100 text-[#5D3FD3] text-xs px-3 py-1 rounded-full mb-4">Technology</span>
          <h1 class="text-3xl lg:text-4xl font-bold text-gray-900 mb-2">Tech Conference 2025</h1>
          <div class="flex items-center text-gray-500 text-sm mb-6">
            <span>15 May · 10:00 – 18:00</span>
            <span class="mx-2">|</span>
            <span>Nairobi, Kenya</span>
          </div>

          <%!-- Wizard Tabs --%>
                <div class="flex justify-between bg-gray-200 rounded-xl p-2 mb-6 font-semibold">
                  <div class="flex-1">
                    <button phx-click="set_action" phx-value-action="details"
                            class={"w-full text-sm px-4 py-2 rounded-xl transition #{if @action == "details", do: "bg-white text-black", else: "text-gray-800"}"}>
                      Details
                    </button>
                  </div>
                  <div class="flex-1 text-center">
                    <button phx-click="set_action" phx-value-action="organizer"
                            class={"w-full text-sm px-4 py-2 rounded-xl transition #{if @action == "organizer", do: "bg-white text-black", else: "text-gray-800"}"}>
                      Organizer
                    </button>
                  </div>
                  <div class="flex-1 text-right">
                    <button phx-click="set_action" phx-value-action="faq"
                            class={"w-full text-sm px-4 py-2 rounded-xl transition #{if @action == "faq", do: "bg-white text-black", else: "text-gray-800"}"}>
                      FAQ
                    </button>
                  </div>
                </div>

                <%!-- Conditional Tab Sections --%>
                <%= if @action == "details" do %>
                <h2 class="text-lg font-semibold text-gray-800 mb-2">About This Event</h2>
                  <p class="text-gray-600 mb-6">
                    The premier tech conference for developers, designers, and tech enthusiasts.
                    Learn from the industry leaders, network with peers, and explore the latest innovations.
                  </p>
                  <h2 class="text-lg font-semibold text-gray-800 mb-2">Event Details</h2>
                  <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 text-sm text-black">
                    <div class="bg-gray-200 rounded-lg p-4 w-full h-15 flex flex-col justify-center">
                      <div class="font-semibold ">Date & Time</div>
                      <div>15 May · 10:00 – 18:00</div>
                    </div>
                    <div class="bg-gray-200 rounded-lg p-4 w-full h-15 flex flex-col justify-center">
                      <div class="font-semibold">Location</div>
                      <div>Nairobi, Kenya</div>
                    </div>
                    <div class="bg-gray-200 rounded-lg p-4 w-full h-15 flex flex-col justify-center">
                      <div class="font-semibold">Category</div>
                      <div>Technology</div>
                    </div>
                    <div class="bg-gray-200 rounded-lg p-4 w-full h-15 flex flex-col justify-center">
                      <div class="font-semibold">Attendees</div>
                      <div>5500 people</div>
                    </div>
                  </div>
                <% end %>

                <%= if @action == "organizer" do %>
                <div class="p-4 bg-white rounded-xl border border-gray-400 w-fit">
                  <div class="w-fit">
                    <h1 class="text-xl font-bold">Google Inc</h1>
                    <h2 class="text-gray-600 text-sm mb-4">Event Organizer</h2>
                  </div>
                  <p class="text-black mb-2 text-sm max-w-md">
                    Google is a leading global tech company that helps people find information, connect, and get things done through tools like Search, Youtube, Gmail, and Android.
                  </p>
                  <button class="bg-white text-gray-600 px-4 py-2 rounded text-xs font-medium border border-gray-400">
                    Follow Organizer
                  </button>
                  </div>

                  <div class="rounded-lg p-4 w-fit flex flex-col justify-center">
                    <h1 class="font-semibold text-lg mb-2">Contact Information</h1>
                    <p class="text-sm mb-1">contact@googleinc.com</p>
                    <p class="text-sm mb-1">+2548093224871</p>
                    <p class="text-sm">www.googleinc.com</p>
                  </div>
                <% end %>

                <%= if @action == "faq" do %>
                  <div class="p-4 bg-white border-b">
                    <h1 class="text-sm font-semibold mb-2 ">What is the refund policy?</h1>
                    <p class="text-gray-600 mb-6">Refunds are available up to 7 days before the event. After that, tickets can not be refunded but can be transferred to another person</p>
                  </div>
                  <div class="p-4 bg-white border-b">
                    <h1 class="text-sm font-semibold mb-2">Is there a packing space?</h1>
                  </div>
                  <div class="p-4 bg-white border-b">
                    <h1 class="text-sm font-semibold mb-2">Are there age restrictions?</h1>
                  </div>
                  <div class="p-4 bg-white border-b">
                    <h1 class="text-sm font-semibold mb-2">Do I have to be employed?</h1>
                  </div>
                  <div class="p-4 bg-white border-b">
                    <h1 class="text-sm font-semibold mb-2">Will the event be recorded?</h1>
                  </div>
                  <div class="p-4 bg-white">
                    <h1 class="text-xl font-bold mb-2">Still have questions?</h1>
                    <p>If you couldn't find the answer to your question in our FAQ, please contact us directly and we'll be happy to help.</p>
                  </div>
                  <button class="bg-white text-gray-600 px-4 py-2 rounded text-xs font-medium border border-gray-400">
                    Follow Organizer
                  </button>
                <% end %>
              </div>

        <%!--Ticket Card --%>
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
              class="w-[50%] mt-2 bg-[#5D3FD3] text-white font-semibold py-2 px-4 rounded hover:bg-white hover:text-[#5D3FD3] hover:border-[#5D3FD3] border transition duration-300 text-center"
            >
              Buy Ticket
            </.link>
        </aside>
      </div>
    </div>
  """
  end
end
