defmodule Visuales.Repo.Migrations.CreateInfluencers do
  use Ecto.Migration

  def change do
    create table(:influencers) do
      add :name, :string
      add :content, :string

      timestamps()
    end

    create unique_index(:influencers, :name)
  end
end
