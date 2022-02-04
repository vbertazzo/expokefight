defmodule Expokefight.Battles.CreateTest do
  use Expokefight.DataCase, async: true
  import Mox
  import Expokefight.Factory
  alias Expokefight.{Battle, Error, Pokemon}
  alias Expokefight.Battles.Create
  alias Expokefight.Pokeapi.ClientMock

  describe "call/1" do
    test "returns a battle when all parameters are valid" do
      params = %{"pokemon1" => "charmander", "pokemon2" => "ditto"}

      expect(ClientMock, :get_pokemons, fn _pokemons ->
        {:ok, [build(:pokeapi_response), build(:pokeapi_response)]}
      end)

      response = Create.call(params)

      assert {:ok,
              %Battle{
                victorious: %Pokemon{name: "bulbasaur"},
                defeated: %Pokemon{name: "bulbasaur"}
              }} = response
    end

    test "returns an error when there are invalid parameters" do
      params = %{"pokemon1" => "charmander", "pokemon2" => "ditta"}

      expect(ClientMock, :get_pokemons, fn _pokemons ->
        {:error,
         %Error{
           result: "Pokemon not found",
           status: :not_found
         }}
      end)

      response = Create.call(params)

      expected = {:error, %Expokefight.Error{result: "Pokemon not found", status: :not_found}}

      assert response == expected
    end
  end
end
