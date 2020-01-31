library(igraph)
library(plyr)
library(timeordered)


data <- read.table("/home/melzinho/Dropbox/Projeto Raquel/Codigos/Graph Metrics/graph.txt", head = T)

g <- generatetonetwork(data)

timeStart <- min(data[['TimeStart']])
timeStop <- max(data[['TimeStop']])
  
slice <- generatetimedeltas(timeStart , timeStop+1, timeStop)
graphSlice <- generatenetworkslices(g, slice)
graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
E(graphAgg)$weight <- 1

#DEGREE AGGREGATE - DONE!
#degreeAgg <- igraph::degree(graphAgg)
#degreeAgg <- ((2*degreeAgg) / (2 * ( gorder(graphAgg) - 1)))
#write.table(degreeAgg,file = "degreeAgregado.txt", sep = " ")
#write.table(degreeAgg,file = "degreeAgregado.txt", sep = " ", row.names=T, col.names = FALSE,quote=FALSE)

#CLOSENESS AGGREGATE
# numberVertices <- ( gorder(graphAgg) - 1 )
# clsAgg<-NULL
# for(v in V(graphAgg)$name ){
#     dist <- distances(graphAgg, v ,V(graphAgg)$name)
#     clsAgg[length(clsAgg)+1] <- numberVertices / rowSums(dist*is.finite(dist),na.rm=TRUE)
# }
# write.table(clsAgg,file = "closAgregado.txt", sep = " ")

#BETWENESS AGGREGATE
bt <- igraph::betweenness(graphAgg) / ((gorder(graphAgg) - 2) * (gorder(graphAgg) - 1)  / 2)
print(bt)
#write.table(bt,file = "btwAgregado.txt", sep = " ",row.names=T, col.names = FALSE,quote=FALSE)

#DEGREE TEMPORAL
# degreeTemp <- 0
# for(i in unique(data[['TimeStart']])){
#   
#   slice <- generatetimedeltas(i , i+1, 1 )
#   
#   graphSlice <- generatenetworkslices(g, slice)
#   graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
#   E(graphAgg)$weight <- 1
#   
#   degreeTemp <- degreeTemp + igraph::degree(graphAgg)*2
#   #write_graph(graphAgg, file = "kk.txt")
#   
# }


#degreeTemporal <- ( degreeTemp / (2 * length( unique(data[['TimeStart']]) ) * (length(union(data[["VertexFrom"]],data[["VertexTo"]])) - 1)  ) )
#write.table(degreeTemporal,file = "degreeTemporal.txt", sep = " ",row.names=T, col.names = FALSE,quote=FALSE)

#print("FIM")