defmodule Template.Mono.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Template.Mono.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email"
      })
      |> Template.Mono.Accounts.create_user()

    user
  end

  @doc """
  Generate a user_group.
  """
  def user_group_fixture(attrs \\ %{}) do
    {:ok, user_group} =
      attrs
      |> Enum.into(%{

      })
      |> Template.Mono.Accounts.create_user_group()

    user_group
  end

  @doc """
  Generate a organization.
  """
  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{

      })
      |> Template.Mono.Accounts.create_organization()

    organization
  end
end
