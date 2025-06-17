defmodule ColecaomodaBackWeb.TaskController do
  use ColecaomodaBackWeb, :controller

  alias ColecaomodaBack.Tasks

  def index(conn, _params) do
    tasks = Tasks.list_tasks()

    json(conn, %{
      data: tasks
    })
  end

  def show(conn, %{"id" => id}) do
    case Tasks.get_task(id) do
      {:ok, task} ->
        json(conn, %{
          data: task
        })

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{
          error: %{
            message: "Task não encontrada",
            code: "TASK_NOT_FOUND"
          }
        })
    end
  end

  def create(conn, %{"task" => task_params}) do
    clean_params = Map.drop(task_params, ["inserted_at", "updated_at"])

    case Tasks.create_task(clean_params) do
      {:ok, task} ->
        conn
        |> put_status(:created)
        |> json(%{
          data: task
        })

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{
          error: %{
            message: "Dados inválidos",
            code: "VALIDATION_ERROR",
            details: format_changeset_errors(changeset)
          }
        })
    end
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    clean_params = Map.drop(task_params, ["updated_at"])

    case Tasks.get_task(id) do
      {:ok, task} ->
        case Tasks.update_task(task, clean_params) do
          {:ok, updated_task} ->
            json(conn, %{
              data: updated_task
            })

          {:error, changeset} ->
            render_validation_error(conn, changeset)
        end

      {:error, :not_found} ->
        render_not_found(conn)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Tasks.get_task(id) do
      {:ok, task} ->
        case Tasks.delete_task(task) do
          {:ok, _} ->
            send_resp(conn, :no_content, "")

          {:error, changeset} ->
            render_validation_error(conn, changeset)
        end

      {:error, :not_found} ->
        render_not_found(conn)
    end
  end

  def complete(conn, %{"id" => id}) do
    case Tasks.get_task(id) do
      {:ok, task} ->
        case Tasks.complete_task(task) do
          {:ok, completed_task} ->
            json(conn, %{
              data: completed_task
            })

          {:error, changeset} ->
            render_validation_error(conn, changeset)
        end

      {:error, :not_found} ->
        render_not_found(conn)
    end
  end

  defp format_changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  defp render_validation_error(conn, changeset) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{
      error: %{
        message: "Dados inválidos",
        code: "VALIDATION_ERROR",
        details: format_changeset_errors(changeset)
      }
    })
  end

  defp render_not_found(conn) do
    conn
    |> put_status(:not_found)
    |> json(%{
      error: %{
        message: "Task não encontrada",
        code: "TASK_NOT_FOUND"
      }
    })
  end
end
