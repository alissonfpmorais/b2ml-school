defmodule B2ml.Repo do
  use Ecto.Repo,
    otp_app: :b2ml,
    adapter: Ecto.Adapters.Postgres
end
