export class InitGraph {
  async create_graph(driver) {
    let { records, summary } = await driver.executeQuery(`
      CREATE (x:Person {name: $name})
      CREATE (y:Person {name: $friendName})
      CREATE (x)-[:KNOWS]->(y)
    `,
      { name: 'John', friendName: 'Smith' },
      { database: 'neo4j' }
    )
    console.log(
      `Created ${summary.counters.updates().nodesCreated} nodes ` +
      `in ${summary.resultAvailableAfter} ms.`
    )
  }
}