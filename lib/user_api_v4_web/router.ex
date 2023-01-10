defmodule UserApiV4Web.Router do
  use UserApiV4Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UserApiV4Web do
    pipe_through :api

    get "/", DefaultController, :index
  end
end
