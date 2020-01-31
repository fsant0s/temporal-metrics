library(igraph)
library(plyr)
library(timeordered)
library(ggplot2)
library(graphics)
library(ProNet)

teste <- read.table("C:/Users/FS-Ma/Desktop/graph.txt", head = T)

colonia <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/COLONIA/Graph24/communities24T.txt", head = T)
  
fra79 <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/7h-9h/graphVanet-7-9.txt", head = T)

fra1719 <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/17h-19h/graphVanet-17-19.txt", head = T)

A6 <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/A6/A6.txt", head = T)

M40 <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/M40/M40.txt", head = T)

averageDegree = function(data) {
  
  g <- generatetonetwork(data)
  
  # inicio agregado - OK
  timeStart <- min(data[['TimeStart']])
  timeStop <- max(data[['TimeStop']])
  
  slice <- generatetimedeltas(timeStart , timeStop+1, timeStop)
  graphSlice <- generatenetworkslices(g, slice)
  graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
  E(graphAgg)$weight <- 1
  
  degreeAgg <- igraph::degree(graphAgg)
  #degreeAgg <- ((2*degreeAgg) / (2 * ( gorder(graphAgg) - 1)))

  print(paste("Grau medio Agregado =", mean(degreeAgg)))
  
  #inicio temporal
  degreeTemp <- 0
  for(i in unique(data[['TimeStart']])){
    
    slice <- generatetimedeltas(i , i+1, 1 )
    graphSlice <- generatenetworkslices(g, slice)
    graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
    E(graphAgg)$weight <- 1
    
    degreeTemp <- degreeTemp + igraph::degree(graphAgg)*2
    
  }
  
  #degreeTemporal <- ( degreeTemp / (2 * length( unique(data[['TimeStart']]) ) * (length(union(data[["VertexFrom"]],data[["VertexTo"]])) - 1)  ) )
  
  print(paste("Grau medio Temporal =", mean(degreeTemp)))
  
}

#mean(degree(g4))