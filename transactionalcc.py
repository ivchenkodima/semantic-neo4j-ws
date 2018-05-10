import sys
from py2neo import Graph

def executewithconsistencycheck(ccs, statement):
    res = 0
    tx = graph.cypher.begin()
    tx.append(statement)
    tx.process()
    for cc in ccs:
       tx.append(cc.cccypher)
       ccresults = tx.process()[-1]
       if (len(ccresults) > 0):
           tx.rollback()
           print 'Consistency Checks failed. Transaction rolled back\n', ccresults
           res = 1
           break   #break as soon as one check fails. 
    
    if (res == 0):
        tx.commit()
        print 'Consistency Checks passed. Transaction committed'


graph = Graph()
# cache the consistency check meta-rules
ccs = graph.cypher.execute("MATCH (cc:ConsistencyCheck) RETURN cc.ccid AS ccid, cc.ccname AS ccname, cc.cccypher AS cccypher")
# run a consistency safe transaction
res = executewithconsistencycheck(ccs, sys.argv[1])

