defmodule ColecaomodaBack.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :description, :string
    field :completed, :boolean, default: false

    timestamps()
    end

  def create_changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description])
    |> validate_required([:title])
    |> validate_length(:title, min: 3, max: 255)
    |> put_change(:completed, false)
    |> trim_and_validate_title()
  end

  def update_changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed])
    |> validate_required([:title])
    |> validate_length(:title, min: 3, max: 255)
    |> validate_inclusion(:completed, [true, false])
    |> trim_and_validate_title()
  end

  def toggle_changeset(task) do
    change(task, completed: !task.completed)
  end

  def delete_changeset(task, attrs \\ %{}) do
    task
    |> cast(attrs, [])
    |> validate_can_be_deleted()
    |> validate_no_dependencies()
  end

  defp validate_can_be_deleted(changeset) do
    task = apply_changes(changeset)

    cond do
      task.completed == false ->
        add_error(changeset, :base, "não pode deletar task pendente")

      has_dependencies?(task) ->
        add_error(changeset, :base, "task tem dependências")

      true ->
        changeset
    end
  end

  defp trim_and_validate_title(changeset) do
    case get_change(changeset, :title) do
      nil -> changeset
      title -> put_change(changeset, :title, String.trim(title))
    end
  end
end
