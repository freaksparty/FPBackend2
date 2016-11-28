defmodule Fpbackend.Router do
  use Fpbackend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Fpbackend do
    pipe_through :api

    resources "/events", EventController, except: [:new, :edit] do
      get "/all", EventController, :all_nested
      resources "/activities", ActivityController, except: [:new, :edit]
    end
    
    resources "/users", UserController, except: [:new, :edit]
  end
end
