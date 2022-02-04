defmodule ExpokefightWeb.BattlesView do
  use ExpokefightWeb, :view
  alias Expokefight.Battle

  def render("create.json", %{
        battle: %Battle{id: id, victorious: victorious, defeated: defeatead, inserted_at: date}
      }) do
    %{
      battle: %{
        id: id,
        victorious: victorious,
        defeatead: defeatead,
        date: date
      }
    }
  end
end
