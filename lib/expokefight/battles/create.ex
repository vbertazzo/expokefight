defmodule Expokefight.Battles.Create do
  alias Expokefight.{Battle, Error, Repo}
  alias Expokefight.Battles.TransformData

  def call(params) do
    with {:ok, normalized_params} <- normalize_params(params),
         {:ok, pokemons} <- client().get_pokemons(normalized_params),
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

  defp normalize_params(%{"pokemon1" => pokemon1, "pokemon2" => pokemon2}) do
    pokemon1 = String.downcase(pokemon1)
    pokemon2 = String.downcase(pokemon2)

    {:ok, [pokemon1, pokemon2]}
  end

  defp normalize_params(_params), do: {:error, Error.build(:bad_request, "Invalid parameters")}

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
