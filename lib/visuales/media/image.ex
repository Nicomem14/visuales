defmodule Visuales.Media.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :active, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
    |> unique_constraint(:name)
  end
end
