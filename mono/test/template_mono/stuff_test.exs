defmodule Template.Mono.StuffTest do
  use Template.Mono.DataCase

  alias Template.Mono.Stuff

  alias Template.Mono.Stuff.Resource

  @valid_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "#paginate_resources/1" do
    test "returns paginated list of resources" do
      for _ <- 1..20 do
        resource_fixture()
      end

      {:ok, %{resources: resources} = page} = Stuff.paginate_resources(%{})

      assert length(resources) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_resources/0" do
    test "returns all resources" do
      resource = resource_fixture()
      assert Stuff.list_resources() == [resource]
    end
  end

  describe "#get_resource!/1" do
    test "returns the resource with given id" do
      resource = resource_fixture()
      assert Stuff.get_resource!(resource.id) == resource
    end
  end

  describe "#create_resource/1" do
    test "with valid data creates a resource" do
      assert {:ok, %Resource{} = resource} = Stuff.create_resource(@valid_attrs)
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stuff.create_resource(@invalid_attrs)
    end
  end

  describe "#update_resource/2" do
    test "with valid data updates the resource" do
      resource = resource_fixture()
      assert {:ok, resource} = Stuff.update_resource(resource, @update_attrs)
      assert %Resource{} = resource
    end

    test "with invalid data returns error changeset" do
      resource = resource_fixture()
      assert {:error, %Ecto.Changeset{}} = Stuff.update_resource(resource, @invalid_attrs)
      assert resource == Stuff.get_resource!(resource.id)
    end
  end

  describe "#delete_resource/1" do
    test "deletes the resource" do
      resource = resource_fixture()
      assert {:ok, %Resource{}} = Stuff.delete_resource(resource)
      assert_raise Ecto.NoResultsError, fn -> Stuff.get_resource!(resource.id) end
    end
  end

  describe "#change_resource/1" do
    test "returns a resource changeset" do
      resource = resource_fixture()
      assert %Ecto.Changeset{} = Stuff.change_resource(resource)
    end
  end

  def resource_fixture(attrs \\ %{}) do
    {:ok, resource} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Stuff.create_resource()

    resource
  end

end
