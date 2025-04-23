defmodule SkygardenWeb.Landing.LandingLayout do
  use Phoenix.Component

    def landing_layout(assigns)do
      ~H"""
      <section class="w-full h-auto">
        <.hero_section/>
      </section>
      """
    end

    def hero_section(assigns) do
      ~H"""
        <section class="w-full h-auto lg:h-screen relative overflow-hidden">
            <video
              class="absolute top-0 left-0 w-full h-full object-cover z-0"
              src="/images/landing/landing.mp4"
              autoplay
              loop
              muted
              playsinline
            ></video>
            <div class="absolute top-0 left-0 w-full h-full bg-black/50 z-10"></div>
            <div class="max-w-[90%] mx-auto relative z-20">
            <div class="absolute top-40 z-40">
              <.latest_event_card/>
            </div>
            </div>
        </section>
      """
    end

    def latest_event_card(assigns)do
      ~H"""
        <div class="w-full h-auto  rounded-lg shadow-lg p-4 flex flex-col space-y-4">
          <span class ="w-1/4 py-2 px-4 bg-[#F7F8FA] rounded-full">
          <p class="w-auto text-[8px] md:text-[12px] text-[#5D3FD3] font-medium">
          Latest Event
          </p>
          </span>
          <span class="text-whit flex flex-row space-x-2">
            <%!-- fontawesome icon --%>
            <i class="fa-solid fa-calendar-days text-white"></i>
            <p class="font-medium">Apr 04, 2025 · 12:00 PM </p>
          </span>
          <h1 class="text-[24px] md:text-[32px] font-semibold text-whit">Summer Music Festival 2025</h1>
          <p class="text-[14px] md:text-[16px] text-whit">Central Park,Nairobi.</p>
          <div class="flex flex-row space-x-4 justify-between">
            <span class="flex flex-row space-x-4 text-whit items-center text-[12px] md:text-[14px] font-bold "><p class="text-[12px] flex items-center justify-center">KES</p><p class='text-[24px]'>1,500.00</p></span> <button class="bg-blue-700 font-semibold text-[#F7F8FA] px-4 py-2 rounded-md duration-300 ease-in hover:bg-blue-800">Get Ticket</button>
          </div>

          <div class="flex flex-col space-y-3">
            <h4 class="font-medium text-whit">Popular Categories:</h4>
            <ul class="flex flex-row space-x-2 text-blu">
            <li class="text-blu flex space-x-2 cursor-pointer"><p class="underline underline-offset-4 hover:text-whit">Music</p> <span>·</span></li>
            <li class="text-blu flex space-x-2 cursor-pointer"><p class="underline underline-offset-4 hover:text-whit cursor-pointer">Technology</p> <span>·</span></li>
            <li class="text-blu flex space-x-2 cursor-pointer"><p class="underline underline-offset-4 hover:text-whit cursor-pointer">Concert</p> <span>·</span></li>
            <li class="text-blu flex space-x-2 cursor-pointer"><p class="underline underline-offset-4 hover:text-whit">Art</p></li>
            </ul>
          </div>

        </div>
      """
    end
  end
