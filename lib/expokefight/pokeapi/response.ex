defmodule Expokefight.Pokeapi.Response do
  @keys [:name, :sprites, :types]

  @enforce_keys @keys

  defstruct @keys

  def build(%{"name" => name, "sprites" => sprites, "types" => types}) do
    %__MODULE__{
      name: name,
      sprites: sprites,
      types: types
    }
  end
end
