defmodule Visuales.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :name, :string
      add :active, :boolean, default: true, null: false

      timestamps()
    end
  end
end
