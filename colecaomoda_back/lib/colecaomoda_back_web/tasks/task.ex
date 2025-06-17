defmodule ColecaomodaBack.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :description, :completed, :inserted_at, :updated_at]}
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

  def delete_changeset(task, _attrs \\ %{}) do
    change(task)
  end

  defp trim_and_validate_title(changeset) do
    case get_change(changeset, :title) do
      nil -> changeset
      title -> put_change(changeset, :title, String.trim(title))
    end
  end
end
