defmodule B2mlWeb.StudentControllerTest do
  use B2mlWeb.ConnCase
  import B2mlWeb.Gettext

  alias B2ml.School
  alias B2ml.User

  @create_attrs %{name: "some name", registration: 42}
  @update_attrs %{name: "some updated name", registration: 43}
  @invalid_attrs %{name: nil, registration: nil}

  def fixture(:teacher) do
    {:ok, teacher} = User.create_teacher(%{
      name: "John Doe",
      title: "Master in Physics"
    })
    teacher
  end

  def fixture(:class, teacher_id) do
    {:ok, class} = School.create_class(%{
      close_date: "2010-04-17T14:00:00Z",
      code: "some code",
      open_date: "2010-04-17T14:00:00Z",
      room: "some room",
      teacher_id: teacher_id
    })
    class
  end

  def fixture(:student, class_id) do
    create_attrs =
      @create_attrs
      |> Map.put(:class_id, class_id)

    {:ok, student} = User.create_student(create_attrs)
    student
  end

  describe "index" do
    test "lists all students", %{conn: conn} do
      conn = get(conn, Routes.student_path(conn, :index))
      assert html_response(conn, 200) =~ gettext("List all students")
    end
  end

  describe "new student" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.student_path(conn, :new))
      assert html_response(conn, 200) =~ gettext("Register a student")
    end
  end

  describe "create student" do
    setup [:create_initial_setup]

    test "redirects to show when data is valid", %{conn: conn, class: class} do
      create_attrs =
        @create_attrs
        |> Map.put(:registration, 44)
        |> Map.put(:class_id, class.id)

      conn = post(conn, Routes.student_path(conn, :create), student: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.student_path(conn, :show, id)

      conn = get(conn, Routes.student_path(conn, :show, id))
      assert html_response(conn, 200) =~ gettext("Student")
    end

    test "renders errors when data is invalid", %{conn: conn, class: class} do
      invalid_attrs =
        @invalid_attrs
        |> Map.put(:class_id, class.id)

      conn = post(conn, Routes.student_path(conn, :create), student: invalid_attrs)
      assert html_response(conn, 200) =~ gettext("Register a student")
    end
  end

  describe "edit student" do
    setup [:create_initial_setup]

    test "renders form for editing chosen student", %{conn: conn, student: student} do
      conn = get(conn, Routes.student_path(conn, :edit, student))
      assert html_response(conn, 200) =~ gettext("Edit Student")
    end
  end

  describe "update student" do
    setup [:create_initial_setup]

    test "redirects when data is valid", %{conn: conn, student: student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @update_attrs)
      assert redirected_to(conn) == Routes.student_path(conn, :show, student)

      conn = get(conn, Routes.student_path(conn, :show, student))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, class: class, student: student} do
      invalid_attrs =
        @invalid_attrs
        |> Map.put(:class_id, class.id)

      conn = put(conn, Routes.student_path(conn, :update, student), student: invalid_attrs)
      assert html_response(conn, 200) =~ gettext("Edit Student")
    end
  end

  describe "delete student" do
    setup [:create_initial_setup]

    test "deletes chosen student", %{conn: conn, student: student} do
      conn = delete(conn, Routes.student_path(conn, :delete, student))
      assert redirected_to(conn) == Routes.student_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.student_path(conn, :show, student))
      end
    end
  end

  defp create_initial_setup(_) do
    teacher = fixture(:teacher)
    {:ok, class: class} = create_class(teacher.id)
    {:ok, student: student} = create_student(class.id)
    {:ok, teacher: teacher, class: class, student: student}
  end

  defp create_class(teacher_id) do
    class = fixture(:class, teacher_id)
    {:ok, class: class}
  end

  defp create_student(class_id) do
    student = fixture(:student, class_id)
    {:ok, student: student}
  end
end
