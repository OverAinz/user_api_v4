defmodule UserApiV4.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :birthdate, :string
    field :email, :string
    field :id_auth0, :string
    field :language, :string
    field :last_name, :string
    field :middle_name, :string
    field :name, :string
    field :phone, :string
    field :photo, :string
    field :zone, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :middle_name,
      :last_name,
      :phone,
      :birthdate,
      :id_auth0,
      #:zone, :language, :photo,
      :email
      ])
    |> validate_required([
      :name,
      :middle_name,
      :last_name,
      :phone,
      :birthdate,
      #:id_auth0, :zone, :language, :photo,
      :email
      ])
    |> unique_constraint(:email)
  end
end
