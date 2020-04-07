defmodule AppnamehereWeb.Router do
  use AppnamehereWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", AppnamehereWeb do
    pipe_through :api

    get "/blog/post", PostController, :index

    get "/text/generate/:language/:type", TextController, :generate
  end
end
