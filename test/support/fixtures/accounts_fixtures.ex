defmodule UserApiV4.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UserApiV4.Accounts` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        birthdate: "some birthdate",
        email: unique_user_email(),
        id_auth0: "some id_auth0",
        language: "some language",
        last_name: "some last_name",
        middle_name: "some middle_name",
        name: "some name",
        phone: "some phone",
        photo: "some photo",
        zone: "some zone"
      })
      |> UserApiV4.Accounts.create_user()

    user
  end
end
