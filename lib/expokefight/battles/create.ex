defmodule Expokefight.Battles.Create do
  alias Expokefight.{Battle, Error, Repo}
  alias Expokefight.Battles.TransformData

  def call(params) do
    with {:ok, normalized_params} <- TransformData.normalize_params(params),
         {:ok, pokemons} <- client().get_pokemons(normalized_params),
         pokemons <- TransformData.call(pokemons),
         pokemons <- simulate_battle(pokemons),
         changeset <- Battle.changeset(pokemons),
         {:ok, %Battle{}} = battle <- Repo.insert(changeset) do
      battle
    else
      {:error, %Error{}} = error -> error
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
