<h1 align="center">
  ExPokeFight
</h1>

## 🎯 About

ExPokeFight is a JSON API that returns information about a simulated battle between two pokemons. It's a project for a [backend exercise](https://github.com/brainnco-exs/readme-backend) from [Brainn.co](https://brainn.co/).

## 🚀 Tech, tools and concepts

- [Elixir](https://github.com/elixir-lang/elixir)
- [Phoenix](https://github.com/phoenixframework/phoenix)
- [Ecto](https://github.com/elixir-ecto/ecto)
- [ExUnit](https://github.com/elixir-lang/elixir/blob/master/lib/ex_unit/lib/ex_unit.ex)
- [Tesla](https://github.com/teamon/tesla)
- [PokeAPI](https://pokeapi.co)
- [PostgreSQL](https://www.postgresql.org)

## 🔧 Setup

To clone and run this application, you'll need [Git](https://git-scm.com), [PostgreSQL](https://www.postgresql.org/download) or an PostgreSQL image on [Docker](https://www.docker.com/get-started), [Elixir](https://elixir-lang.org) and [Erlang](https://www.erlang.org) installed.

From command line:

```bash
# Clone this repository
$ git clone https://github.com/vbertazzo/expokefight

# Go into the repository
$ cd expokefight

# Install dependencies
$ mix deps.get

# Create and migrate your database
$ mix ecto.setup

# or you can run migration manually with
$ mix ecto.migrate

# Start server
$ mix phx.server

# Remember that you will need to start your PostgreSQL locally running on port 4000
```

## 📝 License

This project is [MIT](https://github.com/vbertazzo/expokefight/blob/main/LICENSE) licensed.
