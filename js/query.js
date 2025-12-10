export class QueryData {
    async exp_data(driver) {
        let { records, summary } = await driver.executeQuery(`
            MATCH (p:Person)-[:KNOWS]->(:Person)
            RETURN p.name AS name
        `,
            {},
            { database: 'neo4j' }
        )

        // Loop through users and do something with them
        for (let record of records) {
            console.log(`Person with name: ${record.get('name')}`)
            console.log(`Available properties for this node are: ${record.keys}\n`)
        }

        // Summary information
        console.log(
            `The query \`${summary.query.text}\` ` +
            `returned ${records.length} nodes.\n`
        )
    }
}