defmodule Expokefight.Pokeapi.Client do
  use Tesla
  alias Expokefight.Error
  alias Expokefight.Pokeapi.Response
  alias Tesla.Env

  @base_url "https://pokeapi.co/api/v2/pokemon/"
  plug Tesla.Middleware.JSON

  def get_pokemon(url \\ @base_url, pokemon) do
    "#{url}#{pokemon}"
    |> get()
    |> handle_get()
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
