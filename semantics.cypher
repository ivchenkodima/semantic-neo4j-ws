//General RDFS/OWL style semantics

// DatatypeProperty domain semantics meta-rule
MATCH (n:Class)<-[:DOMAIN]-(p:DatatypeProperty) 
WITH DISTINCT n.uri as classUri, n.label as classLabel, p.uri as prop, p.label as propLabel
MATCH (x) WHERE  x[propLabel] IS NOT NULL AND NOT classLabel IN labels(x)
RETURN  id(x) AS nodeUID, 
        'domain of ' + propLabel + ' [' + prop + ']' AS `check failed`,  
		'Node labels: (' + reduce(s = '', l IN Labels(x) | s + ' ' + l) + ') should include ' + classLabel AS extraInfo
		

// ObjectProperty domain semantics meta-rule
MATCH (n:Class)<-[:DOMAIN]-(p:ObjectProperty) 
WITH  n.uri as class, n.label as classLabel, p.uri as prop, p.label as propLabel
MATCH (x)-[r]->() WHERE type(r)=propLabel AND NOT classLabel in Labels(x)
RETURN  id(x) AS nodeUID, 
        'domain of ' + propLabel + ' [' + prop + ']' AS `check failed`,  
		'Node labels: (' + reduce(s = '', l IN Labels(x) | s + ' ' + l) + ') should include ' + classLabel AS extraInfo		


// ObjectProperty range semantics meta-rule
MATCH (n:Class)<-[:RANGE]-(p:ObjectProperty) 
WITH  n.uri as class, n.label as classLabel, p.uri as prop, p.label as propLabel
MATCH ()-[r]->(x) WHERE type(r)=propLabel AND NOT classLabel in Labels(x)
RETURN  id(x) AS nodeUID, 
        'domain of ' + propLabel + ' [' + prop + ']' AS `check failed`,  
		'Node labels: (' + reduce(s = "", l IN Labels(x) | s + ' ' + l) + ') should include ' + classLabel AS extraInfo

		
// DatatypeProperties on ObjectProperty domain semantics meta-rule (property graph specific. attributes on relationships)
MATCH (r:ObjectProperty)<-[:DOMAIN]-(p:DatatypeProperty) 
WITH  r.uri as rel, r.label as relLabel, p.uri as prop, p.label as propLabel
MATCH ()-[r]->() WHERE r[propLabel] IS NOT NULL  AND relLabel<>type(r)
RETURN  id(r) AS relUID, 
        'domain of ' + propLabel + ' [' + prop + ']' AS `check failed`,  
		'Rel type: ' + type(r) + ' but should be ' + relLabel AS extraInfo		