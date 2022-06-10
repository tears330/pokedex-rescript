%%raw("import './app.css'")

let isAuth = (page: unit => React.element, user: Types.Codecs.t_user, isLoading) => {
  switch (user, isLoading) {
  | (_, true) => React.null
  | (Some(_), false) => page()
  | (None, false) => <Redirect to="/login" />
  }
}

@react.component
let make = () => {
  let route = Hooks.useRoute()

  let (user, _, isLoading) = Hooks.useUser()

  switch route {
  | Home => isAuth(() => <Redirect to="/pokedex" />, user, isLoading)
  | Login => <Login />
  | Pokedex(routeParams) => isAuth(() => <Pokedex routeParams />, user, isLoading)
  | NotFound => "404 Page"->React.string
  }
}
