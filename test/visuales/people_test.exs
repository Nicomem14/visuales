defmodule Visuales.PeopleTest do
  use Visuales.DataCase

  alias Visuales.People

  describe "influencers" do
    alias Visuales.People.Influencer

    import Visuales.PeopleFixtures

    @invalid_attrs %{content: nil, name: nil}

    test "list_influencers/0 returns all influencers" do
      influencer = influencer_fixture()
      assert People.list_influencers() == [influencer]
    end

    test "get_influencer!/1 returns the influencer with given id" do
      influencer = influencer_fixture()
      assert People.get_influencer!(influencer.id) == influencer
    end

    test "create_influencer/1 with valid data creates a influencer" do
      valid_attrs = %{content: "some content", name: "some name"}

      assert {:ok, %Influencer{} = influencer} = People.create_influencer(valid_attrs)
      assert influencer.content == "some content"
      assert influencer.name == "some name"
    end

    test "create_influencer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create_influencer(@invalid_attrs)
    end

    test "update_influencer/2 with valid data updates the influencer" do
      influencer = influencer_fixture()
      update_attrs = %{content: "some updated content", name: "some updated name"}

      assert {:ok, %Influencer{} = influencer} = People.update_influencer(influencer, update_attrs)
      assert influencer.content == "some updated content"
      assert influencer.name == "some updated name"
    end

    test "update_influencer/2 with invalid data returns error changeset" do
      influencer = influencer_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_influencer(influencer, @invalid_attrs)
      assert influencer == People.get_influencer!(influencer.id)
    end

    test "delete_influencer/1 deletes the influencer" do
      influencer = influencer_fixture()
      assert {:ok, %Influencer{}} = People.delete_influencer(influencer)
      assert_raise Ecto.NoResultsError, fn -> People.get_influencer!(influencer.id) end
    end

    test "change_influencer/1 returns a influencer changeset" do
      influencer = influencer_fixture()
      assert %Ecto.Changeset{} = People.change_influencer(influencer)
    end
  end
end
