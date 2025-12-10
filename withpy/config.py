from neo4j import GraphDatabase

# URI examples: "neo4j://localhost", "neo4j+s://xxx.databases.neo4j.io"
URI = "neo4j://localhost:7999"
AUTH = ("neo4j", "password")

driver = GraphDatabase.driver(URI, auth=AUTH)