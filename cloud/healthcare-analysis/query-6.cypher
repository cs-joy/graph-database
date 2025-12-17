//# query can match on multiple patterns.
//# we can use the `HAS_REACTION` relationship
//# to finds the reactions for each case registered by manufacturer.
MATCH (m:Manufacturer)-[r:REGISTERED]->(c:Case)-[h:HAS_REACTION]->(re:Reaction)
RETURN m, r, c, h, re