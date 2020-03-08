defmodule B2mlWeb.StudentController do
  use B2mlWeb, :controller
  import B2mlWeb.Gettext

  alias B2ml.School
  alias B2ml.User
  alias B2ml.User.Student

  plug :load_classes when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    students =
      User.list_students()
      |> User.preload_class()
    render(conn, "index.html", students: students)
  end

  def new(conn, _params) do
    changeset = User.change_student(%Student{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"student" => student_params}) do
    case User.create_student(student_params) do
      {:ok, student} ->
        message = gettext("%{resource} created successfuly.", %{resource: gettext("Student")})

        conn
        |> put_flash(:info, message)
        |> redirect(to: Routes.student_path(conn, :show, student))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student =
      id
      |> User.get_student!()
      |> User.preload_class()
    render(conn, "show.html", student: student)
  end

  def edit(conn, %{"id" => id}) do
    student = User.get_student!(id)
    changeset = User.change_student(student)
    render(conn, "edit.html", student: student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = User.get_student!(id)

    case User.update_student(student, student_params) do
      {:ok, student} ->
        message = gettext("%{resource} updated successfully.", %{resource: gettext("Student")})

        conn
        |> put_flash(:info, message)
        |> redirect(to: Routes.student_path(conn, :show, student))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = User.get_student!(id)
    {:ok, _student} = User.delete_student(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: Routes.student_path(conn, :index))
  end

  defp load_classes(conn, _params) do
    assign(conn, :classes, School.list_classes())
  end
end
