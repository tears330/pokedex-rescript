%%raw("import './app.css'")

let isAuth = (page: unit => React.element, user: Types.Codecs.t_user) => {
  switch user {
  | Some(_) => page()
  | None => {
      RescriptReactRouter.push("/login")
      React.null
    }
  }
}

@react.component
let make = () => {
  let route = Route.useRoute()

  let (user, _) = User.useUser()

  switch route {
  | Login => React.null
  | Pokedex(pageNo, pokemonId) =>
    isAuth(
      () =>
        <Pokedex
          pageNo={pageNo->Belt_Int.fromString->Belt_Option.getWithDefault(1)} pokemonId={pokemonId}
        />,
      user,
    )
  | NotFound => "404 Page"->React.string
  }
}
