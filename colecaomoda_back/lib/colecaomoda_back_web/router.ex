defmodule ColecaomodaBackWeb.Router do
  use ColecaomodaBackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ColecaomodaBackWeb do
    pipe_through :api
  end


end
