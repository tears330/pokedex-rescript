ReactDOM.render(
  <React.StrictMode>
    <ApolloClient.React.ApolloProvider client=Apollo.client>
      <App />
    </ApolloClient.React.ApolloProvider>
  </React.StrictMode>,
  ReactDOM.querySelector("#root")->Belt.Option.getExn,
)
