@react.component
let make = (~to) => {
  React.useEffect0(() => {
    RescriptReactRouter.push(to)
    None
  })

  React.null
}
