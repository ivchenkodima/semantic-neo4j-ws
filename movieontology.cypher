// Movie DB Ontology 

CREATE 


//CLASSES (Neo4j's Labels)

(person_class:Class {	uri:"http://neo4j.com/voc/movies#Person", 
			label:"Person", 
			comment:"Individual involved in the film industry"}),

(movie_class:Class {	uri:"http://neo4j.com/voc/movies#Movie", 
			label:"Movie", 
			comment:"A film"}),


//DATATYPE PROPERTIES (Neo4j's node properties)

(name_dtp:DatatypeProperty {	uri:"http://neo4j.com/voc/movies#name", 
				label:"name",
				comment :"A person's name"}),
(name_dtp)-[:DOMAIN]->(person_class),

(born_dtp:DatatypeProperty {	uri:"http://neo4j.com/voc/movies#born", 
				label:"born", 
				comment :"A person's date of birth"}),
(born_dtp)-[:DOMAIN]->(person_class),

(title_dtp:DatatypeProperty { 	uri:"http://neo4j.com/voc/movies#title", 
				label:"title", 
				comment :"The title of a film"}),
(title_dtp)-[:DOMAIN]->(movie_class),

(released_dtp:DatatypeProperty {	uri:"http://neo4j.com/voc/movies#released", 
					label:"released", 
					comment :"A film's release date"}),
(released_dtp)-[:DOMAIN]->(movie_class),

(tagline_dtp:DatatypeProperty {	uri:"http://neo4j.com/voc/movies#tagline", 
				label:"tagline", 
				comment :"Tagline for a film"}),
(tagline_dtp)-[:DOMAIN]->(movie_class),


//ObjectProperties (Neo4j's relationships)

(actedin_op:ObjectProperty { 	uri:"http://neo4j.com/voc/movies#ACTED_IN", 
				label:"ACTED_IN", 
				comment:"Actor had a role in film"}),
(person_class)<-[:DOMAIN]-(actedin_op)-[:RANGE]->(movie_class),

(directed_op:ObjectProperty {	uri:"http://neo4j.com/voc/movies#DIRECTED", 
				label:"DIRECTED", 
				comment:"Director directed film"}),
(person_class)<-[:DOMAIN]-(directed_op)-[:RANGE]->(movie_class),

(produced_op:ObjectProperty {	uri:"http://neo4j.com/voc/movies#PRODUCED", 
				label:"PRODUCED", 
				comment:"Producer produced film"}),
(person_class)<-[:DOMAIN]-(produced_op)-[:RANGE]->(movie_class),

(reviewed_op:ObjectProperty {	uri:"http://neo4j.com/voc/movies#REVIEWED", 
				label:"REVIEWED", 
				comment:"Critic reviewed film"}),
(person_class)<-[:DOMAIN]-(reviewed_op)-[:RANGE]->(movie_class),

(follows_op:ObjectProperty {	uri:"http://neo4j.com/voc/movies#FOLLOWS", 
				label:"FOLLOWS", 
				comment:"Critic follows another critic"}),
(person_class)<-[:DOMAIN]-(follows_op)-[:RANGE]->(person_class),

(wrote_op:ObjectProperty {	uri:"http://neo4j.com/voc/movies#WROTE", 
				label:"WROTE", 
				comment:"screenwriter wrote screenplay of"}),
(person_class)<-[:DOMAIN]-(wrote_op)-[:RANGE]->(movie_class),


//DatatypeProperties on ObjectProperties (Neo4j's relationship properties)

(roles_dtp:DatatypeProperty {	uri:"http://neo4j.com/voc/movies#roles", 
				label:"roles", 
				comment :"characters played by an actor in a movie"}),
(roles_dtp)-[:DOMAIN]->(actedin_op),

(summary_dtp:DatatypeProperty {	uri:"http://neo4j.com/voc/movies#summary", 
				label:"summary", 
				comment :"summary of the review"}),
(summary_dtp)-[:DOMAIN]->(reviewed_op),

(rating_dtp:DatatypeProperty {	uri:"http://neo4j.com/voc/movies#rating", 
				label:"rating", 
				comment :"film rating (0 to 100)"}),
(rating_dtp)-[:DOMAIN]->(reviewed_op)
