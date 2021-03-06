defmodule RumbleWeb.Router do
  use RumbleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RumbleWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RumbleWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/watch/:id", WatchController, :show
  end

  scope "/manage", RumbleWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/videos", VideoController
  end

  # Other scopes may use custom stacks.
  # scope "/api", RumbleWeb do
  #   pipe_through :api
  # end
end
