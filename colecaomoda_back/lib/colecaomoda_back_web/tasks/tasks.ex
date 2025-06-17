defmodule ColecaomodaBack.Tasks do
  alias ColecaomodaBack.Repo
  alias ColecaomodaBack.Tasks.Task

  def list_tasks do
    Repo.all(Task)
  end

  def get_task(id) do
    case Repo.get(Task, id) do
      nil -> {:error, :not_found}
      task -> {:ok, task}
    end
  end

  def create_task(attrs) do
    %Task{}
    |> Task.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_task(task, attrs) do
    task
    |> Task.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_task(task) do
    task
    |> Task.delete_changeset()
    |> Repo.delete()
  end

  def toggle_task(task) do
    task
    |> Task.toggle_changeset()
    |> Repo.update()
  end

  def complete_task(task) do
    task
    |> Task.toggle_changeset()
    |> Repo.update()
  end
end
