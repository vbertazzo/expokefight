defmodule Expokefight.Battles.TransformData do
  alias Expokefight.Error

  def call(pokemons) do
    pokemons
    |> Enum.map(&transform_pokemon_data/1)
  end

  def normalize_params(%{"pokemon1" => pokemon1, "pokemon2" => pokemon2}) do
    pokemon1 = String.downcase(pokemon1)
    pokemon2 = String.downcase(pokemon2)

    {:ok, [pokemon1, pokemon2]}
  end

  def normalize_params(_params), do: {:error, Error.build(:bad_request, "Invalid parameters")}

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
