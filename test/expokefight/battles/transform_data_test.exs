defmodule Expokefight.Battles.TransformDataTest do
  use ExUnit.Case, async: true
  import Expokefight.Factory

  alias Expokefight.Battles.TransformData

  describe "call/1" do
    test "returns a list of two pokemons" do
      pokemon1 = build(:pokeapi_response)
      pokemon2 = build(:pokeapi_response, %{name: "ditto"})

      response = TransformData.call([pokemon1, pokemon2])

      expected = [
        %{
          image:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
          name: "bulbasaur",
          type: "grass/poison"
        },
        %{
          image:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
          name: "ditto",
          type: "grass/poison"
        }
      ]

      assert response == expected
    end
  end
end
