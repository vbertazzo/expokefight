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

  def index(conn, _params) do
    with {:ok, battles} <- Expokefight.get_all_battles() do
      conn
      |> put_status(:ok)
      |> render("index.json", battles: battles)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Battle{} = battle} <- Expokefight.get_battle_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("battle.json", battle: battle)
    end
  end
end
