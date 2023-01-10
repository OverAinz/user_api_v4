defmodule UserApiV4.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :middle_name, :string
      add :last_name, :string
      add :phone, :string
      add :birthdate, :string
      add :id_auth0, :string
      add :zone, :string
      add :language, :string
      add :photo, :string
      add :account_id, references(:accounts, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:users, [:account_id, :name, :middle_name, :last_name])
  end
end
