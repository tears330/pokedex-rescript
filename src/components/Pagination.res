@react.component
let make = React.memo((
  ~pageSize: int,
  ~current: int,
  ~total: int,
  ~maxPage=5,
  ~className="",
  ~onChange: (~pageNo: int) => unit,
) => {
  let pageCount = Js.Math.ceil_int(total->Belt_Int.toFloat /. pageSize->Belt_Int.toFloat)
  let pageBtnCount = Js.Math.min_int(pageCount, maxPage)
  <section className={cx(["flex justify-between bg-dark-900 p-5", className])}>
    <ul className="flex space-x-2">
      {Belt.Array.makeBy(pageBtnCount, index => {
        <li key={index->Belt.Int.toString}>
          <Button
            theme={current === index + 1 ? #primary : #default}
            onClick={_ => onChange(~pageNo=index + 1)}>
            {(index + 1)->React.int}
          </Button>
        </li>
      })->React.array}
    </ul>
    <ul className="flex space-x-2">
      <li>
        <Button disabled={current === 1} onClick={_ => onChange(~pageNo=current - 1)}>
          {"Prev"->React.string}
        </Button>
      </li>
      <li>
        <Button disabled={current === pageCount} onClick={_ => onChange(~pageNo=current + 1)}>
          {"Next"->React.string}
        </Button>
      </li>
    </ul>
  </section>
})
