defmodule UserApiV4.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UserApiV4.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        birthdate: "some birthdate",
        id_auth0: "some id_auth0",
        language: "some language",
        last_name: "some last_name",
        middle_name: "some middle_name",
        name: "some name",
        phone: "some phone",
        photo: "some photo",
        zone: "some zone"
      })
      |> UserApiV4.Users.create_user()

    user
  end
end
