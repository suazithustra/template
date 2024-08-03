defmodule Template.MonoWeb.OrganizationController do
  use Template.MonoWeb, :controller

  alias Template.Mono.Accounts
  alias Template.Mono.Accounts.Organization

  plug(:put_root_layout, {Template.MonoWeb.Layouts, "torch.html"})
  plug(:put_layout, false)

  def index(conn, params) do
    case Accounts.paginate_organizations(params) do
      {:ok, assigns} ->
        render(conn, :index, assigns)
      {:error, error} ->
        conn
        |> put_flash(:error, "There was an error rendering Organizations. #{inspect(error)}")
        |> redirect(to: ~p"/organizations")
    end
  end

  def new(conn, _params) do
    changeset = Accounts.change_organization(%Organization{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"organization" => organization_params}) do
    case Accounts.create_organization(organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization created successfully.")
        |> redirect(to: ~p"/organizations/#{organization}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organization = Accounts.get_organization!(id)
    render(conn, :show, organization: organization)
  end

  def edit(conn, %{"id" => id}) do
    organization = Accounts.get_organization!(id)
    changeset = Accounts.change_organization(organization)
    render(conn, :edit, organization: organization, changeset: changeset)
  end

  def update(conn, %{"id" => id, "organization" => organization_params}) do
    organization = Accounts.get_organization!(id)

    case Accounts.update_organization(organization, organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization updated successfully.")
        |> redirect(to: ~p"/organizations/#{organization}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, organization: organization, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    organization = Accounts.get_organization!(id)
    {:ok, _organization} = Accounts.delete_organization(organization)

    conn
    |> put_flash(:info, "Organization deleted successfully.")
    |> redirect(to: ~p"/organizations")
  end
end
