defmodule B2ml.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :name, :string
      add :title, :string

      timestamps()
    end

  end
end
