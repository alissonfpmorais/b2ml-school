defmodule B2mlWeb.Router do
  use B2mlWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug B2mlWeb.Plugs.SetLocale
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", B2mlWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/teachers", TeacherController
    resources "/students", StudentController
    resources "/classes", ClassController
  end

  # Other scopes may use custom stacks.
  # scope "/api", B2mlWeb do
  #   pipe_through :api
  # end
end
