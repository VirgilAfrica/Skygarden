defmodule Skygarden.Repo do
  use Ecto.Repo,
    otp_app: :skygarden,
    adapter: Ecto.Adapters.Postgres
end
