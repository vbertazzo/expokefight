defmodule Expokefight.Pokeapi.Behaviour do
  @moduledoc """
  Behaviour for PokeAPI Client
  """
  alias Expokefight.Error

  @doc """
  Get pokemons from PokeAPI
  """
  @callback get_pokemons(list(String.t())) :: {:ok, list} | {:error, Error.t()}
end
