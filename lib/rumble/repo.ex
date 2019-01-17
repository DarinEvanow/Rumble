defmodule Rumble.Repo do
  use Ecto.Repo,
    otp_app: :rumble,
    adapter: Ecto.Adapters.Postgres
end
