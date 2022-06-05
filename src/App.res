@module("./logo.svg") external logo: string = "default"
%%raw(`import './App.css'`)

@react.component
let make = () => {
  let (count, setCount) = React.useState(() => 0)

  <div className="App">
    <header
      className="App-header w-full h-full flex flex-col justify-center items-center space-y-4">
      <img src={logo} className="App-logo" alt="logo" />
      <p> {"Hello Vite + React + ReScript!"->React.string} </p>
      <p>
        <button
          className="bg-black text-white rounded-lg p-4"
          onClick={_e => setCount(count => count + 1)}>
          {`count is: ${count->Belt.Int.toString}`->React.string}
        </button>
      </p>
      <p>
        {"Edit "->React.string}
        <code> {"App.res"->React.string} </code>
        {" and save to test HMR updates."->React.string}
      </p>
      <p>
        <a
          className="App-link" href="https://reactjs.org" target="_blank" rel="noopener noreferrer">
          {"Learn React"->React.string}
        </a>
        {" | "->React.string}
        <a
          className="App-link"
          href="https://vitejs.dev/guide/features.html"
          target="_blank"
          rel="noopener noreferrer">
          {"Vite Docs"->React.string}
        </a>
        {" | "->React.string}
        <a
          className="App-link"
          href="https://rescript-lang.org/docs/react/latest/introduction"
          target="_blank"
          rel="noopener noreferrer">
          {"ReScript Docs"->React.string}
        </a>
      </p>
      <Card
        highlight="003"
        title="Pokemon!"
        selected={false}
        img="https://img.pokemondb.net/artwork/bulbasaur.jpg"
      />
    </header>
  </div>
}
