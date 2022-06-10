ReactDOM.render(
  <React.StrictMode>
    <ApolloClient.React.ApolloProvider client=Utils.apolloClient>
      <App />
    </ApolloClient.React.ApolloProvider>
  </React.StrictMode>,
  ReactDOM.querySelector("#root")->Belt.Option.getExn,
)
