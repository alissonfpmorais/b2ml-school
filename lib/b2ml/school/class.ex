defmodule B2ml.School.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :close_date, :utc_datetime
    field :code, :string
    field :open_date, :utc_datetime
    field :room, :string
    field :teacher, :id

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:code, :room, :open_date, :close_date])
    |> validate_required([:code, :room, :open_date, :close_date])
  end
end
