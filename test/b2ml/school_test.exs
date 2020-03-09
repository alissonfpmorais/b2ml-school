defmodule B2ml.SchoolTest do
  use B2ml.DataCase

  alias B2ml.School
  alias B2ml.User

  describe "classes" do
    alias B2ml.School.Class

    @valid_attrs %{
      close_date: "2010-04-17T14:00:00Z",
      code: "some code",
      open_date: "2010-04-17T14:00:00Z",
      room: "some room"
    }
    @update_attrs %{
      close_date: "2011-05-18T15:01:01Z",
      code: "some updated code",
      open_date: "2011-05-18T15:01:01Z",
      room: "some updated room"
    }
    @invalid_attrs %{close_date: nil, code: nil, open_date: nil, room: nil}

    def teacher_fixture() do
      {:ok, teacher} = User.create_teacher(%{
        name: "John Doe",
        title: "Master in Physics"
      })

      teacher
    end

    def class_fixture(attrs \\ %{}) do
      {:ok, class} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_class()

      class
    end

    setup do
      teacher = teacher_fixture()
      {:ok, teacher: teacher}
    end

    test "list_classes/0 returns all classes", %{teacher: teacher} do
      class = class_fixture(%{teacher_id: teacher.id})
      assert School.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id", %{teacher: teacher} do
      class = class_fixture(%{teacher_id: teacher.id})
      assert School.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class", %{teacher: teacher} do
      valid_attrs =
        @valid_attrs
        |> Map.put(:teacher_id, teacher.id)

      assert {:ok, %Class{} = class} = School.create_class(valid_attrs)
      assert class.close_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert class.code == "some code"
      assert class.open_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert class.room == "some room"
    end

    test "create_class/1 with invalid data returns error changeset", %{teacher: teacher} do
      invalid_attrs =
        @invalid_attrs
        |> Map.put(:teacher_id, teacher.id)

      assert {:error, %Ecto.Changeset{}} = School.create_class(invalid_attrs)
    end

    test "update_class/2 with valid data updates the class", %{teacher: teacher} do
      class = class_fixture(%{teacher_id: teacher.id})
      assert {:ok, %Class{} = class} = School.update_class(class, @update_attrs)
      assert class.close_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert class.code == "some updated code"
      assert class.open_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert class.room == "some updated room"
    end

    test "update_class/2 with invalid data returns error changeset", %{teacher: teacher} do
      class = class_fixture(%{teacher_id: teacher.id})
      invalid_attrs =
        @invalid_attrs
        |> Map.put(:teacher_id, teacher.id)

      assert {:error, %Ecto.Changeset{}} = School.update_class(class, invalid_attrs)
      assert class == School.get_class!(class.id)
    end

    test "delete_class/1 deletes the class", %{teacher: teacher} do
      class = class_fixture(%{teacher_id: teacher.id})
      assert {:ok, %Class{}} = School.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> School.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset", %{teacher: teacher} do
      class = class_fixture(%{teacher_id: teacher.id})
      assert %Ecto.Changeset{} = School.change_class(class)
    end
  end
end
