defmodule Expokefight.Battles.TransformDataTest do
  use ExUnit.Case, async: true
  import Expokefight.Factory
  alias Expokefight.Battles.TransformData
  alias Expokefight.Error

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

  describe "normalize_params/1" do
    test "returns a list of downcased pokemon names" do
      params = %{"pokemon1" => "CHARMANDER", "pokemon2" => " dItTo   "}

      response = TransformData.normalize_params(params)

      expected = {:ok, ["charmander", "ditto"]}

      assert response == expected
    end

    test "returns an error when there are parameters missing" do
      params = %{"pokemon1" => "CHARMANDER"}

      response = TransformData.normalize_params(params)

      expected = {:error, %Error{result: "Invalid parameters", status: :bad_request}}

      assert response == expected
    end

    test "returns an error when there is an invalid parameter" do
      params = %{"pokemon1" => "CHARMANDER", "digimon2" => "agumon"}

      response = TransformData.normalize_params(params)

      expected = {:error, %Error{result: "Invalid parameters", status: :bad_request}}

      assert response == expected
    end
  end
end
