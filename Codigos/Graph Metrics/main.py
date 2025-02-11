#!/usr/bin/env python2
#Calculo das metricas de centralidades: Closeness and Betweenness Temporais.
from temporal_graph import *

dadosIn = open("graph.txt", "r") #Graph path > Datasets/COLOGNEGraph24, FRANCE/7-9h, FRANCE/17-19h, MADRID/A6 or MADRID/M40.
vertex = open("vertices.txt",'r') #Vertex path

dadosOut1 = open("btwTemp.txt",'w') 
dadosOut2 = open("clsTemporal.txt",'w')
dadosOut3 = open("closAgregado.txt",'w')

if __name__ == "__main__":
      
    et = 3 # time end to every graph.
    
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


    print("[=>] Calculando betweenness Temporal")
    temp_betweenness = compute_temporal_betweenness(G,0,et)
    for a,b in temp_betweenness.items():
        dadosOut1.write(str(a)+ " " + str(b)+"\n")
        
    print("[=>] Calculando closeness Temporal")
    temp_closeness = compute_temporal_closeness(G,0,et)
    for v in G.vertices:
        dadosOut2.write(str(v) + " " + str(temp_closeness[v]) + "\n")   
    
    print("[=>] Calculando closeness Agregado")
    agg_closeness = compute_static_graph_statistics(G,0,et)
    for v in G.vertices:
        print(v + " " + str(agg_closeness[0][1][v]))
    
    
    dadosIn.close()
    vertex.close()
    dadosOut1.close()
    dadosOut2.close()
    dadosOut3.close()
    print("FIM")


 
