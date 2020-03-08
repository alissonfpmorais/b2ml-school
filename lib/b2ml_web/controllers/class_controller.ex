defmodule B2mlWeb.ClassController do
  use B2mlWeb, :controller
  import B2mlWeb.Gettext

  alias B2ml.School
  alias B2ml.School.Class
  alias B2ml.User

  plug :load_teachers when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    classes =
      School.list_classes()
      |> School.preload_teacher()
    render(conn, "index.html", classes: classes)
  end

  def new(conn, _params) do
    changeset = School.change_class(%Class{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"class" => class_params}) do
    case School.create_class(class_params) do
      {:ok, class} ->
        message = gettext("%{resource} created successfuly.", %{resource: gettext("Class")})

        conn
        |> put_flash(:info, message)
        |> redirect(to: Routes.class_path(conn, :show, class))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    class =
      id
      |> School.get_class!()
      |> School.preload_teacher()
    students = User.list_students_by_class(class)
    # students = [%{name: "alisson"}]

    render(conn, "show.html", class: class, students: students)
  end

  def edit(conn, %{"id" => id}) do
    class = School.get_class!(id)
    changeset = School.change_class(class)
    render(conn, "edit.html", class: class, changeset: changeset)
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = School.get_class!(id)

    case School.update_class(class, class_params) do
      {:ok, class} ->
        message = gettext("%{resource} updated successfully.", %{resource: gettext("Class")})

        conn
        |> put_flash(:info, message)
        |> redirect(to: Routes.class_path(conn, :show, class))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", class: class, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    class = School.get_class!(id)
    {:ok, _class} = School.delete_class(class)

    conn
    |> put_flash(:info, "Class deleted successfully.")
    |> redirect(to: Routes.class_path(conn, :index))
  end

  defp load_teachers(conn, _params) do
    assign(conn, :teachers, User.list_teachers())
  end
end
