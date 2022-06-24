defmodule Visuales.Repo.Migrations.AddPhotoToImages do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :photo, :string
    end
  end
end
