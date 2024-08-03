defmodule Template.Mono.AccountsTest do
  use Template.Mono.DataCase

  alias Template.Mono.Accounts

  alias Template.Mono.Accounts.User

  @valid_attrs %{email: "some email"}
  @update_attrs %{email: "some updated email"}
  @invalid_attrs %{email: nil}

  describe "#paginate_users/1" do
    test "returns paginated list of users" do
      for _ <- 1..20 do
        user_fixture()
      end

      {:ok, %{users: users} = page} = Accounts.paginate_users(%{})

      assert length(users) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_users/0" do
    test "returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end
  end

  describe "#get_user!/1" do
    test "returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end
  end

  describe "#create_user/1" do
    test "with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end

  describe "#update_user/2" do
    test "with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
    end

    test "with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end
  end

  describe "#delete_user/1" do
    test "deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end
  end

  describe "#change_user/1" do
    test "returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.create_user()

    user
  end


  alias Template.Mono.Accounts.UserGroup

  @valid_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "#paginate_usergroups/1" do
    test "returns paginated list of usergroups" do
      for _ <- 1..20 do
        user_group_fixture()
      end

      {:ok, %{usergroups: usergroups} = page} = Accounts.paginate_usergroups(%{})

      assert length(usergroups) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_usergroups/0" do
    test "returns all usergroups" do
      user_group = user_group_fixture()
      assert Accounts.list_usergroups() == [user_group]
    end
  end

  describe "#get_user_group!/1" do
    test "returns the user_group with given id" do
      user_group = user_group_fixture()
      assert Accounts.get_user_group!(user_group.id) == user_group
    end
  end

  describe "#create_user_group/1" do
    test "with valid data creates a user_group" do
      assert {:ok, %UserGroup{} = user_group} = Accounts.create_user_group(@valid_attrs)
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_group(@invalid_attrs)
    end
  end

  describe "#update_user_group/2" do
    test "with valid data updates the user_group" do
      user_group = user_group_fixture()
      assert {:ok, user_group} = Accounts.update_user_group(user_group, @update_attrs)
      assert %UserGroup{} = user_group
    end

    test "with invalid data returns error changeset" do
      user_group = user_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_group(user_group, @invalid_attrs)
      assert user_group == Accounts.get_user_group!(user_group.id)
    end
  end

  describe "#delete_user_group/1" do
    test "deletes the user_group" do
      user_group = user_group_fixture()
      assert {:ok, %UserGroup{}} = Accounts.delete_user_group(user_group)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_group!(user_group.id) end
    end
  end

  describe "#change_user_group/1" do
    test "returns a user_group changeset" do
      user_group = user_group_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_group(user_group)
    end
  end

  def user_group_fixture(attrs \\ %{}) do
    {:ok, user_group} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.create_user_group()

    user_group
  end


  alias Template.Mono.Accounts.Organization

  @valid_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "#paginate_organizations/1" do
    test "returns paginated list of organizations" do
      for _ <- 1..20 do
        organization_fixture()
      end

      {:ok, %{organizations: organizations} = page} = Accounts.paginate_organizations(%{})

      assert length(organizations) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_organizations/0" do
    test "returns all organizations" do
      organization = organization_fixture()
      assert Accounts.list_organizations() == [organization]
    end
  end

  describe "#get_organization!/1" do
    test "returns the organization with given id" do
      organization = organization_fixture()
      assert Accounts.get_organization!(organization.id) == organization
    end
  end

  describe "#create_organization/1" do
    test "with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = Accounts.create_organization(@valid_attrs)
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_organization(@invalid_attrs)
    end
  end

  describe "#update_organization/2" do
    test "with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, organization} = Accounts.update_organization(organization, @update_attrs)
      assert %Organization{} = organization
    end

    test "with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_organization(organization, @invalid_attrs)
      assert organization == Accounts.get_organization!(organization.id)
    end
  end

  describe "#delete_organization/1" do
    test "deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Accounts.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_organization!(organization.id) end
    end
  end

  describe "#change_organization/1" do
    test "returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Accounts.change_organization(organization)
    end
  end

  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.create_organization()

    organization
  end

end
