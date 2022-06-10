let apolloClient = {
  ApolloClient.make(
    ~cache=ApolloClient.Cache.InMemoryCache.make(),
    ~connectToDevTools=true,
    ~uri=_ => "https://graphql-pokemon2.vercel.app/",
    (),
  )
}
