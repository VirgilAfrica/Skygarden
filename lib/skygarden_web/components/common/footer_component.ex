defmodule SkygardenWeb.Common.FooterComponent do
  use Phoenix.Component

  def footer(assigns)do
    ~H"""
    <footer class="w-full dark:bg-black text-black dark:text-white  h-auto py-8 lg:py-12 flex flex-col">
      <div class="w-full max-w-[90%] mx-auto flex flex-col lg:flex-row items-start justify-between gap-4 " >
        <div class="flex flex-col w-full lg:w-1/2 space-y-8">
        <h2 class="font-bold text-blue-500 text-[16px] lg:text-[18px]">SKY Tickets</h2>
        <p class="text-[16px] md:text-[18px] text-pretty">
        Discover and attend the best events in your area or create and manage your own events.</p>
        </div>
        <div class="w-full flex flex-col lg:flex-row items-start justify-between space-y-8 lg:space-y-0">
        <div class="space-y-2 lg:space-y-4">
          <h3 class="font-bold text-[20px]">For Attendees</h3>
          <ul class="flex flex-col space-y-4">
          <li>Browse Events</li>
          <li>Categories Events</li>
          <li>Upcoming Events</li>
          </ul>
        </div>
        <div class="space-y-2 lg:space-y-4">
          <h3 class="font-bold text-[20px]">For Organizers</h3>
          <ul class="flex flex-col space-y-4">
          <li>Create Events</li>
          <li>Pricing</li>
          <li>Resources</li>
          <li>Features</li>
          </ul>
        </div>
        <div class="space-y-2 lg:space-y-4">
          <h3 class="font-bold text-[20px]">Contact Us</h3>
          <ul class="flex flex-col space-y-4">
          <li>Help Center</li>
          <li>Contact Us</li>
          <li>About Us</li>
          <li>Facebook</li>
          <li>Twitter</li>
          <li> Instagram</li>
          </ul>
        </div>
        </div>
      </div>
      <div class="border-t-2 dark:border-white w-full py-4 mt-8 lg:mt-12 lg:py-8">
        <div class="flex flex-col space-y-4 lg:space-y-0 lg:flex-row items-start justify-between w-full max-w-[90%] mx-auto">
        <p class="text-[14px] md:text-[16px]">Sky Ticket. All rights reserved</p>
        <ul class="flex flex-row space-x-4">
        <li>Privacy Policy</li>
        <li>Terms of Services</li>
        <li>Cookies</li>

        </ul>
        </div>
      </div>
    </footer>
    """
  end
end
