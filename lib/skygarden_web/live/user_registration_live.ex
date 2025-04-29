defmodule SkygardenWeb.UserRegistrationLive do
  use SkygardenWeb, :live_view

  alias Skygarden.Accounts
  alias Skygarden.Accounts.User

  def render(assigns) do
    ~H"""
    <%!-- <div class="mx-auto max-w-sm">
      <.header class="text-center">
        Register for an account
        <:subtitle>
          Already registered?
          <.link navigate={~p"/users/log_in"} class="font-semibold text-brand hover:underline">
            Log in
          </.link>
          to your account now.
        </:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="registration_form"
        phx-submit="save"
        phx-change="validate"
        phx-trigger-action={@trigger_submit}
        action={~p"/users/log_in?_action=registered"}
        method="post"
      >
        <.error :if={@check_errors}>
          Oops, something went wrong! Please check the errors below.
        </.error>

        <.input field={@form[:email]} type="email" label="Email" required />
        <.input field={@form[:password]} type="password" label="Password" required />

        <:actions>
          <.button phx-disable-with="Creating account..." class="w-full">Create an account</.button>
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

        <.simple_form
        class="space-y-4 max-w-[90%] mx-auto mt-8"
        for={@form}
        id="registration_form"
        phx-submit="save"
        phx-change="validate"
        phx-trigger-action={@trigger_submit}
        action={~p"/users/log_in?_action=registered"}
        method="post"
        >
        <.error :if={@check_errors}>
          Oops, something went wrong! Please check the errors below.
        </.error>
      <div class="grid grid-cols-2 gap-4">
        <div>
          <label for="firstName" class="block text-sm font-medium text-gray-700 mb-1">First Name</label>
          <.input
          field={@form[:first_name]}
          type="text"
          required
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"
        />
        </div>

        <div>
          <label for="lastName" class="block text-sm font-medium text-gray-700 mb-1">Last name</label>
          <.input
          field={@form[:second_name]}
          type="text"
          required
          class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"
        />
        </div>
      </div>

      <div>
        <label for="organizationName" class="block text-sm font-medium text-gray-700 mb-1">Organization Name</label>
        <.input
        field={@form[:organization_name]}
        type="text"
        required
        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"
      />
      </div>

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

      <div>
        <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm Password</label>
        <.input
        field={@form[:password_confirmation]}
        type="password"
        required
        minlength="6"
        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"
      />
        <p id="passwordError" class="text-red-500 text-sm mt-1 hidden">Passwords do not match</p>
      </div>

      <div class="flex items-start space-x-3 py-1">
      <.input
        field={@form[:remember_me]}
        type="checkbox"
        class="h-4 w-4 text-purple-600 focus:ring-purple-500 border-gray-300 rounded mt-1"
      />
        <label for="termsAccepted" class="text-sm font-normal">
          I agree to the <a href="#" class="text-purple-700 hover:underline">Terms of Service</a> and
          <a href="#" class="text-purple-700 hover:underline">Privacy Policy</a>
        </label>
      </div>

      <:actions>
          <button phx-disable-with="Creating account..." class="py-4 text-white font-bold rounded-md w-full bg-blue-700">Create an account</button>
        </:actions>

      <div class="mt-4 text-center text-sm">
        Already have an account? <a href="/users/log_in" class="text-purple-700 hover:underline">Sign in</a>
      </div>
    </.simple_form>

      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)
        {:noreply,
        socket
        |> assign(trigger_submit: true)
        |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
        socket
        |> assign(check_errors: true)
        |> assign_form(changeset)
      }
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      Accounts.change_user_registration(%User{}, user_params)
    {:noreply,
    assign_form(
    socket,
    Map.put(changeset, :action, :validate)
    )}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
