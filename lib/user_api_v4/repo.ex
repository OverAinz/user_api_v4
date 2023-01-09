defmodule UserApiV4.Repo do
  use Ecto.Repo,
    otp_app: :user_api_v4,
    adapter: Ecto.Adapters.Postgres
end
