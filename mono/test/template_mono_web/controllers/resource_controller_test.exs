defmodule Template.MonoWeb.ResourceControllerTest do
  use Template.MonoWeb.ConnCase

  alias Template.Mono.Stuff

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:resource) do
    {:ok, resource} = Stuff.create_resource(@create_attrs)
    resource
  end

  describe "index" do
    test "lists all resources", %{conn: conn} do
      conn = get conn, ~p"/resources"
      assert html_response(conn, 200) =~ "Resources"
    end
  end

  describe "new resource" do
    test "renders form", %{conn: conn} do
      conn = get conn, ~p"/resources/new"
      assert html_response(conn, 200) =~ "New Resource"
    end
  end

  describe "create resource" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, ~p"/resources", resource: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == "/resources/#{id}"

      conn = get conn, ~p"/resources/#{id}"
      assert html_response(conn, 200) =~ "Resource Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ~p"/resources", resource: @invalid_attrs
      assert html_response(conn, 200) =~ "New Resource"
    end
  end

  describe "edit resource" do
    setup [:create_resource]

    test "renders form for editing chosen resource", %{conn: conn, resource: resource} do
      conn = get conn, ~p"/resources/#{resource}/edit"
      assert html_response(conn, 200) =~ "Edit Resource"
    end
  end

  describe "update resource" do
    setup [:create_resource]

    test "redirects when data is valid", %{conn: conn, resource: resource} do
      conn = put conn, ~p"/resources/#{resource}", resource: @update_attrs
      assert redirected_to(conn) == ~p"/resources/#{resource}"

      conn = get conn, ~p"/resources/#{resource}" 
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, resource: resource} do
      conn = put conn, ~p"/resources/#{resource}", resource: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Resource"
    end
  end

  describe "delete resource" do
    setup [:create_resource]

    test "deletes chosen resource", %{conn: conn, resource: resource} do
      conn = delete conn, ~p"/resources/#{resource}"
      assert redirected_to(conn) == "/resources"
      assert_error_sent 404, fn ->
        get conn, ~p"/resources/#{resource}"
      end
    end
  end

  defp create_resource(_) do
    resource = fixture(:resource)
    {:ok, resource: resource}
  end
end
