defmodule ExpokefightWeb.BattlesController do
  use ExpokefightWeb, :controller
  alias Expokefight.Battle
  alias ExpokefightWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Battle{} = battle} <- Expokefight.create_battle(params) do
      conn
      |> put_status(:created)
      |> render("create.json", battle: battle)
    end
  end
end
