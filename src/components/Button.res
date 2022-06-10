type size = [#lg | #md]

type theme = [#primary | #default]

@react.component
let make = React.memo((
  ~size: size=#md,
  ~theme: theme=#default,
  ~loading=false,
  ~children,
  ~type_=?,
  ~disabled=false,
  ~className="",
  ~onClick=?,
) => {
  <button
    className={cx([
      "inline-flex justify-center items-center rounded-md focus:outline-none transition-colors",
      switch size {
      | #lg => "text-lg py-4 px-5 font-bold"
      | #md => "text-base py-1 px-3"
      },
      switch (disabled || loading, theme) {
      | (true, #primary) => "bg-gray-300 text-gray-500"
      | (true, #default) => "bg-dark-900 text-dark-200"
      | (false, #primary) => "bg-primary hover:bg-primary-dark text-white-900"
      | (false, #default) => "bg-dark-500 text-white-900 hover:bg-dark-300"
      },
      disabled ? "cursor-not-allowed" : "cursor-pointer",
      className,
    ])}
    ?type_
    ?onClick
    disabled={disabled}>
    {loading ? <Spin /> : React.null} {children}
  </button>
})
