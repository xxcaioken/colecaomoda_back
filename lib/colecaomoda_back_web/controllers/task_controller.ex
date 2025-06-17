defmodule ColecaomodaBackWeb.TaskController do
  use ColecaomodaBackWeb, :controller

  alias ColecaomodaBack.Tasks
  alias ColecaomodaBack.Tasks.Task

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    json(conn, %{data: tasks})
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", "/api/tasks/#{task.id}")
      |> json(%{data: task})
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    json(conn, %{data: task})
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      json(conn, %{data: task})
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{}} <- Tasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end

  def complete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{} = task} <- Tasks.complete_task(task) do
      json(conn, %{data: task})
    end
  end
end
