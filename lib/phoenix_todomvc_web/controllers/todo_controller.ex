defmodule PhoenixTodomvcWeb.TodoController do
  use PhoenixTodomvcWeb, :controller

  alias PhoenixTodomvc.Todos
  alias PhoenixTodomvc.Todos.Todo

  action_fallback PhoenixTodomvcWeb.FallbackController

  def index(conn, _params) do
    todos = Todos.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %Todo{} = todo} <- Todos.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Todos.get_todo!(id)

    with {:ok, %Todo{} = todo} <- Todos.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)

    with {:ok, %Todo{}} <- Todos.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete_all(conn) do
    Todos.delete_all()
    render(conn, "index.json", todos: Todos.list_todos())    
  end

  def options(conn, _params) do
    conn
    |> send_resp(200, "GET,POST,DELETE,OPTIONS,PUT")
  end


end
