defmodule Expokefight do
  @moduledoc """
  Expokefight is a JSON API that simulates a pokemon battle for Brainn.co's backend challenge.
  """

  alias Expokefight.Battles.Create, as: BattleCreate
  alias Expokefight.Battles.Get, as: BattleGet

  defdelegate create_battle(params), to: BattleCreate, as: :call
  defdelegate get_all_battles(), to: BattleGet, as: :all
  defdelegate get_battle_by_id(id), to: BattleGet, as: :by_id
end
