@react.component
let make = (~className="", ~color="#fff", ~children, ~onClick=?) => {
  <span
    ?onClick
    className={`rounded text-white-800 text-xs px-2 py-1 inline-flex justify-center items-center ${className}`}
    style={ReactDOM.Style.make(
      ~backgroundColor=color,
      ~textShadow="1px 1px 1px rgb(0 0 0 / 70%)",
      (),
    )}>
    {children}
  </span>
}
