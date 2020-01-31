#!/usr/bin/env python2
# coding=utf-8

from temporal_graph import *
import numpy

def calc(net_path, net_name, end_time):
    
    print("Start: " + net_name + " " + str(end_time))
      
    dadosIn = open(net_path, "r")  

    dadosOut2 = open("../../resultados-numericos/intervalos/" + net_name + "-clsInt.txt",'a')

    et = end_time 
    G = temporal_graph(1) #Ach oque et = 1

    set_vertex = set()		
    for v in dadosIn:
        v = v.rstrip().split(" ")
        if(int(v[2]) == int(end_time)):
            time = (1,1)
            vertices = (v[0],v[1])
            set_vertex.add(v[0])
            set_vertex.add(v[1])
            junt = [(vertices,time)]
            G.add_temporal_edges(junt)

    G.add_vertices(set_vertex)

    agg_closeness = compute_static_graph_statistics(G,0,1) #VERIFICAR 

    result = []
    for v in G.vertices:
        result.append(agg_closeness[0][1][v])

    mi = min(result)
    mean = numpy.mean(result)
    ma = max(result)

    dadosOut2.write(str(mi) + " " + str(mean) + " " + str(ma) + "\n")

    dadosIn.close()   


if __name__ == "__main__":
 
	#net_path =  "../../Codigos/Intervalos/graph.txt"

    colonia = "../../DataSets + Grafos/COLONIA/Graph24/communities24T.txt"

    fra79 = "../../DataSets + Grafos/FRANCE/7h-9h/graphVanet-7-9.txt"

    fra1719 = "../../DataSets + Grafos/FRANCE/17h-19h/graphVanet-17-19.txt"

    A6 = "../../DataSets + Grafos/MADRID/main/A6/A6.txt"

    M40 = "../../DataSets + Grafos/MADRID/main/M40/M40.txt"

    network = [
    			#[net_path, "teste", 3],
                [colonia, "cologne", 25], 
                [M40,  "m40", 20],
                [A6,  "a6", 20], 
                [fra79,  "fra79", 25],
                [fra1719,  "fra1719", 25]
              ]

    for net in network:            
	    for i in range(net[2]):
		    calc(net[0],net[1],i+1)
			#break	
		#break
	
	