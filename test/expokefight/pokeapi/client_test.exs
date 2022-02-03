defmodule Expokefight.Pokeapi.ClientTest do
  use ExUnit.Case, async: true
  alias Expokefight.Error
  alias Expokefight.Pokeapi.{Client, Response}
  alias Plug.Conn

  describe "get_pokemon/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "returns the pokemon when its name is valid", %{bypass: bypass} do
      pokemon = "ditto"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{pokemon}", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body())
      end)

      response = Client.get_pokemon(url, pokemon)

      assert {:ok, %Response{name: "ditto"}} = response
    end

    test "returns an error when the pokemon name was not found", %{bypass: bypass} do
      pokemon = "elixirditto"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{pokemon}", fn conn ->
        Conn.resp(conn, 404, "")
      end)

      response = Client.get_pokemon(url, pokemon)

      expected = {:error, %Expokefight.Error{result: "Pokemon not found", status: :not_found}}

      assert response == expected
    end

    test "returns an error when there is a generic error", %{bypass: bypass} do
      pokemon = "ditto"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_pokemon(url, pokemon)

      expected = {:error, %Expokefight.Error{result: :econnrefused, status: :bad_request}}

      assert response == expected
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"

    defp body do
      ~s({
        "abilities": [
          {
            "ability": {
              "name": "limber",
              "url": "https://pokeapi.co/api/v2/ability/7/"
            },
            "is_hidden": false,
            "slot": 1
          }
        ],
        "base_experience": 101,
        "forms": [
          {
            "name": "ditto",
            "url": "https://pokeapi.co/api/v2/pokemon-form/132/"
          }
        ],
        "game_indices": [
          {
            "game_index": 76,
            "version": {
              "name": "red",
              "url": "https://pokeapi.co/api/v2/version/1/"
            }
          }
        ],
        "height": 3,
        "held_items": [
          {
            "item": {
              "name": "metal-powder",
              "url": "https://pokeapi.co/api/v2/item/234/"
            },
            "version_details": [
              {
                "rarity": 5,
                "version": {
                  "name": "ruby",
                  "url": "https://pokeapi.co/api/v2/version/7/"
                }
              }
            ]
          }
        ],
        "id": 132,
        "is_default": true,
        "location_area_encounters": "https://pokeapi.co/api/v2/pokemon/132/encounters",
        "moves": [
          {
            "move": {
              "name": "transform",
              "url": "https://pokeapi.co/api/v2/move/144/"
            },
            "version_group_details": [
              {
                "level_learned_at": 1,
                "move_learn_method": {
                  "name": "level-up",
                  "url": "https://pokeapi.co/api/v2/move-learn-method/1/"
                },
                "version_group": {
                  "name": "red-blue",
                  "url": "https://pokeapi.co/api/v2/version-group/1/"
                }
              }
            ]
          }
        ],
        "name": "ditto",
        "order": 203,
        "past_types": [],
        "species": {
          "name": "ditto",
          "url": "https://pokeapi.co/api/v2/pokemon-species/132/"
        },
        "sprites": {
          "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png"
        },
        "stats": [
          {
            "base_stat": 48,
            "effort": 1,
            "stat": {
              "name": "hp",
              "url": "https://pokeapi.co/api/v2/stat/1/"
            }
          }
        ],
        "types": [
          {
            "slot": 1,
            "type": {
              "name": "normal",
              "url": "https://pokeapi.co/api/v2/type/1/"
            }
          }
        ],
        "weight": 40
      })
    end
  end
end
