const Gremlin = require("gremlin");
const config = require("./config"); // Visit https://docs.microsoft.com/en-us/learn/modules/store-access-data-cosmos-graph-api/4-exercise-build-application-that-stores-graph-data-using-gremlin-api?pivots=javascript

if (process.argv.length < 3) {
  console.log("Please enter a Gremlin/Graph Query");
  return;
}

(async () => {
  const authenticator = new Gremlin.driver.auth.PlainTextSaslAuthenticator(
    `/dbs/${config.database}/colls/${config.collection}`,
    config.authKey
  );

  const client = new Gremlin.driver.Client(config.endpoint, {
    authenticator,
    traversalsource: "g",
    rejectUnauthorized: true,
    mimeType: "application/vnd.gremlin-v2.0+json"
  });

  try {
    const result = await client.submit(process.argv[2]);
    console.log(`{"Returned": "${result.length}"}`);

    for (const item of result._items) {
        console.log(JSON.stringify(item));
    }
    
  } catch (e) {
    console.error(e);
  } finally {
    await client.close();
  }
})();