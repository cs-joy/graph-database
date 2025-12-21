//# Cases by Report Source
MATCH (rs:ReportSource)<-[rb:REPORTED_BY]-(c:Case)
RETURN rs.name AS source, count(c) AS cases
ORDER BY cases DESC

//# graph result
MATCH (rs:ReportSource)<-[rb:REPORTED_BY]-(c:Case)
WHERE rs.name <> "Healthcare Professional"
//# '<>' is means no-eqaulity in cypher, in other language, "!="
RETURN rs, rb, c

//# query for count the cases for just Consumer
MATCH (rs:ReportSource {name: "Consumer"})<-[rb:REPORTED_BY]-(c:Case)
RETURN rs.name AS source, count(c) AS cases
ORDER BY cases DESC

//# graph result
MATCH (rs:ReportSource {name: "Consumer"})<-[rb:REPORTED_BY]-(c:Case)
RETURN rs, rb, c

//# Challenge
// Return the number of reactions reported by the Consumer
MATCH
  (rs:ReportSource {name: "Consumer"})<-[rb:REPORTED_BY]-
  (c:Case)-[h:HAS_REACTION]->
  (r:Reaction)
RETURN r.description AS reaction, count(r) AS totalReactions
ORDER BY totalReactions DESC

// challenge
MATCH
  (rs:ReportSource {name: "Consumer"})<-[rb:REPORTED_BY]-
  (c:Case)-[h:HAS_REACTION]->
  (r:Reaction)
RETURN rs, rb, c, h, r