defmodule B2ml.Repo.Migrations.AddClassReferencesToStudent do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :class_id, references(:classes, on_delete: :nothing)
    end
  end
end
