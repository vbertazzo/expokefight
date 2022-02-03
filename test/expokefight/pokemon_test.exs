defmodule Expokefight.PokemonTest do
  use Expokefight.DataCase, async: true
  import Expokefight.Factory

  alias Ecto.Changeset
  alias Expokefight.Pokemon

  describe "changeset/2" do
    test "returns a valid changeset when all params are valid" do
      params = build(:pokemon_params)

      response = Pokemon.changeset(params)

      assert %Changeset{changes: %{name: "Squirtle"}, valid?: true} = response
    end

    test "returns a valid updated changeset when updating a changeset" do
      params = build(:pokemon_params)

      new_params = %{
        name: "Blastoise"
      }

      response =
        params
        |> Pokemon.changeset()
        |> Pokemon.changeset(new_params)

      assert %Changeset{changes: %{name: "Blastoise"}, valid?: true} = response
    end

    test "returns an invalid changeset when there is an error" do
      params = build(:pokemon_params, %{"name" => nil, "image" => nil, "type" => nil})

      response = Pokemon.changeset(params)

      expected = %{
        name: ["can't be blank"],
        image: ["can't be blank"],
        type: ["can't be blank"]
      }

      assert errors_on(response) == expected
    end
  end
end
