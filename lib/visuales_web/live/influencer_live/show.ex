defmodule VisualesWeb.InfluencerLive.Show do
  use VisualesWeb, :live_view

  alias Visuales.People

  @impl true
  def mount(_params, _session, socket),
  do:
    socket
    |> with_ok()

  @impl true
  def handle_params(%{"name" => name}, _, socket) do
    Phoenix.PubSub.subscribe(Visuales.PubSub, "influencer:#{name}")
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:influencer_name, name)
      |> assign_content()
      |> with_noreply()
  end

  defp page_title(:show), do: "Show Influencer"
  defp page_title(:edit), do: "Edit Influencer"
  defp default_content(), do: "por defecto"
  defp with_noreply(socket), do: {:noreply, socket}
  defp with_ok(socket), do: {:ok, socket}
  defp assign_content(%{assigns: %{influencer_name: name}} = socket),
  do: assign(socket, :influencer_content, People.get_influencer_by_name(name) |> Map.get(:content, default_content()))

  @impl true
  def handle_info(:influencer_updated, %{assigns: %{influencer_name: name}} = socket) do
    socket
    |> push_redirect(to: Routes.influencer_show_path(socket, :show, name))
    |> with_noreply()
  end

  def render(assigns) do
    ~H"""
    <video width="50%" height="50%" autoplay muted loop>
      <source src={@influencer_content} type="video/webm">
    </video>
    """
  end
end
