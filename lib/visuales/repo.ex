defmodule Visuales.Repo do
  use Ecto.Repo,
    otp_app: :visuales,
    adapter: Ecto.Adapters.Postgres
end
