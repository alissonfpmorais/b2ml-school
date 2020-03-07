defmodule B2ml.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :registration, :integer

      timestamps()
    end

    create unique_index(:students, [:registration])
  end
end
