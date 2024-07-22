import { createApp, provide, h } from "vue";
import {
  ApolloClient,
  createHttpLink,
  InMemoryCache,
} from "@apollo/client/core";
import { DefaultApolloClient } from "@vue/apollo-composable";
import "./style.css";
import App from "./App.vue";

const httpLink = createHttpLink({
  uri: "https://api.8base.com/clx9w3sgi00040ala9qhn92kh/",
});

const cache = new InMemoryCache();

const apolloClient = new ApolloClient({
  link: httpLink,
  cache,
  headers: {
    "Content-Type": "application/json",
    authorization: `Bearer 34ada67c-aa0c-4694-b5f8-02b79d99ce2a`,
  },
});

const app = createApp({
  setup() {
    provide(DefaultApolloClient, apolloClient);
  },

  render: () => h(App),
});

app.mount("#app");