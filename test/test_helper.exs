ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Expokefight.Repo, :manual)

Mox.defmock(Expokefight.Pokeapi.ClientMock, for: Expokefight.Pokeapi.Behaviour)
