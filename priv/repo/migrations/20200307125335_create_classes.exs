defmodule B2ml.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :code, :string
      add :room, :string
      add :open_date, :utc_datetime
      add :close_date, :utc_datetime
      add :teacher_id, references(:teachers, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:classes, [:code])
  end
end
