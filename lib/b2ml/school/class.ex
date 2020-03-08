defmodule B2ml.School.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :close_date, :utc_datetime
    field :code, :string
    field :open_date, :utc_datetime
    field :room, :string
    belongs_to :teacher, B2ml.User.Teacher

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:code, :room, :open_date, :close_date, :teacher_id])
    |> validate_required([:code, :room, :open_date, :close_date, :teacher_id])
    |> assoc_constraint(:teacher)
  end
end
