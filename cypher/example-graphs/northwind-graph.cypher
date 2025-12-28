//# Nortwind Graph
//# From RDBMS to Graph, using a classic dataset
/*
The Northwind Graph demonstrates how to migrate from a relational database to Neo4j. 
The transformation is iterative and deliberate, emphasizing the conceptual shift from relational
tables to the nodes  and relationships of a graph.

This guide will show you how to:
- Load: create data from external CSV files
- Index: index nodes based on label
- Relate: transform foreign key references into data relationships
- Promote: transform join records into relationships
*/
//# 2/7
//# Product Catalog
/*
Northwind sells food products in a few categories, provided by suppliers. Let's start by 
loading the product catalog tables.

The load statements to the right require public internet access. 
"LOAD CSV" will retrieve a CSV file from a valid URL, applying a cypher statement to each row 
using a named map (here we're using the name `row`,, look at the picture in `northwind-resources/` folder)
*/
// Load CSV - Product data and create Product node
LOAD CSV WITH HEADERS FROM "https://data.neo4j.com/northwind/products.csv" AS row
CREATE (n:Product)
SET
  n = row,
  n.unitPrice = toFloat(row.unitPrice),
  n.unitsInStock = toInteger(row.unitsInStock),
  n.unitsOnOrder = toInteger(row.unitsOnOrder),
  n.reorderLevel = toInteger(row.reorderLevel),
  n.discontinued = (row.discontinued <> "0")

// Load CSV - Categories data
LOAD CSV WITH HEADERS FROM "https://data.neo4j.com/northwind/categories.csv" AS row
CREATE (n:Category)
SET n = row

// Load CSV - Supplier data
LOAD CSV WITH HEADERS FROM "https://data.neo4j.com/northwind/suppliers.csv" AS row
CREATE (n:Supplier)
SET n = row


// Create Indexes
CREATE INDEX FOR (p:Product) ON (p.productID)

CREATE INDEX FOR (p:Product) ON (p.productName)

CREATE INDEX FOR (c:Category) ON (c.categoryID)

CREATE INDEX FOR (s:Supplier) ON (s.supplierID)


//# # # # # # # # # # # # #
//# 3/7
//# Product Catalog Graph
/*
The products, categories and suppliers are related throug
foreign key references. Let's promote those to data relationships
to realize the graph.
*/

//# Create data relationships
MATCH (p:Product), (c:Category)
WHERE p.categoryID = c.categoryID
CREATE (p)-[:PART_OF]->(c)

//# Note you only need to compare property values 
//# like this when first creating relationships.
//# Calculate join, materialize relationship. See http://neo4j.com/developer/guide-importing-data-and-etl ... for more details

MATCH (p:Product),(s:Supplier)
WHERE p.supplierID = s.supplierID
CREATE (s)-[:SUPPLIES]->(p)

//# Note you only need to compare property values like this when first creating relationships
