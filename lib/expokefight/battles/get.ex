defmodule Expokefight.Battles.Get do
  alias Expokefight.{Battle, Repo}

  def all() do
    battles =
      Battle
      |> Repo.all()
      |> Repo.preload([:victorious, :defeated])

    {:ok, battles}
  end
end
