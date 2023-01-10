defmodule UserApiV4.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UserApiV4.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hash_password: "some hash_password"
      })
      |> UserApiV4.Accounts.create_account()

    account
  end
end
