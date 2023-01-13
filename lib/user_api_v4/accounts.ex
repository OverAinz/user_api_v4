defmodule UserApiV4.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias EctoPaginator
  alias UserApiV4.Repo
  alias Auth0Ex.Management.User, as: Auth0User
  alias UserApiV4.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def list_users_pagination(page, size) do
    query = from u in User, select: u, order_by: [asc: u.email]
    nusers = Repo.all(query) |> Enum.count()
    pages = nusers/String.to_integer(size)
    res = rem(nusers, String.to_integer(size))
    fpag = get_pages(pages, res) |> trunc
    users = query
    |> EctoPaginator.paginate(String.to_integer(page), String.to_integer(size))
    |> Repo.all()

    %{pages: to_string(fpag), data: users}
  end

  def list_users_pagination_order(page, size, order_by) do

    query = order(order_by)
    nusers = Repo.all(query) |> Enum.count()
    pages = nusers/String.to_integer(size)
    res = rem(nusers, String.to_integer(size))
    fpag = get_pages(pages, res) |> trunc
    users = query
    |> EctoPaginator.paginate(String.to_integer(page), String.to_integer(size))
    |> Repo.all()

    %{pages: to_string(fpag), data: users}
  end

  defp order(order_by) do
    case order_by do
      "email" -> from u in User, select: u, order_by: [asc: u.email]
      "last" -> from u in User, select: u, order_by: [desc: u.inserted_at]
      "first" -> from u in User, select: u, order_by: [asc: u.inserted_at]
      "name" -> from u in User, select: u, order_by: [asc: u.name]
    end
  end

  defp get_pages(pages, res) do
    repages = if (res > 0) do
      pages = pages + 1
      pages
    else
      pages
    end
    repages
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_by_email(email) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_user_auth0(user = %User{}) do
    with {:ok, user} <- Auth0User.create("Username-Password-Authentication", %{name: "#{user.name} #{user.middle_name} #{user.last_name}", email: user.email, password: "p4ssw0rD"}) do
      user = user |> Jason.decode!
      %{id_auth0: user["user_id"]}
    end
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_user_auth0(%User{} = user, attrs) do
    case Map.has_key?(attrs, :password) do
      true -> Auth0User.update(user.id_auth0, password: attrs.password)
      false -> Auth0User.update(user.id_auth0, %{name: "#{user.name} #{user.middle_name} #{user.last_name}"})
    end
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Auth0User.delete(user.id_auth0)
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
