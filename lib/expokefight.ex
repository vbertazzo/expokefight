defmodule Expokefight do
  alias Expokefight.Battles.Create, as: BattleCreate

  defdelegate create_battle(params), to: BattleCreate, as: :call
end
