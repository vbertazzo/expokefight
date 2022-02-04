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
end
