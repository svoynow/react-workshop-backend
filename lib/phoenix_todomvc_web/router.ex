defmodule PhoenixTodomvcWeb.Router do
  use PhoenixTodomvcWeb, :router

  pipeline :api do
    plug :cors
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixTodomvcWeb do
    pipe_through :api
    resources "/todos", TodoController
    options "/todos", TodoController, :options
    options "/todos/:id", TodoController, :options
    delete "/todos", TodoController, :delete_all
  end

  def cors(conn, _opts) do
    conn
    |> put_resp_header("Access-Control-Allow-Origin", "*")
    |> put_resp_header("Access-Control-Allow-Headers", "Content-Type")
    |> put_resp_header("Access-Control-Allow-Methods", "GET,PUT,PATCH,OPTIONS,DELETE,POST")
  end
end
