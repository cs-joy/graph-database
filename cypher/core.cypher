//# Cypher
// A graph query language
//# Cypher is Neo4j's graph query language. Working with a graph is all about understanding patterns of data,
//# which are central to Cypher queries.
//# Use 'MATCH' clauses for reading data, and
//# 'CREATE' or 'MERGE' for writing data
// Documentation[Cypher Introduction]: https://neo4j.com/docs/cypher-manual/5.26/
//////// Related:::::
//- MATCH
// Describe a data pattern
// The `MATCH` clause describes a pattern of graph data. Neo4j will collect all paths within the graph
// which match this pattens. This is often used with `WHERE` to filter the collection.
// The `MATCH` describes the structure, and `WHERE` specifies the content of a query.
// Reference MATCH manual page: https://neo4j.com/docs/cypher-manual/5/clauses/match/
// Find all the many fine films directed by Steven Spielberg.
MATCH (director:Person)-[:DIRECTRED]->(movie)
WHERE director.name = "Steven Speilberg"
RETURN movie.title

// based on the manual: https://neo4j.com/docs/cypher-manual/5/clauses/match/
CREATE
  (mra:Person:Actor {name: 'Mr.a'}),
  (mrb:Person:Actor {name: 'Mr.b'}),
  (mrc:Person:Actor {name: 'Mr.c'}),
  (mrd:Person:Author {name: 'Mrd'}),
  (mre:Person:Author {name: 'Mre'}),
  (helloworld:Novel {title: 'Hello World'}),
  (mra)-[:ACTED_IN {role: 'hero'}]->(helloworld),
  (mrb)-[:ACTED_IN {role: 'villain'}]->(helloworld),
  (mrc)-[:ACTED_IN {role: 'joker'}]->(helloworld),
  (mrd)-[:DIRECTED]->(helloworld),
  (helloneo4js:Novel {title: 'Hello Neo4js'}),
  (mrb)-[:ACTED_IN {role: 'parents'}]->(helloneo4js),
  (mrc)-[:ACTED_IN {role: 'hero'}]->(helloneo4js),
  (mre)-[:DIRECTED]->(helloneo4js)

// Find pattern - MATCH
// let's say, find all the actor's name
// output as a list of actor name
MATCH (n:Person:Actor)
RETURN n.name

// output as a graph
MATCH (n:Person:Actor)
RETURN n

// MATCH using node label expressions
//# Node pattern using the `OR(|)` label expression
MATCH (n:Actor|Novel)
RETURN n.name, AS name, n.title AS title

// Node pattern using negation(!) label expression
MATCH (n:!Novel)
RETURN labels(n) AS label, count(n) AS labelCount

//# Relationship
// Empty relationship patterns
// Find connected nodes using an empty relationship pattern
MATCH (:Person {name: 'Mr.a'})--(n)
RETURN n AS connectedNodes

// Mr.b acted which movies?
MATCH (:Person {name: 'Mr.b'})--(n)
RETURN n AS connectedNodes

// result in a graph - all actors whol acted in the individual novels
MATCH (person:Person:Actor)-[ai:ACTED_IN]->(novel:Novel)
RETURN person, ai, novel

//# WHERE
// Filter results
// The WHERE clause imposes conditions on the data within a potentially matching path,
// filtering the result set of a MATCH
// MATCH describes the structure, and WHERE specifies the content of a query.
// Ref: Manual page: [WHERE] https://neo4j.com/docs/cypher-manual/5/clauses/where/
MATCH (author:Person)-[:DIRECTED]->(movie)
WHERE author.name = "Mr. d"
RETURN movie.title

//# Example graph
CREATE
  (processor:Motherboard:Computer
    {name: 'cpu', type: 'Primary', price: '336.21'}),
  (mouse:Computer {name: 'Mouse', type: 'Secondary', price: 45.11}),
  (keyboard:Computer {name: 'Keyboard', type: 'Primary', price: 23.45}),
  (printer:Computer {name: 'Printer', type: 'Secondary', price: 183.4329}),
  (monitor:Computer {name: 'Monitor', type: 'Secondary', price: 174.324}),
  (ram:Computer {name: 'RAM', type: 'Primary', price: 234.92}),
  (smp:Computer {name: 'PowerSupply', type: 'Primary', price: 734.27}),
  (ssd:Computer {name: 'Solid State Drive', type: 'Primary', price: 356.12}),
  (processor)-[:SYSTEM {since: 1970}]->(ram),
  (processor)-[:SYSTEM {since: 1971}]->(ssd),
  (processor)-[:SYSTEM {since: 1972}]->(smp),
  (smp)-[:KNOWS {since: 1973}]->(monitor),
  (monitor)-[:KNOWS {since: 1974}]->(keyboard),
  (monitor)-[:KNOWS {since: 1974}]->(mouse),
  (monitor)-[:KNOWS {since: 1975}]->(printer)

MATCH (components:Computer)-[:KNOWS]->(comp)
WHERE comp.type = "Primary"
RETURN comp

// find out a component of motherboard
MATCH (n)
WHERE n:Motherboard
RETURN n.name

// filter on a node property
MATCH (n:Computer)
WHERE n.price >= 100
RETURN n.name AS Components, n.price AS Price

// filter on a relationship property
MATCH (:Computer)-[s:SYSTEM]->(f)
WHERE s.since >= 1970
RETURN f.name AS rComponent

// filter on dynamically computed node property
// first set your parameter
:param
{
  "valname": 'price'
}

// then 
MATCH (n:Computer)
WHERE n[$valname] > 150
RETURN n.name AS Name, n.type AS Type, n.price AS Price

