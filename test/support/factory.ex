defmodule Expokefight.Factory do
  use ExMachina.Ecto, repo: Expokefight.Repo
  alias Expokefight.Pokeapi.Response
  alias Expokefight.{Battle, Pokemon}

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

  def battle_params_factory do
    %{
      "victorious" => build(:pokemon_params),
      "defeated" =>
        build(:pokemon_params, %{
          "name" => "Pikachu",
          "image" =>
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
          "type" => "electric"
        })
    }
  end

  def battle_factory do
    %Battle{
      defeated: %Pokemon{
        id: "b685aa7f-bf8d-46bb-829e-6788538fca2e",
        image:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
        name: "pikachu",
        type: "electric"
      },
      defeated_id: "b685aa7f-bf8d-46bb-829e-6788538fca2e",
      id: "621a7e80-f341-4e22-82af-74e2a83c2c41",
      inserted_at: ~N[2022-02-04 20:08:02],
      updated_at: ~N[2022-02-04 20:08:02],
      victorious: %Pokemon{
        id: "93d8df32-b949-42bd-8fc4-f03ec954cd38",
        image:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
        name: "charmander",
        type: "fire"
      },
      victorious_id: "93d8df32-b949-42bd-8fc4-f03ec954cd38"
    }
  end

  def pokeapi_response_factory do
    %Response{
      name: "bulbasaur",
      sprites: %{
        "other" => %{
          "official-artwork" => %{
            "front_default" =>
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
          }
        }
      },
      types: [
        %{
          "slot" => 1,
          "type" => %{
            "name" => "grass",
            "url" => "https://pokeapi.co/api/v2/type/12/"
          }
        },
        %{
          "slot" => 2,
          "type" => %{
            "name" => "poison",
            "url" => "https://pokeapi.co/api/v2/type/4/"
          }
        }
      ]
    }
  end
end
