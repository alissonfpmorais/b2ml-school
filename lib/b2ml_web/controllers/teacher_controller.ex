defmodule B2mlWeb.TeacherController do
  use B2mlWeb, :controller
  import B2mlWeb.Gettext

  alias B2ml.School
  alias B2ml.User
  alias B2ml.User.Teacher

  def index(conn, _params) do
    teachers = User.list_teachers()
    render(conn, "index.html", teachers: teachers)
  end

  def new(conn, _params) do
    changeset = User.change_teacher(%Teacher{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"teacher" => teacher_params}) do
    case User.create_teacher(teacher_params) do
      {:ok, teacher} ->
        message = gettext("%{resource} created successfuly.", %{resource: gettext("Teacher")})

        conn
        |> put_flash(:info, message)
        |> redirect(to: Routes.teacher_path(conn, :show, teacher))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    teacher = User.get_teacher!(id)
    classes = School.list_classes_by_teacher(teacher)
    render(conn, "show.html", teacher: teacher, classes: classes)
  end

  def edit(conn, %{"id" => id}) do
    teacher = User.get_teacher!(id)
    changeset = User.change_teacher(teacher)
    render(conn, "edit.html", teacher: teacher, changeset: changeset)
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = User.get_teacher!(id)

    case User.update_teacher(teacher, teacher_params) do
      {:ok, teacher} ->
        message = gettext("%{resource} updated successfully.", %{resource: gettext("Teacher")})

        conn
        |> put_flash(:info, message)
        |> redirect(to: Routes.teacher_path(conn, :show, teacher))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", teacher: teacher, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = User.get_teacher!(id)
    {:ok, _teacher} = User.delete_teacher(teacher)

    conn
    |> put_flash(:info, "Teacher deleted successfully.")
    |> redirect(to: Routes.teacher_path(conn, :index))
  end
end
