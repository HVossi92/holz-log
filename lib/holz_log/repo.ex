defmodule HolzLog.Repo do
  use Ecto.Repo,
    otp_app: :holz_log,
    adapter: Ecto.Adapters.SQLite3
end
