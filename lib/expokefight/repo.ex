defmodule Expokefight.Repo do
  use Ecto.Repo,
    otp_app: :expokefight,
    adapter: Ecto.Adapters.Postgres
end
