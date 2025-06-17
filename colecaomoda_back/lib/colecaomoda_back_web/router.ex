defmodule ColecaomodaBackWeb.Router do
  use ColecaomodaBackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ColecaomodaBackWeb do
    pipe_through :api

    resources "/tasks", TaskController, except: [:new, :edit]

    put "/tasks/:id/complete", TaskController, :complete
  end
end
