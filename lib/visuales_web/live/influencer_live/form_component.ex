defmodule VisualesWeb.InfluencerLive.FormComponent do
  use VisualesWeb, :live_component

  alias Visuales.People

  @impl true
  def update(%{influencer: influencer} = assigns, socket) do
    changeset = People.change_influencer(influencer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"influencer" => influencer_params}, socket) do
    changeset =
      socket.assigns.influencer
      |> People.change_influencer(influencer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"influencer" => influencer_params}, socket) do
    save_influencer(socket, socket.assigns.action, influencer_params)
  end

  defp save_influencer(socket, :edit, influencer_params) do
    case People.update_influencer(socket.assigns.influencer, influencer_params) do
      {:ok, _influencer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Influencer updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_influencer(socket, :new, influencer_params) do
    case People.create_influencer(influencer_params) do
      {:ok, _influencer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Influencer created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
