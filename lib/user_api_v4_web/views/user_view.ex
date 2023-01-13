defmodule UserApiV4Web.UserView do
  use UserApiV4Web, :view
  alias UserApiV4Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end


  def render("index_pag.json", %{users: users, pages: pages}) do
    %{data: render_many(users, UserView, "user.json"), pages: pages}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      middle_name: user.middle_name,
      last_name: user.last_name,
      phone: user.phone,
      birthdate: user.birthdate,
      id_auth0: user.id_auth0,
      zone: user.zone,
      language: user.language,
      photo: user.photo,
      email: user.email
    }
  end
end
