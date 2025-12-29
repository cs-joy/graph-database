//# 1/7
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


//# 4/7
//# Querying Product Catalog Graph
//# Let's try some queries using patterns.

//# Query using patterns - q1
//# List the product categories provided by each supplier
MATCH (s:Supplier)-->(:Product)-->(c:Category)
RETURN s.companyName as Company, collect(distinct c.categoryName) as Categories

// Graph result - q1.2
MATCH (s:Supplier)-->(p:Product)-->(c:Category)
RETURN s, p, c

// return supplier name, category and product - q1.3
MATCH (s:Supplier)-->(p:Product)-->(c:Category)
RETURN s.companyName as Company, collect(distinct c.categoryName) as Categories, collect(p.productName) as Products

//# Find the produce suppliers - q2
MATCH (c:Category {categoryName: "Produce"})<--(:Product)<--(s:Supplier)
RETURN DISTINCT s.companyName as ProduceSuppliers


//# 5/7
//# Customer Orders
//# Northwind customers place orders which may detail multiple products.

//# Load and index records
LOAD CSV WITH HEADERS FROM
"https://data.neo4j.com/northwind/customers.csv" AS row
CREATE (n: Customer)
SET n = row

LOAD CSV WITH HEADERS FROM
"https://data.neo4j.com/northwind/orders.csv" AS row
CREATE (n:Order)
SET n = row

CREATE INDEX FOR (n:Customer) ON (n.customerID)

CREATE INDEX FOR (o:Order) ON (o.orderID)

//# Create data relationships
MATCH (c:Customer),(o:Order)
WHERE c.customerID = o.customerID
CREATE (c)-[:PURCHASED]->(o)
// Note you only need to compare property values like this when first creating relationships


//# 6/7
//# Customer Order Graph
//# Notice that Order Details are part of an Order and that they relate
//# the Order to a Product - they're a join table Join tables are always
//# a sign of a data relationship, indicating  shared information between two other records.

//# Here, we'll directly promote each OrderDetail record into a relationship in the graph,, see "order-graph.png"

//# Load and index records
LOAD CSV WITH HEADERS FROM
"https://data.neo4j.com/northwind/order-details.csv" AS row
MATCH (p:Product),(o:Order)
WHERE p.productID = row.productID AND o.orderID = row.orderID
CREATE (o)-[details:ORDERS]->(p)
SET details = row,
details.quantity = toInteger(row.quantity)

//# Query using patterns
MATCH (cust:Customer)-[:PURCHASED]->(:Order)-[o:ORDERS]->(p:Product),
(p)-[:PART_OF]->(c:Category{categoryName: "Produce"})
RETURN DISTINCT cust.contactName as CustomerName,
SUM(o.quantity) AS TotalProductsPurchased

// graph
MATCH (cust:Customer)-[pur:PURCHASED]->(or:Order)-[o:ORDERS]->(p:Product),
(p)-[pa:PART_OF]->(c:Category{categoryName:"Produce"})
RETURN cust, pur, or, o, p, pa,c




