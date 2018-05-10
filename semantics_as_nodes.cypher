CREATE (ic1:ConsistencyCheck { ccid:1,
		ccname: "DTP_DOMAIN",
		cccypher: "MATCH (n:Class)<-[:DOMAIN]-(p:DatatypeProperty) 
				WITH DISTINCT n.uri as classUri, n.label as classLabel, p.uri as prop, p.label as propLabel
				MATCH (x) WHERE  x[propLabel] IS NOT NULL AND NOT classLabel IN labels(x)
				RETURN  id(x) AS nodeUID, 
        			'domain of property ' + propLabel + ' [' + prop + ']' AS `check failed`,  
					'Node labels: (' + reduce(s = '', l IN Labels(x) | s + ' ' + l) + ') should include ' + classLabel AS extraInfo"})
		
CREATE (ic2:ConsistencyCheck { ccid:2,
		ccname: "OP_DOMAIN",
		cccypher: "MATCH (n:Class)<-[:DOMAIN]-(p:ObjectProperty) 
			WITH  n.uri as class, n.label as classLabel, p.uri as prop, p.label as propLabel
			MATCH (x)-[r]->() WHERE type(r)=propLabel AND NOT classLabel in Labels(x)
			RETURN  id(x) AS nodeUID, 
        		'domain of ' + propLabel + ' [' + prop + ']' AS `check failed`,  
				'Node labels: (' + reduce(s = '', l IN Labels(x) | s + ' ' + l) + ') should include ' + classLabel AS extraInfo	"})
		
CREATE (ic3:ConsistencyCheck { ccid:3,
		ccname: "OP_RANGE",
		cccypher: "MATCH (n:Class)<-[:RANGE]-(p:ObjectProperty) 
			WITH  n.uri as class, n.label as classLabel, p.uri as prop, p.label as propLabel
			MATCH ()-[r]->(x) WHERE type(r)=propLabel AND NOT classLabel in Labels(x)
			RETURN  id(x) AS nodeUID, 
			        'domain of ' + propLabel + ' [' + prop + ']' AS `check failed`,  
					'Node labels: (' + reduce(s = '', l IN Labels(x) | s + ' ' + l) + ') should include ' + classLabel AS extraInfo"})		
		
CREATE (ic4:ConsistencyCheck { ccid:4,
		ccname: "DTP_ON_OP_DOMAIN",
		cccypher: "MATCH (r:ObjectProperty)<-[:DOMAIN]-(p:DatatypeProperty) 
			WITH  r.uri as rel, r.label as relLabel, p.uri as prop, p.label as propLabel
			MATCH ()-[r]->() WHERE r[propLabel] IS NOT NULL  AND relLabel<>type(r)
			RETURN  id(r) AS relUID, 
			        'domain of ' + propLabel + ' [' + prop + ']' AS `check failed`,  
					'Rel type: ' + type(r) + ' but should be ' + relLabel AS extraInfo"})		