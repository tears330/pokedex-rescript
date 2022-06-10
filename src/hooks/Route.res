type t_route = Login | Pokedex(string, string) | NotFound

let useRoute = () => {
  let url = RescriptReactRouter.useUrl()
  switch url.path {
  | list{"login"} => Login
  | list{"pokedex", pageNo, pokemonId} => Pokedex(pageNo, pokemonId)
  | _ => NotFound
  }
}
