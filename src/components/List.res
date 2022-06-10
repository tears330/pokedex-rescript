@react.component
let make = (
  ~loading=false,
  ~error: option<ApolloClient__React_Types.ApolloError.t>,
  ~data: option<array<'a>>,
  ~dataKey: (~item: 'a) => string,
  ~render: (~item: 'a, ~itemIndex: int) => React.element,
  ~pageSize=10,
  ~current: int,
  ~onPageChange: (~pageNo: int) => unit,
) => {
  <section className="flex flex-col bg-dark-500 w-full h-[80vh] overflow-hidden">
    {switch (loading, error, data) {
    | (true, _, _) =>
      <div className="h-full w-full flex justify-center items-center text-2xl text-dark-100">
        <Spin />
      </div>
    | (false, Some(_error), _) =>
      <div className="h-full w-full flex justify-center items-center text-2xl text-dark-100">
        {"Something went wrong :("->React.string}
      </div>
    | (false, None, Some(data)) => <>
        <ul className="flex-1 space-y-3 overflow-y-auto xl:px-16 sm:px-4 sm:py-3 md:px-6 md:py-5">
          {data
          ->Js_array2.filteri((_, index) =>
            index >= (current - 1) * pageSize && index < current * pageSize
          )
          ->Belt.Array.mapWithIndex((index, item) =>
            <li key={dataKey(~item)}> {render(~item, ~itemIndex=index)} </li>
          )
          ->React.array}
        </ul>
        <Pagination pageSize current total={data->Belt_Array.length} onChange={onPageChange} />
      </>
    | (false, None, None) => React.null
    }}
  </section>
}
