defmodule B2ml.User.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :name, :string
    field :registration, :integer
    belongs_to :class, B2ml.School.Class

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :registration, :class_id])
    |> validate_required([:name, :registration, :class_id])
    |> assoc_constraint(:class)
  end
end
