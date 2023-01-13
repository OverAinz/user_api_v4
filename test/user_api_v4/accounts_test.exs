defmodule UserApiV4.AccountsTest do
  use UserApiV4.DataCase

  alias UserApiV4.Accounts

  describe "users" do
    alias UserApiV4.Accounts.User

    import UserApiV4.AccountsFixtures

    @invalid_attrs %{birthdate: nil, email: nil, id_auth0: nil, language: nil, last_name: nil, middle_name: nil, name: nil, phone: nil, photo: nil, zone: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{birthdate: "some birthdate", email: "some email", id_auth0: "some id_auth0", language: "some language", last_name: "some last_name", middle_name: "some middle_name", name: "some name", phone: "some phone", photo: "some photo", zone: "some zone"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.birthdate == "some birthdate"
      assert user.email == "some email"
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
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{birthdate: "some updated birthdate", email: "some updated email", id_auth0: "some updated id_auth0", language: "some updated language", last_name: "some updated last_name", middle_name: "some updated middle_name", name: "some updated name", phone: "some updated phone", photo: "some updated photo", zone: "some updated zone"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.birthdate == "some updated birthdate"
      assert user.email == "some updated email"
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
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
