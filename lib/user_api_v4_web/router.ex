defmodule UserApiV4Web.Router do
  use UserApiV4Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug PrimaAuth0Ex.Plug.VerifyAndValidateToken, audience: "https://dev-jdbh0t3oewrxreto.us.auth0.com/api/v2/", required_permissions: []
  end

  scope "/api", UserApiV4Web do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    get "/users/by_email/:email", UserController, :by_email
    get "/users/pagination/:page/:size", UserController, :index_pag
    get "/users/pagination/:page/:size/:order_by", UserController, :index_pag_order

  end

  # scope "/api", UserApiV4Web do
  #   pipe_through [:api, :auth]

  #   resources "/users", UserController, except: [:new, :edit]
  #   get "/users/by_email/:email", UserController, :by_email
  #   get "/users/pagination/:page/:size", UserController, :index_pag
  # end
end
