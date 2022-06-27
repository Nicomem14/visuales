defmodule VisualesWeb.ImageLive.FormComponent do
  use VisualesWeb, :live_component

  alias Visuales.Media

  @impl true
  def update(%{image: image} = assigns, socket) do
    changeset = Media.change_image(image)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> allow_upload(:photo, accept: ~w(video/* image/*), max_entries: 2)}
  end

  @impl true
  def handle_event("validate", %{"image" => image_params}, socket) do
    changeset =
      socket.assigns.image
      |> Media.change_image(image_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"image" => image_params}, socket) do

    uploaded_files =
      consume_uploaded_entries(socket, :photo, fn %{path: path}, _entry ->
        dest = Path.join([:code.priv_dir(:visuales), "static", "uploads", Path.basename(path)])
        # The `static/uploads` directory must exist for `File.cp!/2` to work.
        File.cp!(path, dest)
        {:ok, Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")}
      end)

      Map.put_new(image_params, "photo", uploaded_files)

      save_image(socket, socket.assigns.action, image_params)
  end

  defp save_image(socket, :edit, image_params) do
    case Media.update_image(socket.assigns.image, image_params) do
      {:ok, _image} ->
        {:noreply,
         socket
         |> put_flash(:info, "Image updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_image(socket, :new, image_params) do
    case Media.create_image(image_params) do
      {:ok, _image} ->
        {:noreply,
         socket
         |> put_flash(:info, "Image created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
