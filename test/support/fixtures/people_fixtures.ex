defmodule Visuales.PeopleFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Visuales.People` context.
  """

  @doc """
  Generate a influencer.
  """
  def influencer_fixture(attrs \\ %{}) do
    {:ok, influencer} =
      attrs
      |> Enum.into(%{
        content: "some content",
        name: "some name"
      })
      |> Visuales.People.create_influencer()

    influencer
  end
end
