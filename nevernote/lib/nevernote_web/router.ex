defmodule NevernoteWeb.Router do
  use NevernoteWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :browser_auth do
    plug(NevernoteWeb.Guardian.AuthPipeline)
    plug(NevernoteWeb.Plug.CurrentUser)
  end

  pipeline :browser_ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(NevernoteWeb.Plug.CurrentUser)
  end

  scope "/", NevernoteWeb do
    # Application unauthenticated scope
    scope "/" do
      pipe_through([:browser, :browser_auth])

      get("/", PageController, :index)

      resources("/session", SessionController, only: [:new, :create])

      # Log out resource
      get("/logout", SessionController, :delete)
    end

    # Application authenticated scope
    scope "/" do
      pipe_through([:browser, :browser_auth, :browser_ensure_auth])

      resources("/blocknotes", BlocknoteController)
      resources("/notes", NoteController, except: [:index, :show])
    end
  end
end
