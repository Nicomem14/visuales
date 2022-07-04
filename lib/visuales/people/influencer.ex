defmodule Visuales.People.Influencer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "influencers" do
    field :content, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(influencer, attrs) do
    influencer
    |> cast(attrs, [:name, :content])
    |> validate_required([:name, :content])
  end
end
