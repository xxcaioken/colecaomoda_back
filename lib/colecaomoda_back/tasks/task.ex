defmodule ColecaomodaBack.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :description, :completed, :inserted_at, :updated_at]}
  schema "tasks" do
    field :title, :string
    field :description, :string
    field :completed, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed])
    |> validate_required([:title])
  end
end
