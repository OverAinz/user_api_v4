defmodule UserApiV4Web.UserControllerTest do
  use UserApiV4Web.ConnCase

  import UserApiV4.AccountsFixtures

  alias UserApiV4.Accounts.User

  @create_attrs %{
    birthdate: "some birthdate",
    email: "some email",
    id_auth0: "some id_auth0",
    language: "some language",
    last_name: "some last_name",
    middle_name: "some middle_name",
    name: "some name",
    phone: "some phone",
    photo: "some photo",
    zone: "some zone"
  }
  @update_attrs %{
    birthdate: "some updated birthdate",
    email: "some updated email",
    id_auth0: "some updated id_auth0",
    language: "some updated language",
    last_name: "some updated last_name",
    middle_name: "some updated middle_name",
    name: "some updated name",
    phone: "some updated phone",
    photo: "some updated photo",
    zone: "some updated zone"
  }
  @invalid_attrs %{birthdate: nil, email: nil, id_auth0: nil, language: nil, last_name: nil, middle_name: nil, name: nil, phone: nil, photo: nil, zone: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "birthdate" => "some birthdate",
               "email" => "some email",
               "id_auth0" => "some id_auth0",
               "language" => "some language",
               "last_name" => "some last_name",
               "middle_name" => "some middle_name",
               "name" => "some name",
               "phone" => "some phone",
               "photo" => "some photo",
               "zone" => "some zone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "birthdate" => "some updated birthdate",
               "email" => "some updated email",
               "id_auth0" => "some updated id_auth0",
               "language" => "some updated language",
               "last_name" => "some updated last_name",
               "middle_name" => "some updated middle_name",
               "name" => "some updated name",
               "phone" => "some updated phone",
               "photo" => "some updated photo",
               "zone" => "some updated zone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
