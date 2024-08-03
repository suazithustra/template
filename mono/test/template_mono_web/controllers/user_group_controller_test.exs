defmodule Template.MonoWeb.UserGroupControllerTest do
  use Template.MonoWeb.ConnCase

  alias Template.Mono.Accounts

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:user_group) do
    {:ok, user_group} = Accounts.create_user_group(@create_attrs)
    user_group
  end

  describe "index" do
    test "lists all usergroups", %{conn: conn} do
      conn = get conn, ~p"/usergroups"
      assert html_response(conn, 200) =~ "Usergroups"
    end
  end

  describe "new user_group" do
    test "renders form", %{conn: conn} do
      conn = get conn, ~p"/usergroups/new"
      assert html_response(conn, 200) =~ "New User group"
    end
  end

  describe "create user_group" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, ~p"/usergroups", user_group: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == "/usergroups/#{id}"

      conn = get conn, ~p"/usergroups/#{id}"
      assert html_response(conn, 200) =~ "User group Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ~p"/usergroups", user_group: @invalid_attrs
      assert html_response(conn, 200) =~ "New User group"
    end
  end

  describe "edit user_group" do
    setup [:create_user_group]

    test "renders form for editing chosen user_group", %{conn: conn, user_group: user_group} do
      conn = get conn, ~p"/usergroups/#{user_group}/edit"
      assert html_response(conn, 200) =~ "Edit User group"
    end
  end

  describe "update user_group" do
    setup [:create_user_group]

    test "redirects when data is valid", %{conn: conn, user_group: user_group} do
      conn = put conn, ~p"/usergroups/#{user_group}", user_group: @update_attrs
      assert redirected_to(conn) == ~p"/usergroups/#{user_group}"

      conn = get conn, ~p"/usergroups/#{user_group}" 
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user_group: user_group} do
      conn = put conn, ~p"/usergroups/#{user_group}", user_group: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit User group"
    end
  end

  describe "delete user_group" do
    setup [:create_user_group]

    test "deletes chosen user_group", %{conn: conn, user_group: user_group} do
      conn = delete conn, ~p"/usergroups/#{user_group}"
      assert redirected_to(conn) == "/usergroups"
      assert_error_sent 404, fn ->
        get conn, ~p"/usergroups/#{user_group}"
      end
    end
  end

  defp create_user_group(_) do
    user_group = fixture(:user_group)
    {:ok, user_group: user_group}
  end
end
