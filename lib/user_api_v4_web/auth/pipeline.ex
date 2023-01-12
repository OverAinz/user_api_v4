defmodule UserApiV4Web.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :user_api_v4,
  module: UserApiV4Web.Auth.Guardian,
  error_handler: UserApiV4Web.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
