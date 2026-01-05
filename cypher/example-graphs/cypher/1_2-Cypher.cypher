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
//----------------------------------------------------------------
//# Recommend
// Using patterns
// 6/9
//# Pattern matching can be used to make recommendations. John is learning programming, so he may want to find a new friend who already does:
MATCH (js:Character)-[:KNOWS]-()-[:KNOWS]-(coder)
WHERE js.name = "Johan" AND coder.hobby = "writing code"
RETURN DISTINCT coder
//- () empty parenthesis to ignore these nodes
//- DISTINCT because more than onc path will match the pattern
//- surfer will contain Allison, a friend of a friend who write code
//----------------------------------------------------------------
//# Analyze
// Using the visual query plan
// 7/9
//# Understanding how your query works by prepending `EXPLAIN` or `PROFILE`:
PROFILE MATCH (js:Character)-[:KNOWS]-()-[:KNOWS]-(coder)
WHERE js.name = "John" AND coder.hobby = "writing code"
RETURN DISTINCT coder

EXPLAIN MATCH (js:Character)-[:KNOWS]-()-[:KNOWS]-(coder)
WHERE js.name = "John" AND coder.hobby = "writing code"
RETURN DISTINCT coder
//----------------------------------------------------------------
//# Live Cypher warnings
// Identify query problems in real time
// 8/9
//# As you type, the query editors notifies you about deprecated features and potentially expensive queries.
EXPLAIN MATCH (n),(m) RETURN n,m

//----------------------------------------------------------------
//# Next Steps
// Start your application using Cypher to create and query graph data.
// Use the REST API to monitor the database. In special cases, consider a plugin
// 9/9
//#- Help Cypher - Try more Cypher Sytax
//#- Documentation
//- Cypher Refcard - https://neo4j.com/docs/cypher-refcard/5.26/
//- The Cypher chapter of the Neo4j Developer Manual- https://neo4j.com/docs/cypher-manual/5.26/