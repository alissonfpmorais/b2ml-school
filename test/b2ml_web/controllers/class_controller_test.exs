defmodule B2mlWeb.ClassControllerTest do
  use B2mlWeb.ConnCase
  import B2mlWeb.Gettext

  alias B2ml.School
  alias B2ml.User

  @create_attrs %{
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

  def fixture(:class, teacher_id) do
    create_attrs =
      @create_attrs
      |> Map.put(:teacher_id, teacher_id)

    {:ok, class} = School.create_class(create_attrs)
    class
  end

  def fixture(:teacher) do
    {:ok, teacher} = User.create_teacher(%{
      name: "John Doe",
      title: "Master in Physics"
    })
    teacher
  end

  describe "index" do
    test "lists all classes", %{conn: conn} do
      conn = get(conn, Routes.class_path(conn, :index))
      assert html_response(conn, 200) =~ gettext("List all classes")
    end
  end

  describe "new class" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.class_path(conn, :new))
      assert html_response(conn, 200) =~ gettext("Create new class")
    end
  end

  describe "create class" do
    setup [:create_teacher]

    test "redirects to show when data is valid", %{conn: conn, teacher: teacher} do
      create_attrs =
        @create_attrs
        |> Map.put(:teacher_id, teacher.id)

      conn = post(conn, Routes.class_path(conn, :create), class: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.class_path(conn, :show, id)

      conn = get(conn, Routes.class_path(conn, :show, id))
      assert html_response(conn, 200) =~ gettext("Class")
    end

    test "renders errors when data is invalid", %{conn: conn, teacher: teacher} do
      invalid_attrs =
        @invalid_attrs
        |> Map.put(:teacher_id, teacher.id)

      conn = post(conn, Routes.class_path(conn, :create), class: invalid_attrs)
      assert html_response(conn, 200) =~ gettext("Create new class")
    end
  end

  describe "edit class" do
    setup [:create_initial_setup]

    test "renders form for editing chosen class", %{conn: conn, class: class} do
      conn = get(conn, Routes.class_path(conn, :edit, class))
      assert html_response(conn, 200) =~ gettext("Edit Class")
    end
  end

  describe "update class" do
    setup [:create_initial_setup]

    test "redirects when data is valid", %{conn: conn, class: class} do
      conn = put(conn, Routes.class_path(conn, :update, class), class: @update_attrs)
      assert redirected_to(conn) == Routes.class_path(conn, :show, class)

      conn = get(conn, Routes.class_path(conn, :show, class))
      assert html_response(conn, 200) =~ "some updated code"
    end

    test "renders errors when data is invalid", %{conn: conn, class: class} do
      conn = put(conn, Routes.class_path(conn, :update, class), class: @invalid_attrs)
      assert html_response(conn, 200) =~ gettext("Edit Class")
    end
  end

  describe "delete class" do
    setup [:create_initial_setup]

    test "deletes chosen class", %{conn: conn, class: class} do
      conn = delete(conn, Routes.class_path(conn, :delete, class))
      assert redirected_to(conn) == Routes.class_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.class_path(conn, :show, class))
      end
    end
  end

  defp create_initial_setup(_) do
    teacher = fixture(:teacher)
    create_class(teacher.id)
  end

  defp create_teacher(_) do
    teacher = fixture(:teacher)
    {:ok, teacher: teacher}
  end

  defp create_class(teacher_id) do
    class = fixture(:class, teacher_id)
    {:ok, class: class}
  end
end
