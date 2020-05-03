defmodule Ipsum.Repo.Migrations.CreateDomains do
  use Ecto.Migration

  def change do
    create table(:domains) do
      add :name, :string
      add :description, :string
      add :stub, :map

      timestamps()
    end

  end
end
