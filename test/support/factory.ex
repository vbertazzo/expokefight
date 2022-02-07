defmodule Expokefight.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Expokefight.Repo
  alias Ecto.UUID
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
    id = UUID.generate()
    victorious_id = UUID.generate()
    defeated_id = UUID.generate()

    %Battle{
      defeated: %Pokemon{
        id: defeated_id,
        image:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
        name: "pikachu",
        type: "electric"
      },
      defeated_id: defeated_id,
      id: id,
      inserted_at: ~N[2022-02-04 20:08:02],
      updated_at: ~N[2022-02-04 20:08:02],
      victorious: %Pokemon{
        id: victorious_id,
        image:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
        name: "charmander",
        type: "fire"
      },
      victorious_id: victorious_id
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
