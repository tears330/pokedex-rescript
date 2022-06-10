module Item = {
  @react.component
  let make = React.memo((~label: string, ~children) => {
    <li
      className="border-b border-dark-200 flex justify-between items-center px-4 py-2 hover:bg-dark-200 transition-colors flex-wrap">
      <span className="font-bold md:w-1/2 lg:w-auto"> {label->React.string} </span>
      <span className="space-x-2 space-y-2 md:flex-1 lg:flex-none overflow-auto"> {children} </span>
    </li>
  })
}

@react.component
let make = React.memo((~title=?, ~children) => {
  <div className="flex flex-col w-full">
    {switch title {
    | Some(title) =>
      <h3 className="text-2xl font-bold text-white-800 mb-5"> {title->React.string} </h3>
    | None => React.null
    }}
    <ul className="text-white-800 px-5"> {children} </ul>
  </div>
})
