defmodule Template.MonoWeb.ResourceController do
  use Template.MonoWeb, :controller

  alias Template.Mono.Stuff
  alias Template.Mono.Stuff.Resource

  plug(:put_root_layout, {Template.MonoWeb.Layouts, "torch.html"})
  plug(:put_layout, false)

  def index(conn, params) do
    case Stuff.paginate_resources(params) do
      {:ok, assigns} ->
        render(conn, :index, assigns)
      {:error, error} ->
        conn
        |> put_flash(:error, "There was an error rendering Resources. #{inspect(error)}")
        |> redirect(to: ~p"/resources")
    end
  end

  def new(conn, _params) do
    changeset = Stuff.change_resource(%Resource{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"resource" => resource_params}) do
    case Stuff.create_resource(resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource created successfully.")
        |> redirect(to: ~p"/resources/#{resource}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    resource = Stuff.get_resource!(id)
    render(conn, :show, resource: resource)
  end

  def edit(conn, %{"id" => id}) do
    resource = Stuff.get_resource!(id)
    changeset = Stuff.change_resource(resource)
    render(conn, :edit, resource: resource, changeset: changeset)
  end

  def update(conn, %{"id" => id, "resource" => resource_params}) do
    resource = Stuff.get_resource!(id)

    case Stuff.update_resource(resource, resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource updated successfully.")
        |> redirect(to: ~p"/resources/#{resource}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, resource: resource, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    resource = Stuff.get_resource!(id)
    {:ok, _resource} = Stuff.delete_resource(resource)

    conn
    |> put_flash(:info, "Resource deleted successfully.")
    |> redirect(to: ~p"/resources")
  end
end
