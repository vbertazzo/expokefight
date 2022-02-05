defmodule Expokefight do
  alias Expokefight.Battles.Create, as: BattleCreate
  alias Expokefight.Battles.Get, as: BattleGet

  defdelegate create_battle(params), to: BattleCreate, as: :call
  defdelegate get_all(), to: BattleGet, as: :all
end
