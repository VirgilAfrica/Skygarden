defmodule SkygardenWeb.Router do
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
    get "/", PageController, :home
    live "/landing", LandingLive.Index, :index
    live "/browse-events", BrowseventsLive.Index,:index
    live "/browse-events/:id", EventsDetailsLive, :index
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
        live "/events/new", EventLive.Wizard , :new
        # live "/events/new", EventLive.Index, :new
        live "/events/:id/edit", EventLive.Index, :edit
        live "/events/:id", EventLive.Show, :show
        live "/events/:id/show/edit", EventLive.Show, :edit



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
