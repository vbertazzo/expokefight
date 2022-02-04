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
               id: "621a7e80-f341-4e22-82af-74e2a83c2c41",
               victorious: %{
                 id: "93d8df32-b949-42bd-8fc4-f03ec954cd38",
                 image:
                   "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                 name: "charmander",
                 type: "fire"
               },
               date: ~N[2022-02-04 20:08:02],
               defeatead: %{
                 id: "b685aa7f-bf8d-46bb-829e-6788538fca2e",
                 image:
                   "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                 name: "pikachu",
                 type: "electric"
               }
             }
           } = response
  end
end
