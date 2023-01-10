defmodule UserApiV4Web.DefaultController do
  use UserApiV4Web, :controller

  def index(conn, _params) do
    text conn, "the real api is live #{Mix.env()}"
  end
end
