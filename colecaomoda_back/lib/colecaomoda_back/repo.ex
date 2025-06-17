defmodule ColecaomodaBack.Repo do
  use Ecto.Repo,
    otp_app: :colecaomoda_back,
    adapter: Ecto.Adapters.SQLite3
end
