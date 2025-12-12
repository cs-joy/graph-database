//# Cypher 5
//# Step: 4/12
//# Side effects
//# Side effects are the reactions that a person develops after taking a drug
//# We can find the side effects using the `HAS_REACTION` relationship between the `Case` and `Reaction` nodes.
//# Cases and Reactions
MATCH (c:Case)-[h:HAS_REACTION]->(r:Reaction)
RETURN c, h, r

//# find `OUTCOME` of `CASE` using the `RESULTED_IN` relationship
MATCH (ca:Case)-[re:RESULTED_IN]->(o:Outcome)
RETURN ca, re, o

//# Step: 5/12
//# Aggregating results
//# In the previous section, we used Cypher to find the reactions for each case.
//# We can use the `count()` function to aggregate the results and finds the number of cases for each reactions.

//# Count Reactions
MATCH (c:Case)-[:HAS_REACTION]->(r:Reaction)
RETURN r.description, count(c)

//# By ordering the results, we can see the most commom reactions
//# Top Reactions
MATCH (c:Case)-[:HAS_REACTION]->(r:Reaction)
RETURN r.description, count(c)
ORDER BY count(c) DESC

//# We can see the top `n` reactions by adding a limit
MATCH (c:Case)-[:HAS_REACTION]->(r:Reaction)
RETURN r.description, count(c)
ORDER BY count(c) DESC
LIMIT 5

//# Next Section:
//# Find relationship between manufacturers, drugs and reactions
//# Manufacturers, Drugs and Reactions
//# By using the `REGISTERED` relationship , we can find connections between `Manufacturer` and `Case` nodes:

//# Cases by manufacturer
MATCH (m:Manufacturer)-[:REGISTERED]->(c:Case)
RETURN m.manufacturerName, count(c)
ORDER BY count(c) DESC

//# Queries can match on multiple patterns, We can use the `HAS_REACTION` relationship to find the reactions for each case registered by manufacturer
//# Reactions by Manufacturer
MATCH (m:Manufacturer)-[:REGISTERED]->(c:Case)-[:HAS_REACTION]->(r:Reaction)
RETURN m.manufacturerName, count(DISTINCT r)
ORDER BY count(DISTINCT r) DESC

//# Adding aliases makes the queries and results easier to read.
MATCH (m:Manufacturer)-[:REGISTERED]->(c:Case)->[:HAS_REACTION]->(r:Reaction)
RETURN m.manufacturerName as company, count(distinct r) as totalResponse
ORDER BY totalResponse DESC

//# We can use multiple match patterns to bring additional information into the results.


//# In this example, the query uses the `IS_PRIMARY_SUSPECT` relationship to find the `Drug` that is primary suspect for the `Case`.
//# Which drugs resulted in the most reactions
MATCH (m:Manufacturer)-[:REGISTERED]->(c:Case)-[:HAS_REACTION]->(r:Reaction)
MATCH (c)-[:IS_PRIMARY_SUSPECT]->(d:Drug)
RETURN m.manufacturerName as company, d.name as drug, count(distinct r) as totalReactions
ORDER BY totalReactions DESC

//# Using `collect()` to return a list
//# It would be useful to get the reactions reported for each drugs as well as the total number. We can use the `collect()` to return a list of reactions for each drugs.
MATCH (m:Manufacturer)-[:REGISTERED]->(c:Case)-[:HAS_REACTION]->(r:Reaction)
MATCH (c)-[:IS_PRIMARY_SUSPECT]->(d:Drug)
RETURN
    m.manufacturerName as company,
    d.name as drug,
    collect(distinct r.description) as reactions,
    count(distinct r) totalReactions
ORDER By totalReactions DESC;






