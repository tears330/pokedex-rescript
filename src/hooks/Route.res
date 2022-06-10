type t_pokedex_params = {
  pageNo: option<string>,
  pokemonId: option<string>,
}

type t_route = Home | Login | Pokedex(t_pokedex_params) | NotFound

let useRoute = () => {
  let url = RescriptReactRouter.useUrl()
  switch url.path {
  | list{} => Home
  | list{"login"} => Login
  | list{"pokedex"} => Pokedex({pageNo: None, pokemonId: None})
  | list{"pokedex", pageNo} => Pokedex({pageNo: Some(pageNo), pokemonId: None})
  | list{"pokedex", pageNo, pokemonId} =>
    Pokedex({pageNo: Some(pageNo), pokemonId: Some(pokemonId)})
  | _ => NotFound
  }
}
