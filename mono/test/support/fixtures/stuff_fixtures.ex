defmodule Template.Mono.StuffFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Template.Mono.Stuff` context.
  """

  @doc """
  Generate a resource.
  """
  def resource_fixture(attrs \\ %{}) do
    {:ok, resource} =
      attrs
      |> Enum.into(%{

      })
      |> Template.Mono.Stuff.create_resource()

    resource
  end
end
