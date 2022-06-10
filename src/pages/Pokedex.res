@react.component
let make = (~routeParams: Route.t_pokedex_params) => {
  let {pokemonId, pageNo} = routeParams
  let {loading: pokemonLoading, data: pokemon} = Api.FetchPokemonDetail.use(
    ~skip=pokemonId->Belt_Option.isNone,
    {
      id: pokemonId->Belt.Option.getWithDefault(""),
    },
  )

  let {loading: listLoading, error: listError, data: list} = Api.FetchPokemonList.use()

  let handleRouteChange = React.useCallback2(({pageNo, pokemonId}: Route.t_pokedex_params) => {
    RescriptReactRouter.push(
      `/pokedex/${pageNo->Belt_Option.getWithDefault("1")}/${pokemonId->Belt_Option.getWithDefault(
          "",
        )}`,
    )
  }, (pokemonId, pageNo))

  <div className="w-screen h-screen flex justify-center items-center bg-dark-200">
    <div className="flex w-10/12 h-[80vh] overflow-hidden rounded-lg lg:flex-row">
      <div className="lg:w-1/3 lg:min-w-fit w-0 min-w-0">
        <List
          current={pageNo
          ->Belt_Option.getWithDefault("")
          ->Belt_Int.fromString
          ->Belt_Option.getWithDefault(1)}
          onPageChange={(~pageNo) =>
            handleRouteChange({pageNo: Some(pageNo->Belt_Int.toString), pokemonId: pokemonId})}
          data={list->Belt.Option.flatMap(item => item.pokemons)}
          error=listError
          dataKey={(~item) => {item->Belt_Option.mapWithDefault("id", item => item.id)}}
          render={(~item, ~itemIndex as _i) => {
            switch item {
            | Some(item) =>
              <Card
                selected={pokemonId->Belt.Option.getWithDefault("") === item.id}
                onClick={_ => handleRouteChange({pokemonId: Some(item.id), pageNo: pageNo})}
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
          onChange={(~item) => handleRouteChange({pokemonId: Some(item.id), pageNo: pageNo})}
        />
      </div>
    </div>
  </div>
}
