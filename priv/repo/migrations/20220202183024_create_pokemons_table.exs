defmodule Expokefight.Repo.Migrations.CreatePokemonsTable do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :name, :string, null: false
      add :image, :string, null: false
      add :type, :string, null: false
    end
  end
end
