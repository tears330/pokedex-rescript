@react.component
let make = (~pageNo: int, ~pokemonId: string) => {
  let {loading: pokemonLoading, data: pokemon} = Api.FetchPokemonDetail.use(
    ~skip=pokemonId === "",
    {
      id: pokemonId,
    },
  )

  let {loading: listLoading, error: listError, data: list} = Api.FetchPokemonList.use()

  let handleRouteChange = (~currPokemonId=pokemonId, ~currPageNo=pageNo, ()) =>
    RescriptReactRouter.push(`/pokedex/${currPageNo->Belt_Int.toString}/${currPokemonId}`)

  <div className="w-screen h-screen flex justify-center items-center bg-dark-200">
    <div className="flex w-10/12 h-[80vh] overflow-hidden rounded-lg lg:flex-row">
      <div className="lg:w-1/3 lg:min-w-fit w-0 min-w-0">
        <List
          current={pageNo}
          onPageChange={(~pageNo) => handleRouteChange(~currPageNo=pageNo, ())}
          data={list->Belt.Option.flatMap(item => item.pokemons)}
          error=listError
          dataKey={(~item) => {item->Belt_Option.mapWithDefault("id", item => item.id)}}
          render={(~item, ~itemIndex as _i) => {
            switch item {
            | Some(item) =>
              <Card
                selected={pokemonId === item.id}
                onClick={_ => handleRouteChange(~currPokemonId=item.id, ())}
                title={item.name->Belt_Option.getWithDefault("")}
                img={item.image->Belt_Option.getWithDefault("")}
                highlight={item.number->Belt_Option.getWithDefault("")}
              />
            | None => React.null
            }
          }}
          loading={listLoading}
        />
      </div>
      <div className="flex-1 bg-dark-300">
        <PokemonDetail
          loading={pokemonLoading}
          data={pokemon->Belt.Option.flatMap(item => item.pokemon)}
          onChange={(~item) => handleRouteChange(~currPokemonId=item.id, ())}
        />
      </div>
    </div>
  </div>
}
