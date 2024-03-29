if (module.hot) {
  module.hot.accept();
  module.hot.dispose(() => server.stop());
}

const { ApolloServer } = require("apollo-server-express");
import mongoose from "mongoose";
import { initializeSequences } from "./startup";
const express = require("express");
const cors = require("cors");

var ApiRoute = require("./route");

const gqlScalarSchema = require("./modules/gql-scalar");
const userSchema = require("./modules/user");

const databaseUri = process.env.MONGODB_URI || "mongodb://127.0.0.1:27017";

mongoose.connect(databaseUri, {
});
mongoose.pluralize(undefined);

const app = express();

const server = new ApolloServer({
  typeDefs: [gqlScalarSchema.typeDefs, userSchema.typeDefs],
  resolvers: [gqlScalarSchema.resolvers, userSchema.resolvers],
  context: ({ req, res }: any) => {
    const userId = req.headers.authorization || "";
    return { userId };
  },
  introspection: true,
  playground: true,
});

server.start().then(() => server.applyMiddleware({ app }))

app.use(cors());

app.use(express.json({ limit: 5000000 }));
app.use(
  express.urlencoded({
    extended: true,
  })
);
app.use("/api", ApiRoute);

app.use((_: any, res: any) => {
  res.status(404);
  res.send("Not found");
  res.end();
});

app.listen({ port: process.env.PORT || 4000 }, () =>
  console.log(
    `🚀 Server ready at http://localhost:${process.env.PORT || 4000}${server.graphqlPath
    }`
  )
);

// server
//   .listen({ port: process.env.PORT || 4000 })
//   .then(({ url }: any) => console.log(`Server started at ${url}`));

// Server startup scripts
initializeSequences();
