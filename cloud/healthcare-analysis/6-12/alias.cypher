//# Adding aliases makes the queries and results easier to read
MATCH (m:Manufacturer)-[:REGISTERED]->(c:Case)-[:HAS_REACTION]->(r:Reaction)
RETURN m.manufacturerName AS company, count(DISTINCT r) AS totalResponses
ORDER BY totalResponses DESC;