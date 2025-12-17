//# By using REGISTERED relationship
//# we can find connections between Manufacturer and the Case nodes
MATCH (m:Manufacturer)-[r:REGISTERED]->(c:Case)
RETURN m, r, c