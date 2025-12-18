//# We can use multiple match patterns to bring additional information
//# into the results
//# in the example, the query uses the `IS_PRIMARY_SUSPECT` relationship to find `Drug`
//# that is the primary suspect for the `Case`
//# Which drugs resulted in the most reactions?
MATCH (m:Manufacturer)-[:REGISTERED]->(c:Case)-[:HAS_REACTION]->(r:Reaction)
MATCH (c)-[:IS_PRIMARY_SUSPECT]->(d:Drug)
RETURN
  m.manufacturerName AS company,
  d.name AS drug,
  collect(DISTINCT r.description) AS reactions,
  count(DISTINCT r) AS totalReactions
ORDER BY totalReactions DESC;

//# To see the result in graph
MATCH (m:Manufacturer)-[reg:REGISTERED]->(c:Case)-[h:HAS_REACTION]->(r:Reaction)
MATCH (c)-[is:IS_PRIMARY_SUSPECT]->(d:Drug)
RETURN m, reg, c, h, r, is, d