library(igraph)
library(plyr)
library(timeordered)

#colonia <- read.table("/home/fillipe/Dropbox/Projeto Raquel/DataSets + Grafos/COLONIA/Graph24/communities24T.txt", head = T)
#fra_79 <- read.table("/home/fillipe/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/7h-9h/graphVanet-7-9.txt", head = T)
#fra_1719 <- read.table("/home/fillipe/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/17h-19h/graphVanet-17-19.txt", head = T)
#A6 <- read.table("/home/fillipe/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/A6/A6.txt", head = T)
M40 <- read.table("/home/fillipe/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/M40/M40.txt", head = T)

length_vehicle <- length(union(M40[["VertexFrom"]],M40[["VertexTo"]]))

g <- generatetonetwork(M40)

#DEGREE TEMPORAL
degreeTemp <- 0
for(i in unique(M40[['TimeStart']])){
  
  slice <- generatetimedeltas(i , i+1, 1 )
  
  graphSlice <- generatenetworkslices(g, slice)
  graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
  E(graphAgg)$weight <- 1
  
  degreeTemp <- degreeTemp + igraph::degree(graphAgg)
  
}

#print(degreeTemp)
#degreeTemporal <- ( degreeTemp / (2 * length( unique(data[['TimeStart']]) ) * (length(union(data[["VertexFrom"]],data[["VertexTo"]])) - 1)  ) )
#/length_vehicle
write.table(degreeTemp,file = "/home/fillipe/Dropbox/Projeto Raquel/Tempo_de_contato/M40.txt", sep = " ",row.names=F, col.names = FALSE,quote=FALSE)