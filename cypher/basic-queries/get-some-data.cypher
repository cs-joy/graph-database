//# Get some data
MATCH (n1)-[r]->(n2)
RETURN r, n1, n2
LIMIT 2