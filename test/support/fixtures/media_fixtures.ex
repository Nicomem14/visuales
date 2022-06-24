defmodule Visuales.MediaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Visuales.Media` context.
  """

  @doc """
  Generate a image.
  """
  def image_fixture(attrs \\ %{}) do
    {:ok, image} =
      attrs
      |> Enum.into(%{
        active: true,
        name: "some name"
      })
      |> Visuales.Media.create_image()

    image
  end
end
