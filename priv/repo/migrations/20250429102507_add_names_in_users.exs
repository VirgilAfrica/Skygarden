defmodule Skygarden.Repo.Migrations.AddNamesInUsers do
  use Ecto.Migration

  def change do
    alter table(:users)do
      add :first_name, :string
      add :second_name, :string
    end
  end
end
