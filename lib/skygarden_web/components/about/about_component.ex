defmodule SkygardenWeb.About.AboutComponent do
  use Phoenix.Component

  def about_layout(assigns) do
    ~H"""
    <.hero_section />
    <.history_section />
    <.our_values />
    <.team_section />
    <.get_started />
    """
  end

  def hero_section(assigns) do
    ~H"""
    <section class="relative h-[70vh] md:h-screen bg-cover bg-center bg-no-repeat w-full"
             style="background-image: url('/images/about-hero.jpg');">
      <div class="absolute inset-0 bg-black bg-opacity-50"></div>
      <div class="relative z-10 flex items-center justify-start h-full w-full max-w-[90%] mx-auto">
        <div class="text-white">
          <h1 class="text-[32px] md:text-[56px] font-bold mb-4">About Big Tickets</h1>
          <p class="text-[16px] md:text-[20px] leading-relaxed">
            Connecting people through unforgettable events since 2025.
          </p>
        </div>
      </div>
    </section>
    """
  end

  def history_section(assigns) do
    ~H"""
    <section class="py-16">
      <div class="max-w-[90%] mx-auto">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-16">
          <div class="bg-white p-6">
            <h2 class="text-[24px] md:text-[32px] font-bold text-gray-900 mb-6">Our Mission</h2>
            <p class="text-gray-600 leading-relaxed text-[16px] md:text-[18px]">
           At Sky Tickets, we believe that meaningful experiences bring people together. Our mission is to make event discovery and attendance seamless, allowing everyone to connect with their communities and passions.
          We're dedicated to supporting event creators and attendees alike, fostering a vibrant ecosystem where unforgettable moments are just a click away.
            </p>
          </div>
          <div class="bg-white p-6">
            <h2 class="text-[24px] md:text-[32px] font-bold text-gray-900 mb-6">Our Vision</h2>
            <p class="text-gray-600 leading-relaxed text-[16px] md:text-[18px]">
              Sky Tickets was born from a simple observation: finding and attending great events should be easy and exciting. Founded by a team of event enthusiasts, we set out to create a platform that removes barriers between people and experiences.
              Since our launch in 2025, we've helped thousands of users discover concerts, workshops, conferences, and more in their local communities.
            </p>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def our_values(assigns) do
    ~H"""
    <section class="py-20 bg-gray-50">
      <div class="max-w-[90%] mx-auto px-4 sm:px-6 md:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl font-bold text-gray-900 mb-4">Our Values</h2>
          <p class="text-xl text-gray-600 max-w-2xl mx-auto">The principles that guide everything we do</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <%= for value <- values_data() do %>
            <div class="text-center p-6 rounded-xl bg-white hover:bg-gray-100 transition-colors duration-300">
              <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <i class={"text-blue-600 text-2xl " <> value.icon}></i>
              </div>
              <h3 class="text-xl font-semibold text-gray-900 mb-3"><%= value.title %></h3>
              <p class="text-gray-600 text-sm leading-relaxed"><%= value.description %></p>
            </div>
          <% end %>
        </div>
      </div>
    </section>
    """
  end

  def team_section(assigns) do
    ~H"""
    <section class="py-20 bg-gray-50">
      <div class="max-w-[90%] mx-auto px-4">
        <div class="text-center mb-16">
          <h2 class="text-4xl font-bold text-gray-900 mb-4">Meet Our Leadership Team</h2>
          <p class="text-xl text-gray-600 max-w-2xl mx-auto">The visionaries behind our success</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <%= for member <- team_data() do %>
            <div class=" ">
              <div class=" relative">
                <img src={member.avatar} alt={member.name} class="w-80 h-auto object-cover rounded-full" />
              </div>
              <div class="p-6 text-center">
                <h3 class="text-xl font-semibold text-gray-900 mb-1"><%= member.name %></h3>
                <p class="text-blue-600 font-medium mb-3"><%= member.position %></p>


              </div>
            </div>
          <% end %>
        </div>
      </div>
    </section>
    """
  end

  def get_started(assigns) do
    ~H"""
    <section class="h-auto lg:[50vh] w-full bg-blue-700 text-white py-20">
      <div class="max-w-[90%] mx-auto flex flex-col items-center justify-center space-y-4 h-full text-center">
        <h3 class="font-bold text-[32px] md:text-[40px]">Ready to create your own event?</h3>
        <p class="text-[16px] md:text-[18px] max-w-2xl">
          Whether it's a concert, workshop, or conference, Sky Tickets has everything you need to organize and manage your event.
        </p>
        <button class="bg-white text-blue-500 font-semibold px-6 py-3 rounded-md duration-300 ease-in hover:bg-blue-600 hover:text-white uppercase">
          Get Started
        </button>
      </div>
    </section>
    """
  end

  defp values_data do
    [
      %{icon: "fas fa-heart", title: "Passion", description: "We're passionate about events and delivering unforgettable experiences."},
      %{icon: "fas fa-lightbulb", title: "Innovation", description: "We continuously innovate to provide the best tools and features for our users."},
      %{icon: "fas fa-users", title: "Community first", description: "We believe in the power of bringing people together through shared experiences."},
      %{icon: "fas fa-shield-alt", title: "Excellence", description: "We strive for excellence in every aspect of our service and user experience."}
    ]
  end

  defp team_data do
    [
      %{
        name: "Michael Munavu",
        position: "CEO & Founder",
        avatar: "/images/avatars/mike.jpeg",

      },
      %{
        name: "Kiprotich Kimutai",
        position: "CTO",
        avatar: "/images/avatars/kim.jpeg",

      },
      %{
        name: "Frankie",
        position: "Head of Marketing",
        avatar: "/images/avatars/kim.jpeg",

      },
      %{
        name: "Josiah",
        position: "Head of Operations",
        avatar: "/images/avatars/mike.jpeg",

      }
    ]
  end
end
