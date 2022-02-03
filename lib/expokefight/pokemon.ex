defmodule Expokefight.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :image, :type]

  @derive {Jason.Encoder, only: [:id, :name, :image, :type]}

  schema "pokemons" do
    field :name, :string
    field :image, :string
    field :type, :string
  end

  def changeset(pokemon \\ %__MODULE__{}, params) do
    pokemon
    |> cast(params, @required_params)
    |> validate_params(@required_params)
  end

  defp validate_params(struct, fields) do
    struct
    |> validate_required(fields)
  end
end
