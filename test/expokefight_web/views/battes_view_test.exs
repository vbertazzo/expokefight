defmodule ExpokefightWeb.BattlesViewTest do
  use ExpokefightWeb.ConnCase, async: true

  import Expokefight.Factory
  import Phoenix.View

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
end
