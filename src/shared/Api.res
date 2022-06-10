type t_pokemon_attack = {__typename: string, name: option<string>, damage: option<int>}

module FetchPokemonList = %graphql(`
  query allPoke {
    pokemons(first: 50) {
      id
      number
      name
      image
    }
  }
`)

module FetchPokemonDetail = %graphql(`
  query pokemon($id: String!) {
    pokemon(id: $id) {
      id
      number
      name
      image
      classification
      types
      resistant
      attacks {
        fast @ppxAs(type: "t_pokemon_attack") {
          name
          damage
        }
        special @ppxAs(type: "t_pokemon_attack") {
          name
          damage
        }
      }
      weaknesses
      fleeRate
      maxCP
      maxHP
      evolutions {
        name
        id
        image
      }
      evolutionRequirements {
        amount
        name
      }
      weight {
        minimum
        maximum
      }
      height {
        minimum
        maximum
      }
    }
  }
`)
