MATCH
  (m:Manufacturer {manfacturerName: "TAKEDA"})-[:REGISTERED]->
  (c:Case)-[:HAS_REACTION]->
  (r:Reaction)
RETURN r.description AS reaction, count(r) AS totalReactions
ORDER BY totalReactions DESC;

//# results in graph
MATCH
  (m:Manufacturer {manfacturerName: "TAKEDA"})-[reg:REGISTERED]->
  (c:Case)-[h:HAS_REACTION]->
  (r:Reaction)
RETURN m, reg, c, h, r

//# using `WHERE` clause
MATCH (m:Manufacturer)-[:REGISTERED]->(c:Case)-[:HAS_REACTION]->(r:Reaction)
WHERE m.manfacturerName = "TAKEDA"
RETURN r.description AS reaction, count(r) AS totalReactions
ORDER BY totalReactions DESC

//# challenge: find the reactions that have been reported for every drug
MATCH (d:Drug)<-[:IS_PRIMARY_SUSPECT]-(c:Case)-[:HAS_REACTION]->(r:Reaction)
RETURN r.description AS reaction, d.name AS drug

//# challenge: result in graph
MATCH (d:Drug)<-[is:IS_PRIMARY_SUSPECT]-(c:Case)-[h:HAS_REACTION]->(r:Reaction)
RETURN d, is, c, h, r

//# challenge-2: write down query that can only return the reactions that have been reported for the drug "CUVTIRU"
MATCH (d:DRUG)<-[:IS_PRIMARY_SUSPECT]-(c:Case)-[:HAS_REACTION]->(r:Reaction)
WHERE d.name = "CUVITRU"
RETURN r.description AS reaction

//# challenge-2: result in graph
MATCH (d:Drug)<-[is:IS_PRIMARY_SUSPECT]-(c:Case)-[h:HAS_REACTION]->(r:Reaction)
WHERE d.name = "CUVITRU"
RETURN d, is, c, h, r