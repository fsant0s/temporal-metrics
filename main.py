#!/usr/bin/env python2
#Calculo das metricas de centralidades: Closeness and Betweenness Temporais.
from temporal_graph import *

graph = open("graph-teste.txt", "r")

out_btw_temp = open("out/btwTemp.txt",'w') 
out_btw_agg = open("out/btwAgg.txt",'w')
out_cls_temp = open("out/closTemp.txt",'w')
out_cls_agg = open("out/closAgg.txt",'w')
out_dg_temp = open("out/dgTemp.txt",'w')
out_dg_agg = open("out/dgAgg.txt",'w')

if __name__ == "__main__":
      
    et = 0 # time end to every graph.
    for line in graph:
        line = line.rstrip().split(" ")
        et = max([et, int(line[2]), int(line[3])])
    graph.seek(0)
    
    G = temporal_graph(et)    
    set_vertex = set()
    
    for v in graph:
        v = v.rstrip().split(" ")
        try:
            vertices = (v[0],v[1])
            time = (v[2],v[3])
            set_vertex.add(v[0])
            set_vertex.add(v[1])
            junt = [(vertices,time)]
            G.add_temporal_edges(junt)
        except EOFError:
            break

    G.add_vertices(set_vertex)

    #ok
    print("[=>] Calculando grau temporal")
    temp_grau =  compute_temporal_degree(G,0,et)
    for v in G.vertices:
        out_dg_temp.write(str(temp_grau[v]) + "\n")   
        print(str(v) + " " + str(temp_grau[v]) + "\n")   

    #ok
    print("[=>] Calculando closeness temporal")
    temp_closeness = compute_temporal_closeness(G,0,et)
    for v in G.vertices:
        out_cls_temp.write(str(temp_closeness[v]) + "\n")   
        print(str(v) + " " + str(temp_closeness[v]))   

    #ok
    print("[=>] Calculando betweenness temporal")
    temp_betweenness = compute_temporal_betweenness(G,0,et)
    for a,b in temp_betweenness.items():
        out_btw_temp.write(str(b) + "\n")
        print(str(a)+ " " + str(b)) 
    
    #ok
    print("[=>] Calculando dg, cls e btw agregado")
    agregado = compute_static_graph_statistics(G,0,et)
    for v in G.vertices:
        out_dg_agg.write(str(agregado[0][0][v]) + " " + "\n")
        out_cls_agg.write(str(agregado[0][1][v]) + " " + "\n")
        out_btw_agg.write(str(agregado[0][2][v]) + " " + "\n")
        print(v + " " + str(agregado[0][0][v]) + " " + str(agregado[0][1][v]) + " " + str(agregado[0][2][v]))  

    graph.close()
    out_btw_temp.close()
    out_btw_agg.close()
    out_cls_temp.close()
    out_cls_agg.close()
    out_dg_temp.close()
    out_dg_agg.close()
    print("FIM")