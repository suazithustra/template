defmodule Template.Mono.Accounts.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "usergroups" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [])
    |> validate_required([])
  end
end
