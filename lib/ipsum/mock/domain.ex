defmodule Ipsum.Mock.Domain do
  use Ecto.Schema
  import Ecto.Changeset

  schema "domains" do
    field :description, :string
    field :name, :string
    field :stub, :map

    timestamps()
  end

  @doc false
  def changeset(domain, attrs) do
    domain
    |> cast(attrs, [:name, :description, :stub])
    |> validate_required([:name, :description, :stub])
  end
end
