library(igraph)
library(plyr)
library(timeordered)

data <- read.table("C:/Users/Fillipe/Desktop/graph.txt", head = T)
  
g <- generatetonetwork(data)

# inicio agregado
timeStart <- min(data[['TimeStart']]) #pega o tempo inicial do trace.
timeStop <- max(data[['TimeStop']]) #pega o tempo final do trace.

#Cria o grafo agregado não direcionado com peso 1.
slice <- generatetimedeltas(timeStart , timeStop+1, timeStop)
graphSlice <- generatenetworkslices(g, slice)
graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
E(graphAgg)$weight <- 1
write.graph(graphAgg, "graph-agg.txt")
#fim agregado

#inicio da construção do grafo temporal
dg <- NA
degreeTemp <- 0
for(i in unique(data[['TimeStart']])){

    slice <- generatetimedeltas(i , i+1, 1 )
    graphSlice <- generatenetworkslices(g, slice)
    staticGraph <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
    E(staticGraph)$weight <- 1

    write.graph(staticGraph, paste("graph-",i,".txt",sep=""))
    
}