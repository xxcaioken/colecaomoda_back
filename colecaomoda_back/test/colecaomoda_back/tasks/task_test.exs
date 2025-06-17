defmodule ColecaomodaBack.Tasks.TaskTest do
  use ColecaomodaBack.DataCase

  alias ColecaomodaBack.Tasks.Task

  @valid_attrs %{title: "Task Válida", description: "Descrição válida"}
  @invalid_attrs %{title: "", description: nil}

  describe "create_changeset/2" do
    test "changeset with valid attributes" do
      changeset = Task.create_changeset(%Task{}, @valid_attrs)

      assert changeset.valid?
      assert get_change(changeset, :title) == "Task Válida"
      assert get_change(changeset, :description) == "Descrição válida"
      # completed tem valor padrão false quando não especificado
      assert get_field(changeset, :completed) == false
    end

    test "changeset with invalid attributes" do
      changeset = Task.create_changeset(%Task{}, @invalid_attrs)

      refute changeset.valid?
      assert %{title: ["can't be blank"]} = errors_on(changeset)
    end

    test "title is required" do
      attrs = Map.put(@valid_attrs, :title, nil)
      changeset = Task.create_changeset(%Task{}, attrs)

      refute changeset.valid?
      assert %{title: ["can't be blank"]} = errors_on(changeset)
    end

    test "title must be at least 3 characters" do
      attrs = Map.put(@valid_attrs, :title, "ab")
      changeset = Task.create_changeset(%Task{}, attrs)

      refute changeset.valid?
      assert %{title: ["should be at least 3 character(s)"]} = errors_on(changeset)
    end

    test "title must be at most 255 characters" do
      long_title = String.duplicate("a", 256)
      attrs = Map.put(@valid_attrs, :title, long_title)
      changeset = Task.create_changeset(%Task{}, attrs)

      refute changeset.valid?
      assert %{title: ["should be at most 255 character(s)"]} = errors_on(changeset)
    end

    test "trims whitespace from title" do
      attrs = Map.put(@valid_attrs, :title, "  Task com espaços  ")
      changeset = Task.create_changeset(%Task{}, attrs)

      assert changeset.valid?
      assert get_change(changeset, :title) == "Task com espaços"
    end

    test "always sets completed to false" do
      attrs = Map.put(@valid_attrs, :completed, true)
      changeset = Task.create_changeset(%Task{}, attrs)

      assert get_field(changeset, :completed) == false
    end

    test "description is optional" do
      attrs = Map.delete(@valid_attrs, :description)
      changeset = Task.create_changeset(%Task{}, attrs)

      assert changeset.valid?
    end
  end

  describe "update_changeset/2" do
    test "changeset with valid attributes" do
      task = %Task{title: "Old Title", completed: false}
      attrs = %{title: "New Title", completed: true}
      changeset = Task.update_changeset(task, attrs)

      assert changeset.valid?
      assert get_change(changeset, :title) == "New Title"
      assert get_change(changeset, :completed) == true
    end

    test "allows updating completed status" do
      task = %Task{title: "Valid Title", completed: false}  # Fornece título válido
      attrs = %{completed: true}
      changeset = Task.update_changeset(task, attrs)

      assert changeset.valid?
      assert get_change(changeset, :completed) == true
    end

    test "validates completed must be boolean" do
      task = %Task{title: "Valid Title"}  # Fornece título válido
      attrs = %{completed: "invalid"}
      changeset = Task.update_changeset(task, attrs)

      refute changeset.valid?
      assert %{completed: ["is invalid"]} = errors_on(changeset)
    end

    test "title validations still apply" do
      task = %Task{}
      attrs = %{title: "ab"}
      changeset = Task.update_changeset(task, attrs)

      refute changeset.valid?
      assert %{title: ["should be at least 3 character(s)"]} = errors_on(changeset)
    end
  end

  describe "toggle_changeset/1" do
    test "toggles completed from false to true" do
      task = %Task{completed: false}
      changeset = Task.toggle_changeset(task)

      assert changeset.valid?
      assert get_change(changeset, :completed) == true
    end

    test "toggles completed from true to false" do
      task = %Task{completed: true}
      changeset = Task.toggle_changeset(task)

      assert changeset.valid?
      assert get_change(changeset, :completed) == false
    end
  end

  describe "delete_changeset/2" do
    test "creates valid changeset for deletion" do
      task = %Task{id: 1, title: "Task to delete"}
      changeset = Task.delete_changeset(task)

      assert changeset.valid?
    end
  end
end
