defmodule SkygardenWeb.Admin.WizardComponent do
  use Phoenix.Component
  
  def wizard_layout(assigns) do
    ~H"""
    <section class="w-full bg-black">
      <div class="w-full max-w-[90%] mx-auto py-10">
        <%= if @step == :select_type do %>
          <div class="lg:max-w-[50%] mx-auto">
            <h1 class="text-[32px] md:text-[40px] font-bold mb-2 text-white text-center">Create a New Event</h1>
            <p class="mb-8 text-gray-300 text-center">
              Let's start by selecting the type of event you're organizing.
            </p>
          </div>
          <form phx-submit="select_type">
            <h2 class="font-bold text-start text-white text-[20px] md:text-[24px] py-4">
              What type of event are you creating?
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
              <%= for {type, desc} <- @event_types do %>
                <label class={
                  "border rounded-lg p-8 cursor-pointer flex space-x-4 " <>
                  if @event_type == type, do: "border-violet-500 bg-violet-900/20", else: "border-gray-700"
                }>
                  <div>
                    <input
                      type="radio"
                      name="event_type"
                      value={type}
                      checked={@event_type == type}
                      class="mr-2"
                      required
                    />
                  </div>
                  <div>
                    <span class="font-semibold text-white text-[16px] md:text-[18px]"><%= type %></span>
                    <div class="text-gray-400 text-[14px] md:text-[16px] mt-2"><%= desc %></div>
                  </div>
                </label>
              <% end %>
            </div>
            <div class="flex justify-between">
              <button type="button" class="text-blue-600 font-bold bg-white md:px-6 md:py-3 px-4 py-2 lg:py-4 lg:px-8 rounded-md">Back</button>
              <button
                type="submit"
                class="bg-blue-600 text-white md:px-6 md:py-3 px-4 py-2 lg:py-4 lg:px-8 rounded-md rounded-md font-bold cursor-pointer hover:bg-blue-700 transition"
              >
                Continue
              </button>
            </div>
          </form>
        <% end %>

        <%= if @step == :event_details do %>
          <div class="w-full max-w-[90%] mx-auto">
            <h2 class="text[32px] md:text-[40px] font-bold mb-2 text-white text-center">Set Event Details</h2>
            <p class="mb-6 text-gray-300 text-center">Fill in the details about your event, location, and ticket pricing.</p>
            <form phx-submit="save_details" class="text-white">
              <input type="hidden" name="event[event_type]" value={@event_type} />

              <div class="mb-8">
                <h3 class="text-lg font-semibold mb-4">Basic Information</h3>
                <label class="block mb-4">
                  <span class="text-white block mb-1">Event Title</span>
                  <input name="event[name]" type="text" placeholder="e.g Summer Music Festival" class="w-full p-2 bg-black border border-gray-700 rounded text-white" required />
                </label>

                <label class="block mb-4">
                  <span class="text-white block mb-1">Event Description</span>
                  <textarea name="event[description]" rows="4" placeholder="Describe your event, what attendees should expect, and why they should attend." class="w-full p-2 bg-black border border-gray-700 rounded text-white" required></textarea>
                </label>
              </div>

              <div class="mb-8">
                <h3 class="text-lg font-semibold mb-4">Date and Time</h3>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                  <label class="block">
                    <span class="text-white block mb-1">Event Date</span>
                    <input name="date" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" required />
                  </label>

                  <label class="block">
                    <span class="text-white block mb-1">Start Time</span>
                    <input name="starttime" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" required />
                  </label>

                  <label class="block">
                    <span class="text-white block mb-1">End Time</span>
                    <input name="end_time" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" />
                  </label>
                </div>
              </div>

              <div class="mb-8">
                <h3 class="text-lg font-semibold mb-4">Location</h3>
                <label class="block mb-4">
                  <span class="text-white block mb-1">Venue Name</span>
                  <input name="event[location]" type="text" placeholder="e.g grand park nairobi, Kenya" class="w-full p-2 bg-black border border-gray-700 rounded text-white" required />
                </label>

                <label class="block mb-4">
                  <span class="text-white block mb-1">Address</span>
                  <input name="event[address]" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" placeholder="0412-9002" />
                </label>

                <div class="grid grid-cols-3 gap-4">
                  <label class="block">
                    <span class="text-white block mb-1">City</span>
                    <input name="event[city]" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" placeholder="Nairobi" />
                  </label>
                  <label class="block">
                    <span class="text-white block mb-1">State</span>
                    <input name="event[state]" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" placeholder="CBD" />
                  </label>
                  <label class="block">
                    <span class="text-white block mb-1">Zip/Postal Code</span>
                    <input name="event[zip]" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" placeholder="00100" />
                  </label>
                </div>
              </div>

              <div class="mb-8">
                <h3 class="text-lg font-semibold mb-4">Tickets and Pricing</h3>
                <label class="block mb-4">
                  <span class="text-white block mb-1">Event Capacity</span>
                  <input name="event[capacity]" type="text" placeholder="Leave blank for unlimited capacity" class="w-full p-2 bg-black border border-gray-700 rounded text-white" />
                </label>
                <div class="grid grid-cols-2 gap-4 mb-4">
                  <label class="block">
                    <span class="text-white block mb-1">Ticket Name</span>
                    <input name="event[ticket_name]" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" placeholder="Esko" />
                  </label>
                  <label class="block">
                    <span class="text-white block mb-1">Price</span>
                    <input name="event[price]" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" placeholder="20,000" />
                  </label>
                </div>
                <div class="grid grid-cols-2 gap-4">
                  <label class="block">
                    <span class="text-white block mb-1">Quantity Available</span>
                    <input name="event[quantity]" type="text" class="w-full p-2 bg-black border border-gray-700 rounded text-white" placeholder="300" />
                  </label>
                  <label class="block">
                    <span class="text-white block mb-1">Description</span>
                    <input name="event[ticket_description]" type="text" placeholder="what's included with this ticket" class="w-full p-2 bg-black border border-gray-700 rounded text-white" />
                  </label>
                </div>
              </div>

              <div class="flex justify-between mt-8">
                <button type="button" phx-click="back" class="bg-transparent border border-white text-white md:px-6 md:py-3 px-4 py-2 lg:py-4 lg:px-8 rounded-md">
                  Back
                </button>
                <button type="submit" class="bg-indigo-600 text-white md:px-6 md:py-3 px-4 py-2 lg:py-4 lg:px-8 rounded-md hover:bg-indigo-700 transition">
                  Continue to Upload Media
                </button>
              </div>
            </form>
          </div>
        <% end %>

        <%= if @step == :upload_media do %>
          <h2 class="text-2xl font-bold mb-2 text-white">Upload Media</h2>
          <p class="mb-6 text-gray-300">Upload your event poster or images.</p>
          <div class="flex justify-between mt-4">
            <button phx-click="back" class="bg-gray-700 text-white px-4 py-2 rounded hover:bg-gray-600 transition">
              Back
            </button>
            <button phx-click="skip_upload" class="bg-violet-600 text-white px-6 py-2 rounded hover:bg-violet-700 transition">
              Continue
            </button>
          </div>
        <% end %>

        <%= if @step == :launch do %>
          <h2 class="text-2xl font-bold mb-2 text-white">Launch Event</h2>
          <p class="mb-6 text-gray-300">Review and launch your event.</p>
          <div class="flex justify-between mt-4">
            <button phx-click="back" class="bg-gray-700 text-white px-4 py-2 rounded hover:bg-gray-600 transition">
              Back
            </button>
            <button phx-click="launch" class="bg-violet-600 text-white px-6 py-2 rounded hover:bg-violet-700 transition">
              Launch
            </button>
          </div>
        <% end %>

        <%= if @step == :congratulations do %>
          <h2 class="text-2xl font-bold mb-2 text-white">Congratulations!</h2>
          <p class="mb-6 text-gray-300">Your event has been created successfully.</p>
          <.link navigate="/admin/events" class="bg-violet-600 text-white px-6 py-2 rounded hover:bg-violet-700 transition">
            Go to Events
          </.link>
        <% end %>
      </div>
    </section>
    """
  end
end
