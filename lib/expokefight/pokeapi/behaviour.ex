defmodule Expokefight.Pokeapi.Behaviour do
  alias Expokefight.Error

  @callback get_pokemons(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
