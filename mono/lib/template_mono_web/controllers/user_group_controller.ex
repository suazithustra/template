defmodule Template.MonoWeb.UserGroupController do
  use Template.MonoWeb, :controller

  alias Template.Mono.Accounts
  alias Template.Mono.Accounts.UserGroup

  plug(:put_root_layout, {Template.MonoWeb.Layouts, "torch.html"})
  plug(:put_layout, false)

  def index(conn, params) do
    case Accounts.paginate_usergroups(params) do
      {:ok, assigns} ->
        render(conn, :index, assigns)
      {:error, error} ->
        conn
        |> put_flash(:error, "There was an error rendering Usergroups. #{inspect(error)}")
        |> redirect(to: ~p"/usergroups")
    end
  end

  def new(conn, _params) do
    changeset = Accounts.change_user_group(%UserGroup{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user_group" => user_group_params}) do
    case Accounts.create_user_group(user_group_params) do
      {:ok, user_group} ->
        conn
        |> put_flash(:info, "User group created successfully.")
        |> redirect(to: ~p"/usergroups/#{user_group}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_group = Accounts.get_user_group!(id)
    render(conn, :show, user_group: user_group)
  end

  def edit(conn, %{"id" => id}) do
    user_group = Accounts.get_user_group!(id)
    changeset = Accounts.change_user_group(user_group)
    render(conn, :edit, user_group: user_group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_group" => user_group_params}) do
    user_group = Accounts.get_user_group!(id)

    case Accounts.update_user_group(user_group, user_group_params) do
      {:ok, user_group} ->
        conn
        |> put_flash(:info, "User group updated successfully.")
        |> redirect(to: ~p"/usergroups/#{user_group}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, user_group: user_group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_group = Accounts.get_user_group!(id)
    {:ok, _user_group} = Accounts.delete_user_group(user_group)

    conn
    |> put_flash(:info, "User group deleted successfully.")
    |> redirect(to: ~p"/usergroups")
  end
end
