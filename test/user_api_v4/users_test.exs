defmodule UserApiV4.UsersTest do
  use UserApiV4.DataCase

  alias UserApiV4.Users

  describe "users" do
    alias UserApiV4.Users.User

    import UserApiV4.UsersFixtures

    @invalid_attrs %{birthdate: nil, id_auth0: nil, language: nil, last_name: nil, middle_name: nil, name: nil, phone: nil, photo: nil, zone: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{birthdate: "some birthdate", id_auth0: "some id_auth0", language: "some language", last_name: "some last_name", middle_name: "some middle_name", name: "some name", phone: "some phone", photo: "some photo", zone: "some zone"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.birthdate == "some birthdate"
      assert user.id_auth0 == "some id_auth0"
      assert user.language == "some language"
      assert user.last_name == "some last_name"
      assert user.middle_name == "some middle_name"
      assert user.name == "some name"
      assert user.phone == "some phone"
      assert user.photo == "some photo"
      assert user.zone == "some zone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{birthdate: "some updated birthdate", id_auth0: "some updated id_auth0", language: "some updated language", last_name: "some updated last_name", middle_name: "some updated middle_name", name: "some updated name", phone: "some updated phone", photo: "some updated photo", zone: "some updated zone"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.birthdate == "some updated birthdate"
      assert user.id_auth0 == "some updated id_auth0"
      assert user.language == "some updated language"
      assert user.last_name == "some updated last_name"
      assert user.middle_name == "some updated middle_name"
      assert user.name == "some updated name"
      assert user.phone == "some updated phone"
      assert user.photo == "some updated photo"
      assert user.zone == "some updated zone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
