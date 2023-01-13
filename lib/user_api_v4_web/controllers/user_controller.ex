defmodule UserApiV4Web.UserController do
  use UserApiV4Web, :controller

  alias UserApiV4.Accounts
  alias UserApiV4.Accounts.User

  action_fallback UserApiV4Web.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def index_pag(conn, %{"page" => page, "size" => size}) do
    %{pages: pages, data: users} = Accounts.list_users_pagination(page, size)
    render(conn, "index_pag.json", users: users, pages: pages)
  end

  def index_pag_order(conn, %{"page" => page, "size" => size, "order_by" => order_by}) do
    %{pages: pages, data: users} = Accounts.list_users_pagination_order(page, size, order_by)
    render(conn, "index_pag.json", users: users, pages: pages)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
    {:ok, %User{} = user} <- Accounts.update_user(user, Accounts.create_user_auth0(user)) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def by_email(conn, %{"email" => email}) do
    {:ok, user} = Accounts.get_by_email(email)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params),
          {:ok, _response} <- Accounts.update_user_auth0(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
