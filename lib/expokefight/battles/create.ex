defmodule Expokefight.Battles.Create do
  @moduledoc """
  Functions for creating a battle
  """

  alias Expokefight.{Battle, Error, Repo}
  alias Expokefight.Battles.TransformData

  @doc """
  Creates a pokemon battle with information from the external api

  ## Example

    iex> Expokefight.Battles.Create.call(%{"pokemon1" => "charmander", "pokemon2" => "ditto"})
    %Battle{}

  """
  def call(params) do
    with {:ok, normalized_params} <- TransformData.normalize_params(params),
         {:ok, pokemons} <- client().get_pokemons(normalized_params),
         changeset <- create_battle_changeset(pokemons),
         {:ok, %Battle{}} = battle <- Repo.insert(changeset) do
      battle
    else
      {:error, %Error{}} = error -> error
    end
  end

  defp create_battle_changeset(pokemons) do
    pokemons
    |> TransformData.call()
    |> simulate_battle()
    |> Battle.changeset()
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
