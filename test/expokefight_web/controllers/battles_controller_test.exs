defmodule Expokefight.BattlesControllerTest do
  use ExpokefightWeb.ConnCase, async: true
  import Mox
  import Expokefight.Factory
  alias Expokefight.Pokeapi.ClientMock

  describe "create/2" do
    test "create a battle when all parameters are valid", %{conn: conn} do
      params = %{"pokemon1" => "charmander", "pokemon2" => "ditto"}

      expect(ClientMock, :get_pokemons, fn _pokemons ->
        {:ok, [build(:pokeapi_response), build(:pokeapi_response)]}
      end)

      response =
        conn
        |> post(Routes.battles_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "battle" => %{
                 "date" => _date,
                 "defeatead" => %{
                   "id" => _pokemon_id1,
                   "image" =>
                     "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
                   "name" => "bulbasaur",
                   "type" => "grass/poison"
                 },
                 "id" => _battle_id,
                 "victorious" => %{
                   "id" => _pokemon_id2,
                   "image" =>
                     "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
                   "name" => "bulbasaur",
                   "type" => "grass/poison"
                 }
               }
             } = response
    end

    test "returns an error when there is an invalid parameter", %{conn: conn} do
      params = %{"pokemon1" => "charmander", "pokemon10" => "ditto"}

      response =
        conn
        |> post(Routes.battles_path(conn, :create, params))
        |> json_response(:bad_request)

      expected = %{"message" => "Invalid parameters"}

      assert response == expected
    end

    test "returns an error when there is missing parameters", %{conn: conn} do
      params = %{"pokemon1" => "charmander"}

      response =
        conn
        |> post(Routes.battles_path(conn, :create, params))
        |> json_response(:bad_request)

      expected = %{"message" => "Invalid parameters"}

      assert response == expected
    end
  end

  describe "get/2" do
    setup %{conn: conn} do
      insert(:battle)
      insert(:battle)

      {:ok, conn: conn}
    end

    test "returns all battles", %{conn: conn} do
      response =
        conn
        |> get(Routes.battles_path(conn, :index))
        |> json_response(:ok)

      assert %{
               "battles" => [
                 %{
                   "defeated" => %{
                     "image" =>
                       "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                     "name" => "pikachu",
                     "type" => "electric",
                     "id" => _pokemon_id1
                   },
                   "victorious" => %{
                     "image" =>
                       "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                     "name" => "charmander",
                     "type" => "fire",
                     "id" => _pokemon_id2
                   },
                   "id" => _battle_id1
                 },
                 %{
                   "defeated" => %{
                     "id" => _pokemon_id3,
                     "image" =>
                       "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                     "name" => "pikachu",
                     "type" => "electric"
                   },
                   "id" => _battle_id2,
                   "victorious" => %{
                     "id" => _pokemon_id4,
                     "image" =>
                       "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                     "name" => "charmander",
                     "type" => "fire"
                   }
                 }
               ]
             } = response
    end

    test "returns the battle when id is found", %{conn: conn} do
      id = "ebd41cf6-1fb4-4c98-90be-76882b43f0a9"

      :battle
      |> build(id: id)
      |> insert()

      response =
        conn
        |> get(Routes.battles_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "battle" => %{
                 "date" => "2022-02-04T20:08:02",
                 "defeatead" => %{
                   "id" => _pokemon_id1,
                   "image" =>
                     "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                   "name" => "pikachu",
                   "type" => "electric"
                 },
                 "id" => ^id,
                 "victorious" => %{
                   "id" => _pokemon_id2,
                   "image" =>
                     "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
                   "name" => "charmander",
                   "type" => "fire"
                 }
               }
             } = response
    end

    test "returns an error when id is not found", %{conn: conn} do
      id = "ebd41cf6-1fb4-4c98-90be-76882b43f0a0"

      response =
        conn
        |> get(Routes.battles_path(conn, :show, id))
        |> json_response(:not_found)

      expected = %{"message" => "Battle not found"}

      assert response == expected
    end

    test "returns an error when id format is invalid", %{conn: conn} do
      id = "kiwi"

      response =
        conn
        |> get(Routes.battles_path(conn, :show, id))
        |> json_response(:bad_request)

      expected = %{"message" => "Invalid UUID"}

      assert response == expected
    end
  end
end
