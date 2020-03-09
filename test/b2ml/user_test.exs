defmodule B2ml.UserTest do
  use B2ml.DataCase

  alias B2ml.School
  alias B2ml.User

  describe "teachers" do
    alias B2ml.User.Teacher

    @valid_attrs %{name: "some name", title: "some title"}
    @update_attrs %{name: "some updated name", title: "some updated title"}
    @invalid_attrs %{name: nil, title: nil}

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> User.create_teacher()

      teacher
    end

    test "list_teachers/0 returns all teachers" do
      teacher = teacher_fixture()
      assert User.list_teachers() == [teacher]
    end

    test "get_teacher!/1 returns the teacher with given id" do
      teacher = teacher_fixture()
      assert User.get_teacher!(teacher.id) == teacher
    end

    test "create_teacher/1 with valid data creates a teacher" do
      assert {:ok, %Teacher{} = teacher} = User.create_teacher(@valid_attrs)
      assert teacher.name == "some name"
      assert teacher.title == "some title"
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_teacher(@invalid_attrs)
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{} = teacher} = User.update_teacher(teacher, @update_attrs)
      assert teacher.name == "some updated name"
      assert teacher.title == "some updated title"
    end

    test "update_teacher/2 with invalid data returns error changeset" do
      teacher = teacher_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_teacher(teacher, @invalid_attrs)
      assert teacher == User.get_teacher!(teacher.id)
    end

    test "delete_teacher/1 deletes the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{}} = User.delete_teacher(teacher)
      assert_raise Ecto.NoResultsError, fn -> User.get_teacher!(teacher.id) end
    end

    test "change_teacher/1 returns a teacher changeset" do
      teacher = teacher_fixture()
      assert %Ecto.Changeset{} = User.change_teacher(teacher)
    end
  end

  describe "students" do
    alias B2ml.User.Student

    @valid_attrs %{name: "some name", registration: 42}
    @update_attrs %{name: "some updated name", registration: 43}
    @invalid_attrs %{name: nil, registration: nil}

    def class_fixture(teacher_id) do
      {:ok, class} = School.create_class(%{
        close_date: "2010-04-17T14:00:00Z",
        code: "some code",
        open_date: "2010-04-17T14:00:00Z",
        room: "some room",
        teacher_id: teacher_id
      })

      class
    end

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> User.create_student()

      student
    end

    setup do
      teacher = teacher_fixture()
      class = class_fixture(teacher.id)
      {:ok, class: class}
    end

    test "list_students/0 returns all students", %{class: class} do
      student = student_fixture(%{class_id: class.id})
      assert User.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id", %{class: class} do
      student = student_fixture(%{class_id: class.id})
      assert User.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student", %{class: class} do
      valid_attrs =
        @valid_attrs
        |> Map.put(:class_id, class.id)

      assert {:ok, %Student{} = student} = User.create_student(valid_attrs)
      assert student.name == "some name"
      assert student.registration == 42
    end

    test "create_student/1 with invalid data returns error changeset", %{class: class} do
      invalid_attrs =
        @invalid_attrs
        |> Map.put(:class_id, class.id)

      assert {:error, %Ecto.Changeset{}} = User.create_student(invalid_attrs)
    end

    test "update_student/2 with valid data updates the student", %{class: class} do
      student = student_fixture(%{class_id: class.id})
      assert {:ok, %Student{} = student} = User.update_student(student, @update_attrs)
      assert student.name == "some updated name"
      assert student.registration == 43
    end

    test "update_student/2 with invalid data returns error changeset", %{class: class} do
      student = student_fixture(%{class_id: class.id})
      invalid_attrs =
        @invalid_attrs
        |> Map.put(:class_id, class.id)

      assert {:error, %Ecto.Changeset{}} = User.update_student(student, invalid_attrs)
      assert student == User.get_student!(student.id)
    end

    test "delete_student/1 deletes the student", %{class: class} do
      student = student_fixture(%{class_id: class.id})
      assert {:ok, %Student{}} = User.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> User.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset", %{class: class} do
      student = student_fixture(%{class_id: class.id})
      assert %Ecto.Changeset{} = User.change_student(student)
    end
  end
end
