defmodule VisualesWeb.InfluencerLive.Show do
  use VisualesWeb, :live_view

  alias Visuales.People

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:influencer, People.get_influencer!(id))}
  end

  defp page_title(:show), do: "Show Influencer"
  defp page_title(:edit), do: "Edit Influencer"
end
