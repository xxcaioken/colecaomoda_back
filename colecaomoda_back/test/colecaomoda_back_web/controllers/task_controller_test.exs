defmodule ColecaomodaBackWeb.TaskControllerTest do
  use ColecaomodaBackWeb.ConnCase

  alias ColecaomodaBack.Tasks

  @create_attrs %{
    title: "Nova Task",
    description: "Descrição da task"
  }

  @update_attrs %{
    title: "Task Atualizada",
    description: "Descrição atualizada",
    completed: true
  }

  @invalid_attrs %{title: ""}

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      task1 = task_fixture(%{title: "Task 1"})
      task2 = task_fixture(%{title: "Task 2"})

      conn = get(conn, ~p"/api/tasks")

      assert json_response(conn, 200) == %{
        "data" => [
          %{
            "id" => task1.id,
            "title" => task1.title,
            "description" => task1.description,
            "completed" => task1.completed,
            "inserted_at" => NaiveDateTime.to_iso8601(task1.inserted_at),
            "updated_at" => NaiveDateTime.to_iso8601(task1.updated_at)
          },
          %{
            "id" => task2.id,
            "title" => task2.title,
            "description" => task2.description,
            "completed" => task2.completed,
            "inserted_at" => NaiveDateTime.to_iso8601(task2.inserted_at),
            "updated_at" => NaiveDateTime.to_iso8601(task2.updated_at)
          }
        ]
      }
    end

    test "returns empty list when no tasks exist", %{conn: conn} do
      conn = get(conn, ~p"/api/tasks")

      assert json_response(conn, 200) == %{"data" => []}
    end
  end

  describe "create task" do
    test "renders task when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/tasks", task: @create_attrs)

      assert %{"data" => task_data} = json_response(conn, 201)
      assert task_data["title"] == "Nova Task"
      assert task_data["description"] == "Descrição da task"
      assert task_data["completed"] == false
      assert task_data["id"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/tasks", task: @invalid_attrs)

      assert json_response(conn, 422) == %{
        "error" => %{
          "message" => "Dados inválidos",
          "code" => "VALIDATION_ERROR",
          "details" => %{
            "title" => ["can't be blank"]
          }
        }
      }
    end

    test "creates task with only title", %{conn: conn} do
      attrs = %{title: "Task Simples"}
      conn = post(conn, ~p"/api/tasks", task: attrs)

      assert %{"data" => task_data} = json_response(conn, 201)
      assert task_data["title"] == "Task Simples"
      assert task_data["description"] == nil
      assert task_data["completed"] == false
    end
  end

  describe "show" do
    test "renders task when id exists", %{conn: conn} do
      task = task_fixture()
      conn = get(conn, ~p"/api/tasks/#{task.id}")

      assert %{"data" => task_data} = json_response(conn, 200)
      assert task_data["id"] == task.id
      assert task_data["title"] == task.title
      assert task_data["description"] == task.description
      assert task_data["completed"] == task.completed
    end

    test "renders error when task not found", %{conn: conn} do
      conn = get(conn, ~p"/api/tasks/999")

      assert json_response(conn, 404) == %{
        "error" => %{
          "message" => "Task não encontrada",
          "code" => "TASK_NOT_FOUND"
        }
      }
    end
  end

  describe "update task" do
    test "renders task when data is valid", %{conn: conn} do
      task = task_fixture()
      conn = put(conn, ~p"/api/tasks/#{task.id}", task: @update_attrs)

      assert %{"data" => task_data} = json_response(conn, 200)
      assert task_data["id"] == task.id
      assert task_data["title"] == "Task Atualizada"
      assert task_data["description"] == "Descrição atualizada"
      assert task_data["completed"] == true
    end

    test "renders errors when data is invalid", %{conn: conn} do
      task = task_fixture()
      conn = put(conn, ~p"/api/tasks/#{task.id}", task: @invalid_attrs)

      assert json_response(conn, 422) == %{
        "error" => %{
          "message" => "Dados inválidos",
          "code" => "VALIDATION_ERROR",
          "details" => %{
            "title" => ["can't be blank"]
          }
        }
      }
    end

    test "renders error when task not found", %{conn: conn} do
      conn = put(conn, ~p"/api/tasks/999", task: @update_attrs)

      assert json_response(conn, 404) == %{
        "error" => %{
          "message" => "Task não encontrada",
          "code" => "TASK_NOT_FOUND"
        }
      }
    end
  end

  describe "delete task" do
    test "deletes chosen task", %{conn: conn} do
      task = task_fixture()
      conn = delete(conn, ~p"/api/tasks/#{task.id}")

      assert response(conn, 204) == ""

      # Verifica se a task foi realmente deletada
      conn = get(build_conn(), ~p"/api/tasks/#{task.id}")
      assert json_response(conn, 404)
    end

    test "renders error when task not found", %{conn: conn} do
      conn = delete(conn, ~p"/api/tasks/999")

      assert json_response(conn, 404) == %{
        "error" => %{
          "message" => "Task não encontrada",
          "code" => "TASK_NOT_FOUND"
        }
      }
    end
  end

  describe "complete task" do
    test "toggles task completion from false to true", %{conn: conn} do
      task = task_fixture(%{completed: false})
      conn = put(conn, ~p"/api/tasks/#{task.id}/complete")

      assert %{"data" => task_data} = json_response(conn, 200)
      assert task_data["id"] == task.id
      assert task_data["completed"] == true
    end

    test "toggles task completion from true to false", %{conn: conn} do
      task = task_fixture(%{completed: true})
      conn = put(conn, ~p"/api/tasks/#{task.id}/complete")

      assert %{"data" => task_data} = json_response(conn, 200)
      assert task_data["id"] == task.id
      assert task_data["completed"] == false
    end

    test "renders error when task not found", %{conn: conn} do
      conn = put(conn, ~p"/api/tasks/999/complete")

      assert json_response(conn, 404) == %{
        "error" => %{
          "message" => "Task não encontrada",
          "code" => "TASK_NOT_FOUND"
        }
      }
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
