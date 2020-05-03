defmodule IpsumWeb.Router do
  use IpsumWeb, :router

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
  scope "/api", IpsumWeb do
    pipe_through :api

    get "/blog/post", PostController, :index

    post "/text/corpus", TextController, :get_corpus
    get "/text/generate/:language/:type", TextController, :generate
    resources "/domain", DomainController
    get "/verb/:id", VerbController, :get
    post "/flatten", FlattenController, :flatten
  end
end
