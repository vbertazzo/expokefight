defmodule Expokefight.Battles.TransformData do
  @moduledoc """
  Functions for transforming the data coming from the PokeAPI
  """

  alias Expokefight.Error

  @doc """
  Removes unnecessary fields from PokeAPI
  """
  def call(pokemons) do
    pokemons
    |> Enum.map(&transform_pokemon_data/1)
  end

  @doc """
  Ensures correct arguments and returns the pokemon names in downcase

  ## Example

    iex> Expokefight.Battles.TransformData.normalize_params(%{"pokemon1" => "CHARMANDER", "pokemon2" => "ditto"})
    {:ok, ["charmander", "ditto"]}

    iex> Expokefight.Battles.TransformData.normalize_params(%{"pokemon1" => "CHARMANDER"})
    {:error, Error.build(:bad_request, "Invalid parameters")

  """
  def normalize_params(%{"pokemon1" => pokemon1, "pokemon2" => pokemon2}) do
    pokemon1 = downcase_and_trim(pokemon1)

    pokemon2 = downcase_and_trim(pokemon2)

    {:ok, [pokemon1, pokemon2]}
  end

  def normalize_params(_params), do: {:error, Error.build(:bad_request, "Invalid parameters")}

  defp downcase_and_trim(string) do
    string
    |> String.downcase()
    |> String.trim()
  end

  defp transform_pokemon_data(pokemon) do
    pokemon
    |> Map.from_struct()
    |> handle_image()
    |> handle_types()
  end

  defp handle_image(pokemon) do
    image =
      pokemon
      |> Map.get(:sprites)
      |> Map.get("other")
      |> Map.get("official-artwork")
      |> Map.get("front_default")

    pokemon
    |> Map.put(:image, image)
    |> Map.delete(:sprites)
  end

  defp handle_types(pokemon) do
    types =
      pokemon
      |> Map.get(:types)
      |> Enum.map(fn type -> type["type"]["name"] end)
      |> Enum.join("/")

    pokemon
    |> Map.put(:type, types)
    |> Map.delete(:types)
  end
end
