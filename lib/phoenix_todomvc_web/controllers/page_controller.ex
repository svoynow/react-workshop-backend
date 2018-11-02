defmodule PhoenixTodomvcWeb.PageController do
  use PhoenixTodomvcWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
