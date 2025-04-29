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
        <h1 class="text-[32px] md:text-[40px] text-center font-semibold">Sign up as Event Organizer</h1>

        <form id="signupForm" class="space-y-4 max-w-[90%] mx-auto mt-8" phx-submit="register">
      <div class="grid grid-cols-2 gap-4">
        <div>
          <label for="firstName" class="block text-sm font-medium text-gray-700 mb-1">First Name</label>
          <input type="text" id="firstName" name="firstName" required
            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
        </div>

        <div>
          <label for="lastName" class="block text-sm font-medium text-gray-700 mb-1">Last name</label>
          <input type="text" id="lastName" name="lastName" required
            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
        </div>
      </div>

      <div>
        <label for="organizationName" class="block text-sm font-medium text-gray-700 mb-1">Organization Name</label>
        <input type="text" id="organizationName" name="organizationName" required
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
      </div>

      <div>
        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
        <input type="email" id="email" name="email" required
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
      </div>

      <div>
        <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
        <input type="password" id="password" name="password" required minlength="8"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
      </div>

      <div>
        <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm Password</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8"
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent">
        <p id="passwordError" class="text-red-500 text-sm mt-1 hidden">Passwords do not match</p>
      </div>

      <div class="flex items-start space-x-3 py-1">
        <input type="checkbox" id="termsAccepted" name="termsAccepted" required
          class="h-4 w-4 text-purple-600 focus:ring-purple-500 border-gray-300 rounded mt-1">
        <label for="termsAccepted" class="text-sm font-normal">
          I agree to the <a href="#" class="text-purple-700 hover:underline">Terms of Service</a> and
          <a href="#" class="text-purple-700 hover:underline">Privacy Policy</a>
        </label>
      </div>

      <button type="submit"
        class="w-full bg-purple-600 hover:bg-purple-700 text-white font-medium py-2 px-4 rounded-md transition duration-200">
        Create Account
      </button>

      <div class="mt-4 text-center text-sm">
        Already have an account? <a href="#" class="text-purple-700 hover:underline">Sign in</a>
      </div>
    </form>

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
