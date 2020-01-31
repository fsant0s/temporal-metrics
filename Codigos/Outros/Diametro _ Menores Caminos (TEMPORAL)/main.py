#!/usr/bin/env python2
# encoding: utf-8
#Calculo das metricas de centralidades: Closeness and Betweenness Temporais.
from temporal_graph import *

dadosIn = open("/home/melzinho/Dropbox/Projeto Raquel/Codigos/Graph Metrics/graph.txt", "r")
vertex = open("/home/melzinho/Dropbox/Projeto Raquel/Codigos/Graph Metrics/vertices.txt", "r")

if __name__ == "__main__":
      
    et = 3 # time end
	
    G = temporal_graph(et)
    
    ls = []
    for i in vertex:
        ls.append(i.rstrip())
   
    G.add_vertices(ls)
	
    for v in dadosIn:
        v = v.rstrip().split(" ")
        time = (v[2],v[3])
        vertices = (v[0],v[1])
        junt = [(vertices,time)]
        G.add_temporal_edges(junt)

    diameterT_average = diameterTemporal_averagePathShortest(G,0,et)
    print(diameterT_average)
	
    dadosIn.close()
    vertex.close()
    print("FIM")


 
