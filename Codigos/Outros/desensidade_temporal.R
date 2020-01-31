library(igraph)
library(plyr)
library(timeordered)
library(ggplot2)
library(graphics)
#library(ProNet)

teste <- read.table("C:/Users/Filli/Desktop/graph.txt", head = T)

colonia <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/COLONIA/Graph24/communities24T.txt", head = T)
fra79 <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/7h-9h/graphVanet-7-9.txt", head = T)
fra1719 <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/17h-19h/graphVanet-17-19.txt", head = T)
A6 <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/A6/A6.txt", head = T)
M40 <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/M40/M40.txt", head = T)

density = function(data) {
  
  g <- generatetonetwork(data)
  dens <- 0
  
  degreeTemp <- 0
  for(i in unique(data[['TimeStart']])){
    
    slice <- generatetimedeltas(i , i+1, 1 )
    graphSlice <- generatenetworkslices(g, slice)
    graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
    E(graphAgg)$weight <- 1
    
    m <- gsize(graphAgg) # m = |E|
    n <- length( unique(data[data["TimeStart"] == i]) ) -1 # n = |v|
    
    dens <- dens +  (2 * m) / ( n * (n-1) )
    
  }
  
  dens <- dens / i
  print(paste("Densidade (D = 2m/n(n-1)) =", dens  ))
  
}

#density(colonia)
density(fra79)
#density(fra1719)
#density(A6)
#density(M40)