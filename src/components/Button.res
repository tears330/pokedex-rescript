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
      disabled || loading
        ? switch theme {
          | #primary => "bg-primary-500 text-white-800"
          | #default => "bg-dark-900 text-dark-200"
          }
        : switch theme {
          | #primary => "bg-primary hover:bg-primary-dark text-white-900"
          | #default => "bg-dark-900 text-dark-200"
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
