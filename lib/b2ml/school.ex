defmodule B2ml.School do
  @moduledoc """
  The School context.
  """

  import Ecto.Query, warn: false
  alias B2ml.Repo

  alias B2ml.School.Class
  alias B2ml.User.{
    Student,
    Teacher
  }

  @doc """
  Returns the list of classes.

  ## Examples

      iex> list_classes()
      [%Class{}, ...]

  """
  def list_classes do
    Repo.all(Class)
  end

  @doc """
  Returns the list of classes filtered by a given teacher.

  ## Examples

      iex> list_classes_by_teacher(teacher)
      [%Class{}, ...]
  """
  def list_classes_by_teacher(teacher) do
    Class
    |> where([c], c.teacher_id == ^teacher.id)
    |> select([c], c)
    |> Repo.all
  end

  @doc """
  Gets a single class.

  Raises `Ecto.NoResultsError` if the Class does not exist.

  ## Examples

      iex> get_class!(123)
      %Class{}

      iex> get_class!(456)
      ** (Ecto.NoResultsError)

  """
  def get_class!(id), do: Repo.get!(Class, id)

  @doc """
  Preload a teacher from a given Class (or list of Classes).

  ## Examples

      iex> preload_teacher(class)
      %Class{}

      iex> preload_teacher(classes)
      [%Class{}, ...]
  """
  def preload_teacher(teachers) do
    teachers
    |> Repo.preload(:teacher)
  end

  @doc """
  Creates a class with a teacher associated teacher.

  ## Examples

      iex> create_class(%{field: value})
      {:ok, %Class{}}

      iex> create_class(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_class(attrs \\ %{}) do
    %Class{}
    |> Class.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a class.

  ## Examples

      iex> update_class(class, %{field: new_value})
      {:ok, %Class{}}

      iex> update_class(class, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_class(%Class{} = class, attrs) do
    class
    |> Class.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a class.

  ## Examples

      iex> delete_class(class)
      {:ok, %Class{}}

      iex> delete_class(class)
      {:error, %Ecto.Changeset{}}

  """
  def delete_class(%Class{} = class) do
    Repo.delete(class)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking class changes.

  ## Examples

      iex> change_class(class)
      %Ecto.Changeset{source: %Class{}}

  """
  def change_class(%Class{} = class) do
    Class.changeset(class, %{})
  end
end
