defmodule Expokefight.Battles.GetTest do
  use Expokefight.DataCase, async: true
  import Expokefight.Factory
  alias Expokefight.{Battle, Pokemon}
  alias Expokefight.Battles.Get

  describe "all/0" do
    setup do
      insert(:battle)
      insert(:battle)

      :ok
    end

    test "returns all battles" do
      response = Get.all()

      assert {:ok,
              [
                %Battle{
                  defeated: %Pokemon{
                    id: _pokemon_id1,
                    image:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                    name: "pikachu",
                    type: "electric"
                  },
                  defeated_id: _pokemon_id2,
                  id: _battle_id1,
                  inserted_at: ~N[2022-02-04 20:08:02],
                  updated_at: ~N[2022-02-04 20:08:02],
                  victorious: %Pokemon{
                    id: _pokemon_id3,
                    image:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                    name: "charmander",
                    type: "fire"
                  },
                  victorious_id: _pokemon_id4
                },
                %Battle{
                  defeated: %Pokemon{
                    id: _pokemon_id5,
                    image:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                    name: "pikachu",
                    type: "electric"
                  },
                  defeated_id: _pokemon_id6,
                  id: _battle_id2,
                  inserted_at: ~N[2022-02-04 20:08:02],
                  updated_at: ~N[2022-02-04 20:08:02],
                  victorious: %Pokemon{
                    id: _pokemon_id7,
                    image:
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                    name: "charmander",
                    type: "fire"
                  },
                  victorious_id: _pokemon_id8
                }
              ]} = response
    end
  end

  describe "by_id/1" do
    setup do
      insert(:battle)

      :ok
    end

    test "returns the battle when a valid id is given" do
      {:ok, [battle | _tail]} = Get.all()
      id = battle.id

      response = Get.by_id(id)

      assert {:ok,
              %Battle{
                id: ^id,
                defeated: %Pokemon{
                  id: _pokemon_id1,
                  image:
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                  name: "pikachu",
                  type: "electric"
                },
                defeated_id: _pokemon_id2,
                inserted_at: ~N[2022-02-04 20:08:02],
                updated_at: ~N[2022-02-04 20:08:02],
                victorious: %Pokemon{
                  id: _pokemon_id3,
                  image:
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                  name: "charmander",
                  type: "fire"
                },
                victorious_id: _pokemon_id4
              }} = response
    end

    test "returns an error when an invalid id is given" do
      id = "ebd41cf6-1fb4-4c98-90be-76882b43f0a9"

      response = Get.by_id(id)

      expected = {:error, %Expokefight.Error{result: "Battle not found", status: :not_found}}

      assert response == expected
    end
  end
end
