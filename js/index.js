import { InitGraph } from "./init_graph.js";
import { QueryData } from "./query.js";
import neo4j from 'neo4j-driver';

(async () => {
    // URI examples: 'neo4j://localhost', 'neo4j+s://xxx.databases.neo4j.io'
    const URI = 'neo4j://localhost:7999'
    const USER = 'neo4j'
    const PASSWORD = 'password'
    let driver = neo4j.driver(URI, neo4j.auth.basic(USER, PASSWORD))
    const serverInfo = await driver.getServerInfo()
    console.log('Connection established')
    console.log(serverInfo)

    // Use the driver to run queries

    console.log("Creating Graph...");
    const inst = new InitGraph();
    inst.create_graph(driver);

    console.log('Query...');
    const qdata = new QueryData();
    qdata.exp_data(driver);


    await driver.close()
})();
