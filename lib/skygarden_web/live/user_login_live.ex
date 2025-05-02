defmodule SkygardenWeb.UserLoginLive do
  use SkygardenWeb, :live_view

  def render(assigns) do
    ~H"""
    <%!-- <div class="mx-auto max-w-sm">
      <.header class="text-center">
        Log in to account
        <:subtitle>
          Don't have an account?
          <.link navigate={~p"/users/register"} class="font-semibold text-brand hover:underline">
            Sign up
          </.link>
          for an account now.
        </:subtitle>
      </.header>

      <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
              <.input field={@form[:first_name]} type="text" label="Password" required />

        <.input field={@form[:second_name]} type="text" label="Password" required />

        <.input field={@form[:email]} type="email" label="Email" required />
        <.input field={@form[:password]} type="password" label="Password" required />

        <:actions>
          <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" />
          <.link href={~p"/users/reset_password"} class="text-sm font-semibold">
            Forgot your password?
          </.link>
        </:actions>
        <:actions>
          <.button phx-disable-with="Logging in..." class="w-full">
            Log in <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>
    </div> --%>

    <div class="w-full lg:h-auto flex flex-col lg:flex-row gap-4">
      <div class="lg:w-1/2 py-10 lg:h-auto bg-blue-700 text-white flex items-center justify-center ">
      <div class="max-w-[90%] mx-auto flex flex-col items-start justify-center space-y-8">
        <h2 class="text-[24px] lg:text-[40px] font-semibold">Create amazing events with Sky Tickets</h2>

        <div class="max-w-[65%]">
        <p class="text-[14px] md:text-[18px] ">Join thousands of event organizers and start selling tickets today</p>
        </div>
        <div class="space-y-4 w-full items-start justify-center">
          <%!-- green checkcircle tick --%>
          <div class="flex flex-row space-x-4 items-start justify-start w-full">
          <i class="fa fa-check-circle flex items-center justify-center text-green-400"></i>
          <p class="text-[14px] md:text-[16px]"> Easy-to-use event management tools</p>
          </div>
          <div class="flex flex-row space-x-4 items-start justify-start w-full">
          <i class="fa fa-check-circle flex items-center justify-center text-green-400"></i>
          <p class="text-[14px] md:text-[16px]"> Sell tickets commission-free</p>
          </div>
          <div class="flex flex-row space-x-4 items-start justify-start w-full">
          <i class="fa fa-check-circle flex items-center justify-center text-green-400"></i>
          <p class="text-[14px] md:text-[16px]">Reach millions of potential attendees</p>
          </div>
          <div class="flex flex-row space-x-4 items-start justify-start w-full">
          <i class="fa fa-check-circle flex items-center justify-center text-green-400"></i>
          <p class="text-[14px] md:text-[16px]"> Real-time analytics and reporting</p>
          </div>
          </div>
        </div>
      </div>
      <div class="lg:w-1/2 w-full py-20">
        <h1 class="text-[32px] md:text-[40px] text-center font-semibold">Login as an Event Organizer</h1>
        <.simple_form
        for={@form}
        id="login_form"
        action={~p"/users/log_in"}
        class="space-y-4 max-w-[90%] mx-auto mt-8"
        phx-update="ignore"
        >

      <div>
        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
        <.input
        field={@form[:email]}
        type="email"
        required
        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"
      />
      </div>

      <div>
        <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
        <.input
        field={@form[:password]}
        type="password"
        required
        minlength="6"
        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"
      />
      </div>
      <div class="flex items-start space-x-3 py-1">
      <.input
        field={@form[:remember_me]}
        type="checkbox"
        label="Keep me signed in"
        class="h-4 w-4 text-purple-600 focus:ring-purple-500 border-gray-300 rounded mt-1"
      />

      </div>

      <:actions>
          <button phx-disable-with="Logging in..." class="w-full py-4 text-white font-bold bg-blue-600 hover:bg-blue-800 ease-in duration-300 rounded-md">
            Log in <span aria-hidden="true">→</span>
          </button>
        </:actions>

      <div class="mt-4 text-center text-sm">
        Don't have an account? <a href="/users/register" class="text-purple-700 hover:underline">Sign up</a>
      </div>
    </.simple_form>

      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
