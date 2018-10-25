defmodule NevernoteWeb.PageController do
  use NevernoteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
