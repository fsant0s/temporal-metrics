library(igraph)
library(plyr)
library(timeordered)
library(ggplot2)
library(graphics)
#library(ProNet)

teste <- read.table("/home/melzinho/Dropbox/Projeto Raquel/Codigos/Graph Metrics/graph.txt", head = T)

#colonia <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/COLONIA/Graph24/communities24T.txt", head = T)
 
#fra79 <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/7h-9h/graphVanet-7-9.txt", head = T)
 
#fra1719 <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/17h-19h/graphVanet-17-19.txt", head = T)
# 
#A6 <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/A6/A6.txt", head = T)
# 
#M40 <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/M40/M40.txt", head = T)

diameter_averagePath_cc = function(data,name) {
  
  g <- generatetonetwork(data)
  
  # inicio agregado - OK
  timeStart <- min(data[['TimeStart']])
  timeStop <- max(data[['TimeStop']])
  
  slice <- generatetimedeltas(timeStart , timeStop+1, timeStop)
  graphSlice <- generatenetworkslices(g, slice)
  graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
  E(graphAgg)$weight <- 1

  #print(paste("Cenario: ", name))
  #print(paste("Diameter Aggregate =", diameter(graphAgg)))
  #print(paste("Average Shortest Path Length Agg) =", mean_distance(graphAgg)))
  print(paste("Coeficiente de agrupamento AGG  =", transitivity(graphAgg, type = "global",isolates = c("zero"))))
  
  #inicio temporal CC
  transitivityTemporal <- 0
  for(i in unique(data[['TimeStart']])){

    slice <- generatetimedeltas(i , i+1, 1 )
    graphSlice <- generatenetworkslices(g, slice)
    staticGraph <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
    E(staticGraph)$weight <- 1
    
    transitivityTemporal = transitivityTemporal + transitivity(staticGraph, type = "global", isolates = c("zero"))
    print(transitivity(staticGraph))
  }
  print("CC FUNCIONA NO MAIN.TXT")
  print(paste("Coeficiente de agrupamento Temporal  =", transitivityTemporal/timeStop))
  #fim temporal
  print("\n\n############\n\n")  
}
diameter_averagePath_cc(teste,"teste")
# diameter_averagePath_cc(colonia,"Colonia")
# diameter_averagePath_cc(fra79,"Fra79")
# diameter_averagePath_cc(fra1719, "Fra1719")
# diameter_averagePath_cc(A6, "A6")
# diameter_averagePath_cc(M40,"M40")