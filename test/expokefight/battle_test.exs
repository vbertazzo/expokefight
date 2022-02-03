defmodule Expokefight.BattleTest do
  use Expokefight.DataCase, async: true
  import Expokefight.Factory

  alias Ecto.Changeset
  alias Expokefight.Battle

  describe "changeset/2" do
    test "returns a valid changeset when all params are valid" do
      params = build(:battle_params)

      response = Battle.changeset(params)

      assert %Changeset{
               changes: %{
                 defeated: %{changes: %{name: "Pikachu"}},
                 victorious: %{changes: %{name: "Squirtle"}}
               },
               valid?: true
             } = response
    end

    test "returns a valid updated changeset when updating a changeset" do
      params = build(:battle_params)

      new_params = %{
        victorious: build(:pokemon_params, %{"name" => "Blastoise"})
      }

      response =
        params
        |> Battle.changeset()
        |> Battle.changeset(new_params)

      assert %Changeset{
               changes: %{
                 defeated: %{changes: %{name: "Pikachu"}},
                 victorious: %{changes: %{name: "Blastoise"}}
               },
               valid?: true
             } = response
    end

    test "returns an invalid changeset when there is an error" do
      params = build(:battle_params, %{"victorious" => build(:pokemon_params, %{"name" => nil})})

      response = Battle.changeset(params)

      expected = %{victorious: %{name: ["can't be blank"]}}

      assert errors_on(response) == expected
    end
  end
end
