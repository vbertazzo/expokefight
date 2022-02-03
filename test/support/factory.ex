defmodule Expokefight.Factory do
  use ExMachina.Ecto, repo: Expokefight.Repo
  alias Expokefight.Pokemon

  def pokemon_params_factory do
    %{
      "name" => "Squirtle",
      "image" =>
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
      "type" => "water"
    }
  end

  def pokemon_factory do
    %Pokemon{
      name: "Squirtle",
      image:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
      type: "water"
    }
  end
end
