@val external localStorage: Dom_storage2.t = "localStorage"

let useUser = () => {
  let (user, setUser) = React.useState(_ => Types.Codecs.None)

  React.useEffect0(() => {
    switch localStorage
    ->Dom.Storage2.getItem("user")
    ->Belt_Option.getWithDefault("")
    ->Jzon.decodeStringWith(Types.Codecs.user) {
    | Ok(user) => setUser(_ => Some(user))
    | _ => setUser(_ => None)
    }

    None
  })

  React.useEffect1(() => {
    switch user {
    | Some(user) =>
      localStorage->Dom.Storage2.setItem("user", user->Jzon.encodeStringWith(Types.Codecs.user))
    | None => ()
    }
    None
  }, [user])

  (user, setUser)
}
