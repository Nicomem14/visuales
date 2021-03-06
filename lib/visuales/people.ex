defmodule Visuales.People do
  @moduledoc """
  The People context.
  """

  import Ecto.Query, warn: false
  alias Visuales.Repo

  alias Visuales.People.Influencer

  @doc """
  Returns the list of influencers.

  ## Examples

      iex> list_influencers()
      [%Influencer{}, ...]

  """
  def list_influencers do
    Repo.all(Influencer)
  end

  @doc """
  Gets a single influencer.

  Raises `Ecto.NoResultsError` if the Influencer does not exist.

  ## Examples

      iex> get_influencer!(123)
      %Influencer{}

      iex> get_influencer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_influencer!(id), do: Repo.get!(Influencer, id)

  def get_influencer_by_name(name) when is_bitstring(name),
  do: Repo.get_by(Influencer, name: name)

  @doc """
  Creates a influencer.

  ## Examples

      iex> create_influencer(%{field: value})
      {:ok, %Influencer{}}

      iex> create_influencer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_influencer(attrs \\ %{}) do
    %Influencer{}
    |> Influencer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a influencer.

  ## Examples

      iex> update_influencer(influencer, %{field: new_value})
      {:ok, %Influencer{}}

      iex> update_influencer(influencer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_influencer(%Influencer{} = influencer, attrs) do
    influencer
    |> Influencer.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, %{name: name}} = response ->
        Phoenix.PubSub.broadcast(Visuales.PubSub, "influencer:#{name}", :influencer_updated)
        response
      error ->
        error
    end
  end

  @doc """
  Deletes a influencer.

  ## Examples

      iex> delete_influencer(influencer)
      {:ok, %Influencer{}}

      iex> delete_influencer(influencer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_influencer(%Influencer{} = influencer) do
    Repo.delete(influencer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking influencer changes.

  ## Examples

      iex> change_influencer(influencer)
      %Ecto.Changeset{data: %Influencer{}}

  """
  def change_influencer(%Influencer{} = influencer, attrs \\ %{}) do
    Influencer.changeset(influencer, attrs)
  end
end
