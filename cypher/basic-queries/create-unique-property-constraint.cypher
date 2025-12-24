//# Create unique property constraint
//# 'ConstraintName' with name of index (optional) 
//# 'LabelName' with label to index
//# 'propertyKey' with property to be indexed

CREATE CONSTRAINT [ConstraintName]
FOR (c:<LabelName>)
REQUIRE n.<propertyKey> IS UNIQUE