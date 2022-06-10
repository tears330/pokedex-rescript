open Belt.Option

@react.component
let make = (
  ~loading=false,
  ~data: option<Api.FetchPokemonDetail.t_pokemon>,
  ~onChange: (~item: Api.FetchPokemonDetail.t_pokemon_evolutions) => unit,
) => {
  let renderTagList = tagList =>
    tagList
    ->getWithDefault([])
    ->Belt_Array.map(type_ =>
      switch type_ {
      | Some(type_) =>
        <Tag
          key={type_}
          color={Constants.pokemon_color_map
          ->Belt_MapString.get(type_->Js_string2.toLowerCase)
          ->getWithDefault("#fff")}>
          {type_->React.string}
        </Tag>
      | None => React.null
      }
    )
    ->React.array

  let renderAttack = (attack: option<array<option<Api.t_pokemon_attack>>>) =>
    switch attack {
    | Some(fast) =>
      fast
      ->Belt_Array.map(item =>
        switch item {
        | Some(item) =>
          `${item.name->getWithDefault("")} - ${item.damage->getWithDefault(0)->Belt_Int.toString}`
        | None => ""
        }
      )
      ->Js_array2.joinWith(" / ")
      ->React.string
    | None => React.null
    }

  switch (loading, data) {
  | (true, _) =>
    <div className="h-full w-full flex justify-center items-center text-2xl text-dark-100">
      <Spin /> {"Loading"->React.string}
    </div>
  | (false, None) =>
    <div className="h-full w-full flex justify-center items-center text-2xl text-dark-100">
      {"Select a pokemon to see detail :)"->React.string}
    </div>
  | (false, Some(data)) =>
    <section className="flex flex-col max-h-full">
      <div className="flex justify-between p-10 border-b-2 border-dark-500">
        <h2 className="text-3xl font-bold text-white-800">
          {data.name->getWithDefault("")->React.string}
        </h2>
        <div className="text-3xl text-primary font-sans tracking-widest">
          {`#${data.number->getWithDefault("")}`->React.string}
        </div>
      </div>
      <div
        className="flex flex-col flex-1 items-center p-10 pt-5 overflow-y-auto max-h-full space-y-5">
        <div className="flex flex-col md:flex-row md:justify-between items-center w-full">
          <img
            className="rounded-lg shadow-dark-100 shadow-2xl w-[220px] h-[220px]"
            src={data.image->getWithDefault("")}
            alt={data.name->getWithDefault("")}
          />
          <Description>
            <Description.Item label="Type"> {data.types->renderTagList} </Description.Item>
            <Description.Item label="Classification">
              {data.classification->getWithDefault("")->React.string}
            </Description.Item>
            <Description.Item label="Height">
              {switch data.height {
              | Some(height) =>
                `${height.minimum->getWithDefault("")} ~ ${height.maximum->getWithDefault("")}`
              | None => ""
              }->React.string}
            </Description.Item>
            <Description.Item label="Weight">
              {switch data.weight {
              | Some(weight) =>
                `${weight.minimum->getWithDefault("")} ~ ${weight.maximum->getWithDefault("")}`
              | None => ""
              }->React.string}
            </Description.Item>
            <Description.Item label="Resistant"> {data.resistant->renderTagList} </Description.Item>
            <Description.Item label="Weakness"> {data.weaknesses->renderTagList} </Description.Item>
          </Description>
        </div>
        <Description title="Basic Info">
          {switch data.attacks {
          | Some(attacks) => <>
              <Description.Item label="Fast Attack">
                {attacks.fast->renderAttack}
              </Description.Item>
              <Description.Item label="Special Attack">
                {attacks.special->renderAttack}
              </Description.Item>
            </>
          | None => React.null
          }}
          <Description.Item label="MaxHP">
            {data.maxHP->getWithDefault(0)->Belt_Int.toString->React.string}
          </Description.Item>
          <Description.Item label="MaxCP">
            {data.maxCP->getWithDefault(0)->Belt_Int.toString->React.string}
          </Description.Item>
          <Description.Item label="Flee Rate">
            {`${(data.fleeRate->getWithDefault(0.) *. 100.)
              ->Belt_Float.toInt
              ->Belt_Int.toString}%`->React.string}
          </Description.Item>
        </Description>
        {switch data.evolutions {
        | Some(evolutions) =>
          <Description title="Evolution">
            <div className="flex items-center space-x-5">
              {evolutions
              ->Belt_Array.map(item =>
                switch item {
                | Some(item) =>
                  <div
                    className="flex flex-col justify-center items-center hover:bg-dark-200 p-2 cursor-pointer transition-colors rounded-md"
                    onClick={_ => onChange(~item)}
                    key={item.id}>
                    <img
                      className="rounded-lg shadow-dark-100 shadow-2xl w-[100px] h-[100px]"
                      alt={item.name->getWithDefault("")}
                      src={item.image->getWithDefault("")}
                    />
                    <span className="font-bold text-white-800">
                      {item.name->getWithDefault("")->React.string}
                    </span>
                    {switch data.evolutionRequirements {
                    | Some(evolutionRequirements) =>
                      <span className="text-white-800 text-sm">
                        {`${evolutionRequirements.name->getWithDefault(
                            "",
                          )} * ${evolutionRequirements.amount
                          ->getWithDefault(0)
                          ->Belt_Int.toString}`->React.string}
                      </span>
                    | None => React.null
                    }}
                  </div>
                | None => React.null
                }
              )
              ->React.array}
            </div>
          </Description>
        | None => React.null
        }}
      </div>
    </section>
  }
}
