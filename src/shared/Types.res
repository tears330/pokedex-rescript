module Codecs = {
  type t_user_content = {name: string}
  type t_user = None | Some(t_user_content)
  let user = Jzon.object1(
    ({name}) => name,
    name => {{name: name}}->Ok,
    Jzon.field("name", Jzon.string),
  )
}
