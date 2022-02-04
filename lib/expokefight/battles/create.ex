defmodule Expokefight.Battles.Create do
  alias Expokefight.{Battle, Error, Repo}
  alias Expokefight.Battles.TransformData

  def call(params) do
    pokemon1 = Map.get(params, "pokemon1")
    pokemon2 = Map.get(params, "pokemon2")

    with {:ok, pokemons} <- client().get_pokemons([pokemon1, pokemon2]),
         pokemons <- TransformData.call(pokemons),
         pokemons <- simulate_battle(pokemons),
         changeset <- Battle.changeset(pokemons),
         {:ok, %Battle{}} = battle <- Repo.insert(changeset) do
      battle
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  defp simulate_battle(pokemons) do
    [victorious, defeated] = Enum.shuffle(pokemons)

    %{victorious: victorious, defeated: defeated}
  end

  defp client do
    :expokefight
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:pokeapi_adapter)
  end
end
