defmodule ColecaomodaBack.TasksTest do
  use ColecaomodaBack.DataCase

  alias ColecaomodaBack.Tasks

  describe "list_tasks/0" do
    test "returns all tasks" do
      task1 = task_fixture(%{title: "Task 1"})
      task2 = task_fixture(%{title: "Task 2"})

      tasks = Tasks.list_tasks()

      assert length(tasks) == 2
      assert Enum.any?(tasks, &(&1.id == task1.id))
      assert Enum.any?(tasks, &(&1.id == task2.id))
    end

    test "returns empty list when no tasks exist" do
      assert Tasks.list_tasks() == []
    end
  end

  describe "get_task/1" do
    test "returns task when id exists" do
      task = task_fixture()

      assert {:ok, found_task} = Tasks.get_task(task.id)
      assert found_task.id == task.id
      assert found_task.title == task.title
    end

    test "returns error when id does not exist" do
      assert {:error, :not_found} = Tasks.get_task(999)
    end
  end

  describe "create_task/1" do
    test "creates task with valid attributes" do
      attrs = %{
        title: "Nova Task",
        description: "Descrição da task"
      }

      assert {:ok, task} = Tasks.create_task(attrs)
      assert task.title == "Nova Task"
      assert task.description == "Descrição da task"
      assert task.completed == false
      assert task.id
    end

    test "creates task with only title" do
      attrs = %{title: "Task Simples"}

      assert {:ok, task} = Tasks.create_task(attrs)
      assert task.title == "Task Simples"
      assert task.description == nil
      assert task.completed == false
    end

    test "returns error with invalid attributes" do
      attrs = %{title: ""}

      assert {:error, changeset} = Tasks.create_task(attrs)
      assert %{title: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when title is too short" do
      attrs = %{title: "ab"}

      assert {:error, changeset} = Tasks.create_task(attrs)
      assert %{title: ["should be at least 3 character(s)"]} = errors_on(changeset)
    end

    test "returns error when title is too long" do
      long_title = String.duplicate("a", 256)
      attrs = %{title: long_title}

      assert {:error, changeset} = Tasks.create_task(attrs)
      assert %{title: ["should be at most 255 character(s)"]} = errors_on(changeset)
    end
  end

  describe "update_task/2" do
    test "updates task with valid attributes" do
      task = task_fixture()
      attrs = %{
        title: "Título Atualizado",
        description: "Nova descrição"
      }

      assert {:ok, updated_task} = Tasks.update_task(task, attrs)
      assert updated_task.title == "Título Atualizado"
      assert updated_task.description == "Nova descrição"
      assert updated_task.id == task.id
    end

    test "updates task completion status" do
      task = task_fixture(%{completed: false})
      attrs = %{completed: true}

      assert {:ok, updated_task} = Tasks.update_task(task, attrs)
      assert updated_task.completed == true
      assert updated_task.id == task.id
    end

    test "returns error with invalid attributes" do
      task = task_fixture()
      attrs = %{title: ""}

      assert {:error, changeset} = Tasks.update_task(task, attrs)
      assert %{title: ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "delete_task/1" do
    test "deletes the task" do
      task = task_fixture()

      assert {:ok, deleted_task} = Tasks.delete_task(task)
      assert deleted_task.id == task.id
      assert {:error, :not_found} = Tasks.get_task(task.id)
    end
  end

  describe "complete_task/1" do
    test "toggles task from incomplete to complete" do
      task = task_fixture(%{completed: false})

      assert {:ok, updated_task} = Tasks.complete_task(task)
      assert updated_task.completed == true
      assert updated_task.id == task.id
    end

    test "toggles task from complete to incomplete" do
      task = task_fixture(%{completed: true})

      assert {:ok, updated_task} = Tasks.complete_task(task)
      assert updated_task.completed == false
      assert updated_task.id == task.id
    end
  end

  # Helper function para criar tasks nos testes
  defp task_fixture(attrs \\ %{}) do
    default_attrs = %{
      title: "Task de Teste",
      description: "Descrição de teste",
      completed: false
    }

    attrs = Enum.into(attrs, default_attrs)

    {:ok, task} = Tasks.create_task(attrs)

    # Se precisamos de uma task completed=true, atualizamos depois da criação
    if attrs[:completed] == true do
      {:ok, updated_task} = Tasks.update_task(task, %{completed: true})
      updated_task
    else
      task
    end
  end
end
