from config import driver

def query():
    records, summary, keys = driver.execute_query(
        """
            MATCH (p:Person)-[:KNOWS]->(:Person)
            RETURN p.name AS name
        """,
        database_="neo4j",
    )

    # Loop through results and do something with them
    for record in records:
        print(record.data())  # obtain record as dict

    # Summary information
    print("The query `{query}` returned {records_count} records in {time} ms.".format(
        query=summary.query, records_count=len(records),
        time=summary.result_available_after
    ))

    