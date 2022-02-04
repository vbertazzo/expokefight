defmodule Expokefight.Battles.TransformData do
  def call(pokemons) do
    pokemons
    |> Enum.map(&transform_pokemon_data/1)
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
