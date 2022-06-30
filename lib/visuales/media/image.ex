defmodule Visuales.Media.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :active, :boolean, default: false
    field :name, :string
    field :photo, :string

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:name, :active, :photo])
    |> validate_required([:name, :active, :photo])
    |> unique_constraint(:name)
  end
end
