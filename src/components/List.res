type listStatus<'a> = Data(array<'a>, int) | Error | Loading

@react.component
let make = (
  ~loading=false,
  ~error: option<string>,
  ~data: option<array<'a>>,
  ~dataKey: (~item: 'a) => string,
  ~render: (~item: 'a, ~itemIndex: int, ~list: array<'a>) => React.element,
  ~pageSize: int,
  ~current: int,
  ~onPageChange: (~pageNo: int) => unit,
) => {
  let status = {
    if loading {
      Loading
    } else if error->Belt.Option.isSome {
      Error
    } else {
      switch data {
      | Some(data) =>
        Data((
          data->Js_array2.filteri((_, index) =>
            index >= current * pageSize && index < (current + 1) * pageSize
          ),
          data->Js_array2.length,
        ))
      | None => Data(([], 0))
      }
    }
  }

  <section className="flex flex-col bg-dark-500 w-full h-[80vh] overflow-hidden">
    {switch status {
    | Loading =>
      <div className="h-full w-full flex justify-center items-center text-2xl text-dark-100">
        <Spin />
      </div>
    | Error =>
      <div className="h-full w-full flex justify-center items-center text-2xl text-dark-100">
        {"Something went wrong :("->React.string}
      </div>
    | Data(currentList, total) => <>
        <ul className="flex-1 space-y-3 overflow-y-auto xl:px-16 sm:px-4 sm:py-3 md:px-6 md:py-5">
          {currentList
          ->Belt.Array.mapWithIndex((index, item) =>
            <li key={dataKey(~item)}> {render(~item, ~itemIndex=index, ~list=currentList)} </li>
          )
          ->React.array}
        </ul>
        <Pagination pageSize current total onChange={onPageChange} />
      </>
    }}
  </section>
}
