defmodule ColecaomodaBack.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ColecaomodaBack.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        completed: true,
        title: "some title"
      })
      |> ColecaomodaBack.Tasks.create_task()

    task
  end
end
