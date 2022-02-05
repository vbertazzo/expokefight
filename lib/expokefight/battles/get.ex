defmodule Expokefight.Battles.Get do
  alias Expokefight.{Battle, Error, Repo}

  def all() do
    battles =
      Battle
      |> Repo.all()
      |> Repo.preload([:victorious, :defeated])

    {:ok, battles}
  end

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
