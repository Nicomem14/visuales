defmodule VisualesWeb.InfluencerLive.Index do
  use VisualesWeb, :live_view

  alias Visuales.People
  alias Visuales.People.Influencer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :influencers, list_influencers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"name" => name}) do
    images = Visuales.Media.list_images()

    socket
    |> assign(:page_title, "Edit Influencer")
    |> assign(:images, images)
    |> assign(:influencer, People.get_influencer_by_name(name))
  end

  defp apply_action(socket, :new, _params) do
    images = Visuales.Media.list_images()

    socket
    |> assign(:page_title, "New Influencer")
    |> assign(:images, images)
    |> assign(:influencer, %Influencer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Influencers")
    |> assign(:influencer, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    influencer = People.get_influencer!(id)
    {:ok, _} = People.delete_influencer(influencer)

    {:noreply, assign(socket, :influencers, list_influencers())}
  end

  defp list_influencers do
    People.list_influencers()
  end
end
