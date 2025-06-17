defmodule ColecaomodaBack.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string, null: false, size: 255
      add :description, :text
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

    create index(:todos, [:completed])
  end
end
