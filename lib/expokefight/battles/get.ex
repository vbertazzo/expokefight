defmodule Expokefight.Battles.Get do
  @moduledoc """
  Functions for getting battle information
  """
  alias Expokefight.{Battle, Error, Repo}

  @doc """
  Get all battles
  """
  def all do
    battles =
      Battle
      |> Repo.all()
      |> Repo.preload([:victorious, :defeated])

    {:ok, battles}
  end

  @doc """
  Get a battle by id
  """
  def by_id(id) do
    result =
      Battle
      |> Repo.get(id)
      |> Repo.preload([:victorious, :defeated])

    case result do
      nil -> {:error, Error.build(:not_found, "Battle not found")}
      battle -> {:ok, battle}
    end
  end
end
