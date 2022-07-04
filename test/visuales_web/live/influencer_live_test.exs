defmodule VisualesWeb.InfluencerLiveTest do
  use VisualesWeb.ConnCase

  import Phoenix.LiveViewTest
  import Visuales.PeopleFixtures

  @create_attrs %{content: "some content", name: "some name"}
  @update_attrs %{content: "some updated content", name: "some updated name"}
  @invalid_attrs %{content: nil, name: nil}

  defp create_influencer(_) do
    influencer = influencer_fixture()
    %{influencer: influencer}
  end

  describe "Index" do
    setup [:create_influencer]

    test "lists all influencers", %{conn: conn, influencer: influencer} do
      {:ok, _index_live, html} = live(conn, Routes.influencer_index_path(conn, :index))

      assert html =~ "Listing Influencers"
      assert html =~ influencer.content
    end

    test "saves new influencer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.influencer_index_path(conn, :index))

      assert index_live |> element("a", "New Influencer") |> render_click() =~
               "New Influencer"

      assert_patch(index_live, Routes.influencer_index_path(conn, :new))

      assert index_live
             |> form("#influencer-form", influencer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#influencer-form", influencer: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.influencer_index_path(conn, :index))

      assert html =~ "Influencer created successfully"
      assert html =~ "some content"
    end

    test "updates influencer in listing", %{conn: conn, influencer: influencer} do
      {:ok, index_live, _html} = live(conn, Routes.influencer_index_path(conn, :index))

      assert index_live |> element("#influencer-#{influencer.id} a", "Edit") |> render_click() =~
               "Edit Influencer"

      assert_patch(index_live, Routes.influencer_index_path(conn, :edit, influencer))

      assert index_live
             |> form("#influencer-form", influencer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#influencer-form", influencer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.influencer_index_path(conn, :index))

      assert html =~ "Influencer updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes influencer in listing", %{conn: conn, influencer: influencer} do
      {:ok, index_live, _html} = live(conn, Routes.influencer_index_path(conn, :index))

      assert index_live |> element("#influencer-#{influencer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#influencer-#{influencer.id}")
    end
  end

  describe "Show" do
    setup [:create_influencer]

    test "displays influencer", %{conn: conn, influencer: influencer} do
      {:ok, _show_live, html} = live(conn, Routes.influencer_show_path(conn, :show, influencer))

      assert html =~ "Show Influencer"
      assert html =~ influencer.content
    end

    test "updates influencer within modal", %{conn: conn, influencer: influencer} do
      {:ok, show_live, _html} = live(conn, Routes.influencer_show_path(conn, :show, influencer))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Influencer"

      assert_patch(show_live, Routes.influencer_show_path(conn, :edit, influencer))

      assert show_live
             |> form("#influencer-form", influencer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#influencer-form", influencer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.influencer_show_path(conn, :show, influencer))

      assert html =~ "Influencer updated successfully"
      assert html =~ "some updated content"
    end
  end
end
