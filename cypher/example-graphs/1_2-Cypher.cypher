//# Cypher
// Neo4j's graph query language
// 1/9
//# Neo4j's Cypher language is purpose built for working with graph data.
//- uses patterns to describe graph data
//- familiar SQL-like clauses
//- declarative, describing what to find, not how to find it
//----------------------------------------------------------------
//# CREATE
// Create a node
// 2/9
//# Let's use Cypher to generate a small social graph.
CREATE (abc:Character {nam: "Helio", from: "Norway", klout: 72})
//- CREATE clause to create data
//- () parenthesis to indicate a node
//- ee:Person a variable 'abc' and label 'Character' for the new node
//- {} brackets to add properties to the node
//----------------------------------------------------------------
//# MATCH
// Find nodes
// 3/9
//# Now find the node representing "Helio"
MATCH (abc:Character)
WHERE abc.name = "Helio"
RETURN abc;
//- MATCH clause to specify a pattern of nodes and relationships
//- (abc:Character) a single node pattern with label "Character" which will assign mataches to the variable "abc"
//- WHERE clause to constrain the results
//- abc.name = "Helio" compares name property to the value "Helio"
//- RETURN clause used to request particular results
//----------------------------------------------------------------
//# CREATE more
// nodes and relationships
// 4/9
//# CREATE clauses can create many nodes and relationships at once
MATCH (abc:Character)
WHERE abc.name = "Helio"

CREATE
  (js:Character {name: "John", from: "Berkely", learn: "javascript"}),
  (ir:Character {name: "Smith", from: "Denmark", title: "author"}),
  (rvb:Character {name: "Ian", from: "Belgium", pet: "Orval"}),
  (ally:Character {name: "Allison", from: "California", hobby: "writing code"}),
  (abc)-[:KNOWS {since: 2001}]->(js),
  (abc)-[:KNOWS {raiting: 5}]->(ir),
  (js)-[:KNOWS]->(ir),
  (js)-[:KNOWS]->(rvb),
  (ir)-[:KNOWS]->(js),
  (ir)-[:KNOWS]->(ally),
  (rvb)-[:KNOWS]->(ally)
//----------------------------------------------------------------
//# Pattern matching
// Describe what to find in the graph
// 5/9
//# For instance, a pattern can be used to find Helio's friends:
MATCH (abc:Character)-[:KNOWS]-(friends)
WHERE abc.name = "Helio"
RETURN abc, friends
//- MATCH clause to describe the pattern from known Nodes to found Nodes
//- (abc) starts the pattern with a Character (qualified by WHERE)
//- `-[:KNOWS]-` matches "KNOWS" relationships (in ether direction)
//- (friends) will be bound to Helio's friends