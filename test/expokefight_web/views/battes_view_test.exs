defmodule ExpokefightWeb.BattlesViewTest do
  use ExpokefightWeb.ConnCase, async: true
  import Expokefight.Factory
  import Phoenix.View
  alias Expokefight.{Battle, Pokemon}
  alias ExpokefightWeb.BattlesView

  test "renders create.json" do
    battle = build(:battle)

    response = render(BattlesView, "create.json", battle: battle)

    assert %{
             battle: %{
               id: _battle_id,
               victorious: %{
                 id: _pokemon_id1,
                 image:
                   "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                 name: "charmander",
                 type: "fire"
               },
               date: ~N[2022-02-04 20:08:02],
               defeatead: %{
                 id: _pokemon_id2,
                 image:
                   "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                 name: "pikachu",
                 type: "electric"
               }
             }
           } = response
  end

  test "renders index.json" do
    battles = build_pair(:battle)

    response = render(BattlesView, "index.json", battles: battles)

    assert %{
             battles: [
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
             ]
           } = response
  end

  test "renders battle.json" do
    battle = build(:battle)

    response = render(BattlesView, "battle.json", battle: battle)

    assert %{
             battle: %{
               id: _battle_id,
               victorious: %{
                 id: _pokemon_id1,
                 image:
                   "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                 name: "charmander",
                 type: "fire"
               },
               date: ~N[2022-02-04 20:08:02],
               defeatead: %{
                 id: _pokemon_id2,
                 image:
                   "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                 name: "pikachu",
                 type: "electric"
               }
             }
           } = response
  end
end
