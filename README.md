<h1 align="center">
  ExPokeFight
</h1>

## 🎯 About

ExPokeFight is a JSON API that returns information about a simulated battle between two pokemons. It's a project for a [backend exercise](https://github.com/brainnco-exs/readme-backend) from [Brainn.co](https://brainn.co/).

---

## 🚀 Tech, tools and concepts

- [Elixir](https://github.com/elixir-lang/elixir)
- [Phoenix](https://github.com/phoenixframework/phoenix)
- [Ecto](https://github.com/elixir-ecto/ecto)
- [ExUnit](https://github.com/elixir-lang/elixir/blob/master/lib/ex_unit/lib/ex_unit.ex)
- [Tesla](https://github.com/teamon/tesla)
- [PokeAPI](https://pokeapi.co)
- [PostgreSQL](https://www.postgresql.org)

---

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

---
##  Endpoints
### Create a battle

### Request

`POST /api/battles`

Body:
```json
{
	"pokemon1": "gengar",
	"pokemon2": "ditto"
}
```

### Response

`201 Created`

```json
{
	"battle": {
		"date": "2022-02-08T17:21:38",
		"defeated": {
			"id": "1c1b01e1-898d-4cd5-9d84-9b7679ca7ca5",
			"name": "ditto",
			"image": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png",
			"type": "normal"
		},
		"id": "89bf78a2-6500-406a-963b-10de75f7a91f",
		"victorious": {
			"id": "d65dcb78-def2-464d-8c2f-90624f4a7949",
			"name": "gengar",
			"image": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/94.png",
			"type": "ghost/poison"
		}
	}
}
```

---

### Get battle by id

### Request

`GET /api/battles/:id`

### Response

`200 OK`

```json
{
	"battle": {
		"date": "2022-02-08T17:21:38",
		"defeated": {
			"id": "1c1b01e1-898d-4cd5-9d84-9b7679ca7ca5",
			"name": "ditto",
			"image": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png",
			"type": "normal"
		},
		"id": "89bf78a2-6500-406a-963b-10de75f7a91f",
		"victorious": {
			"id": "d65dcb78-def2-464d-8c2f-90624f4a7949",
			"name": "gengar",
			"image": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/94.png",
			"type": "ghost/poison"
		}
	}
}
```

---

### Get all battles

### Request

`GET /api/battles`

### Response

`200 OK`

```json
{
	"battles": [
    {
			"id": "89bf78a2-6500-406a-963b-10de75f7a91f",
			"date": "2022-02-08T17:21:38",
			"victorious": {
				"id": "d65dcb78-def2-464d-8c2f-90624f4a7949",
				"name": "gengar",
				"image": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/94.png",
				"type": "ghost/poison"
			},
			"defeated": {
				"id": "1c1b01e1-898d-4cd5-9d84-9b7679ca7ca5",
				"name": "ditto",
				"image": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png",
				"type": "normal"
			}
		},
		{
			"id": "d19803da-24df-440b-8b6c-075eb87ff20c",
			"date": "2022-02-08T17:37:53",
			"victorious": {
				"id": "adbf13e3-4e78-4c0b-ace9-851bf9a5913d",
				"name": "pikachu",
				"image": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
				"type": "electric"
			},
			"defeated": {
				"id": "87211c58-944d-4c0c-a897-bece19daec96",
				"name": "charmander",
				"image": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
				"type": "fire"
			}
		}
	]
}
```

---

## 📝 License

This project is [MIT](https://github.com/vbertazzo/expokefight/blob/main/LICENSE) licensed.
