defmodule Expokefight.Battle do
  use Ecto.Schema
  import Ecto.Changeset
  alias Expokefight.Pokemon

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "battles" do
    belongs_to :victorious, Pokemon, foreign_key: :victorious_id
    belongs_to :defeated, Pokemon, foreign_key: :defeated_id

    timestamps()
  end

  def changeset(battle \\ %__MODULE__{}, params) do
    battle
    |> cast(params, [])
    |> cast_assoc(:victorious, with: &Pokemon.changeset/2)
    |> cast_assoc(:defeated, with: &Pokemon.changeset/2)
  end
end
