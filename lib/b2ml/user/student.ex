defmodule B2ml.User.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :name, :string
    field :registration, :integer

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :registration])
    |> validate_required([:name, :registration])
  end
end
