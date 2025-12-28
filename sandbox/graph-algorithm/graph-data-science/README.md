# Graph Data Science - GDS
`-1/29`
Traditional data science and machine learning applications have relied on creating knowledge and understanding using columnar data. Each row of data (or each data point) is treated as being independent of the others. However, there are many examples where considering existing relationships between each data point can create better models. Such examples, include:
- social network analysis
- recommender systems
- fraud detection
- search and
- question-answering bots

This guide will walk you through some of the common algorithms that can be used in graph data science. In this guide, we will introduce you to how to use Neo4j Graph Data Science (GDS) to solve some common data science problems using graphs.

# # Neo4j Graph Data Science
`-2/29`
Neo4j Graph Data Science (GDS) contains a set of graph algorithmsm exposed through Cypher procedures. Graph algorithms provide insights into the 
- graph structure and 
- elements 

for example, by
- computing centrality,
- similarity scores and
- detecting communities

This guide demonstrates the usual workflow for how to run production-tier algorithms. The generalized workflow is as follows:
- Create a graph projection
- Run a graph algorithm on a projection
- Show and interpret example results

The official GDS documentation can be found here: https://neo4j.com/docs/graph-data-science/current/?ref=gds-sandbox


# # Graph model: airplane routes
`-3/29`
We will be working with an example dataset that shows the connections between different airports across the world. Note that we have 5 differtent node labels:
- `Airport`
- `City`
- `Country`
- `Continent`
- `Region`

and 5 different relationship types:
- `:HAS_ROUTE`
- `:IN_CITY`
- `:IN_COUNTRY`
- `:IN_REGION` and
- `:ON_CONTINENT`

# # # # Attribution
This dataset was initially created by Kelvin Lawrence, available under the Apache License Version 2.0. The original dataset can be found in [this GitHub repository](https://github.com/krlawrence/graph) and has been modified for the purposes of this guide.