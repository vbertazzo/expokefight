defmodule Expokefight.Pokeapi.Client do
  @moduledoc """
  Client for the PokeAPI
  """

  @behaviour Expokefight.Pokeapi.Behaviour

  use Tesla
  alias Expokefight.Error
  alias Expokefight.Pokeapi.Response
  alias Tesla.Env

  @base_url "https://pokeapi.co/api/v2/pokemon/"

  plug Tesla.Middleware.JSON

  @impl Expokefight.Pokeapi.Behaviour
  def get_pokemons(url \\ @base_url, pokemons) do
    pokemons
    |> Enum.map(fn pokemon -> get_pokemon(url, pokemon) end)
    |> check_for_errors()
    |> parse_pokemon()
  end

  defp get_pokemon(url, pokemon) do
    "#{url}#{pokemon}"
    |> get()
    |> handle_get()
  end

  defp check_for_errors(pokemons) do
    pokemons
    |> Enum.find({:ok, pokemons}, fn {status, _reason} -> status == :error end)
  end

  defp parse_pokemon({:ok, pokemons}) do
    pokemons = Enum.map(pokemons, fn {:ok, %Response{} = response} -> response end)

    {:ok, pokemons}
  end

  defp parse_pokemon({:error, _reason} = error) do
    error
  end

  defp handle_get({:ok, %Env{status: 404}}) do
    {:error, Error.build(:not_found, "Pokemon not found")}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, Response.build(body)}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
