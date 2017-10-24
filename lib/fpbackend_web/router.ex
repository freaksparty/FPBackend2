defmodule FpbackendWeb.Router do
  use Fpbackend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FpbackendWeb do
    pipe_through :api

    resources "/events", EventController, except: [:new, :edit] do
      resources "/activities", ActivityController, except: [:new, :edit]
      resources "/sponsors", SponsorController, except: [:new, :edit]
      resources "/news", NewsController, except: [:new, :edit]
    end

    resources "/users", UserController, except: [:new, :edit]

    scope "/auth" do
      post "/", AuthController, :sign_in
      put "/", AuthController, :exchange
      delete "/", AuthController, :sign_out
    end
  end
end
