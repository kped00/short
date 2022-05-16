defmodule Short.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :owner, :string
      add :customurl, :string
      add :url, :string

      timestamps()
    end
  end
end
