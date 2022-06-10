@react.component
let make = (
  ~selected: bool,
  ~img: string,
  ~highlight: string,
  ~title: string,
  ~className="",
  ~onClick=?,
) => {
  <div
    className={cx([
      "flex items-center px-7 py-4 rounded-md transition-colors cursor-pointer",
      !selected ? "bg-dark-300 hover:bg-dark-200" : "bg-dark-100 hover:bg-dark-100",
      className,
    ])}
    ?onClick>
    <img className="rounded-full w-[44px] h-[44px]" src={img} alt={title} />
    <div className="text-lg font-bold text-primary ml-6 mr-3"> {highlight->React.string} </div>
    <div className="text-lg font-bold text-white-800"> {title->React.string} </div>
  </div>
}
