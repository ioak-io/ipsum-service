defmodule Ipsum.Repo do
  use Ecto.Repo,
    otp_app: :ipsum,
    adapter: Ecto.Adapters.Postgres
end
