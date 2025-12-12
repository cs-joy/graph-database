from config import driver

def example_graph_init():
    summary = driver.execute_query(
        """
            CREATE (a:Person {name: $name})
            CREATE (b:Person {name: $friendName})
            CREATE (a)-[:KNOWS]->(b)
        """,
        name="Sami", friendName="Zahangir",
        database_="neo4j",
    ).summary
    
    print("Created {nodes_created} nodes in {time} ms.".format(
        nodes_created=summary.counters.nodes_created,
        time=summary.result_available_after
    ))
