defmodule ExpokefightWeb.BattlesViewTest do
  use ExpokefightWeb.ConnCase, async: true
  import Expokefight.Factory
  import Phoenix.View
  alias Expokefight.Pokemon
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
               defeated: %{
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
               %{
                 date: ~N[2022-02-04 20:08:02],
                 defeated: %Pokemon{
                   id: _pokemon_id1,
                   image:
                     "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                   name: "pikachu",
                   type: "electric"
                 },
                 id: _battle_id1,
                 victorious: %Pokemon{
                   id: _pokemon_id2,
                   image:
                     "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                   name: "charmander",
                   type: "fire"
                 }
               },
               %{
                 date: ~N[2022-02-04 20:08:02],
                 defeated: %Pokemon{
                   id: _pokemon_id3,
                   image:
                     "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                   name: "pikachu",
                   type: "electric"
                 },
                 id: _battle_id2,
                 victorious: %Pokemon{
                   id: _pokemon_id4,
                   image:
                     "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                   name: "charmander",
                   type: "fire"
                 }
               }
             ]
           } = response
  end

  test "renders show.json" do
    battle = build(:battle)

    response = render(BattlesView, "show.json", battle: battle)

    assert %{
             battle: %{
               date: ~N[2022-02-04 20:08:02],
               defeated: %Pokemon{
                 id: _pokemon_id1,
                 image:
                   "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                 name: "pikachu",
                 type: "electric"
               },
               id: _battle_id,
               victorious: %Pokemon{
                 id: _pokemon_id2,
                 image:
                   "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                 name: "charmander",
                 type: "fire"
               }
             }
           } = response
  end
end
