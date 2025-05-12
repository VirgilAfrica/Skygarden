defmodule SkygardenWeb.Router do
  alias SkygardenWeb.PaymentSuccessLive
  alias SkygardenWeb.BrowseEventsLive.DetailsLive
  use SkygardenWeb, :router

  import SkygardenWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SkygardenWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SkygardenWeb do
    pipe_through :browser

    # get "/", PageController, :home
    live "/", LandingLive.Index, :index
    live "/landing", LandingLive.Index, :index
    live "/browse-events", BrowseventsLive.Index,:index
    live "/browse-events/:id", EventsDetailsLive, :index
    live "/browse-events/:id/details", DetailsLive, :index
    live "/browse-events/:id/buy-tickets", BuyTicketsLive, :index
    live "/browse-events/:id/checkout", CheckoutLive, :index
    live "/browse-events/:id/paymentsuccess", PaymentSuccessLive, :index


  end

  # Other scopes may use custom stacks.
  # scope "/api", SkygardenWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:skygarden, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SkygardenWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", SkygardenWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{SkygardenWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", SkygardenWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{SkygardenWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

      scope "/admin" do
        live "/dashboard", AdminLive.Index, :index
        # Event management routes
        live "/events", EventLive.Index, :index
        # live "/events/new", EventLive.Wizard , :new
        live "/events/new", EventLive.Index, :new
        live "/events/:id/edit", EventLive.Index, :edit
        live "/events/:id", EventLive.Show, :show
        live "/events/:id/show/edit", EventLive.Show, :edit
        # event bulk
        live "/event_bulk_messages", EventBulkMessageLive.Index, :index
        live "/event_bulk_messages/new", EventBulkMessageLive.Index, :new
        live "/event_bulk_messages/:id/edit", EventBulkMessageLive.Index, :edit
        live "/event_bulk_messages/:id", EventBulkMessageLive.Show, :show
        live "/event_bulk_messages/:id/show/edit", EventBulkMessageLive.Show, :edit
        # Event poster
        live "/event_posters", EventPosterLive.Index, :index
        live "/event_posters/new", EventPosterLive.Index, :new
        live "/event_posters/:id/edit", EventPosterLive.Index, :edit

        live "/event_posters/:id", EventPosterLive.Show, :show
        live "/event_posters/:id/show/edit", EventPosterLive.Show, :edit
        # TicketType:
        live "/ticket_types", TicketTypeLive.Index, :index
        live "/ticket_types/new", TicketTypeLive.Index, :new
        live "/ticket_types/:id/edit", TicketTypeLive.Index, :edit

        live "/ticket_types/:id", TicketTypeLive.Show, :show
        live "/ticket_types/:id/show/edit", TicketTypeLive.Show, :edit
        # Payment
        live "/ticket_payments", TicketPaymentLive.Index, :index
        live "/ticket_payments/new", TicketPaymentLive.Index, :new
        live "/ticket_payments/:id/edit", TicketPaymentLive.Index, :edit

        live "/ticket_payments/:id", TicketPaymentLive.Show, :show
        live "/ticket_payments/:id/show/edit", TicketPaymentLive.Show, :edit
        # Reminder
        live "/reminders", ReminderLive.Index, :index
        live "/reminders/new", ReminderLive.Index, :new
        live "/reminders/:id/edit", ReminderLive.Index, :edit

        live "/reminders/:id", ReminderLive.Show, :show
        live "/reminders/:id/show/edit", ReminderLive.Show, :edit
        # SubAccounts
        live "/sub_accounts", SubAccountLive.Index, :index
        live "/sub_accounts/new", SubAccountLive.Index, :new
        live "/sub_accounts/:id/edit", SubAccountLive.Index, :edit

        live "/sub_accounts/:id", SubAccountLive.Show, :show
        live "/sub_accounts/:id/show/edit", SubAccountLive.Show, :edit
        #event users
        live "/event_users", EventUserLive.Index, :index
        live "/event_users/new", EventUserLive.Index, :new
        live "/event_users/:id/edit", EventUserLive.Index, :edit

        live "/event_users/:id", EventUserLive.Show, :show
        live "/event_users/:id/show/edit", EventUserLive.Show, :edit
      #  paymentplans
        live "/payment_plans", PaymentPlanLive.Index, :index
        live "/payment_plans/new", PaymentPlanLive.Index, :new
        live "/payment_plans/:id/edit", PaymentPlanLive.Index, :edit

        live "/payment_plans/:id", PaymentPlanLive.Show, :show
        live "/payment_plans/:id/show/edit", PaymentPlanLive.Show, :edit

      end

      scope "/dashboard" do
        live "/overview", Dashboard.Index, :index
        live "/my_tickets", Dashboard.Show, :index
        live "/my_tickets/:id", Dashboard.Show, :show
        live "/saved_tickets", Dashboard.Show, :index
        live "/saved_tickets/:id", Dashboard.Show, :show
        live "/notifications", Dashboard.Show, :index
      end
    end
  end

  scope "/", SkygardenWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{SkygardenWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new

      scope "/", SkygardenWeb do

      end
    end
  end
end
