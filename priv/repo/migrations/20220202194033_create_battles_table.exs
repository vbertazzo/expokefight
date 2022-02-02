defmodule Expokefight.Repo.Migrations.CreateBattlesTable do
  use Ecto.Migration

  def change do
    create table(:battles) do
      add :victorious_id, references(:pokemons, type: :binary_id)
      add :defeated_id, references(:pokemons, type: :binary_id)

      timestamps()
    end
  end
end
