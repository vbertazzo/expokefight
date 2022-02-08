defmodule ExpokefightWeb.BattlesView do
  use ExpokefightWeb, :view

  def render("create.json", %{battle: battle}) do
    %{battle: render_one(battle, __MODULE__, "battle.json", as: :battle)}
  end

  def render("index.json", %{battles: battles}) do
    %{battles: render_many(battles, __MODULE__, "battle.json", as: :battle)}
  end

  def render("show.json", %{battle: battle}) do
    %{battle: render_one(battle, __MODULE__, "battle.json", as: :battle)}
  end

  def render("battle.json", %{battle: battle}) do
    %{
      id: battle.id,
      victorious: battle.victorious,
      defeatead: battle.defeated,
      date: battle.inserted_at
    }
  end
end
