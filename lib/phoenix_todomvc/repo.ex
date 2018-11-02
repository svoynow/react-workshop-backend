defmodule PhoenixTodomvc.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_todomvc,
    adapter: Ecto.Adapters.Postgres
end
