library(igraph)
library(plyr)
library(timeordered)
library(stringr)

colonia = read.table("../../DataSets + Grafos/COLONIA/Graph24/communities24T.txt", head = T)

fra79 = read.table("../../DataSets + Grafos/FRANCE/7h-9h/graphVanet-7-9.txt", head = T)

fra1719 = read.table("../../DataSets + Grafos/FRANCE/17h-19h/graphVanet-17-19.txt", head = T)

A6 = read.table("../../DataSets + Grafos/MADRID/main/A6/A6.txt", head = T)

M40 = read.table("../../DataSets + Grafos/MADRID/main/M40/M40.txt", head = T)

calc <- function(data, n_name){
  
  g <- generatetonetwork(data)
  
  timeStart <- min(data[['TimeStart']])
  timeStop <- max(data[['TimeStop']]) 
  r_degree <- 0
  r_cls <- 0
  r_bt <- 0
  
  for(i in 1:timeStop) {

    slice <- generatetimedeltas(i ,i+1, 1)
    graphSlice <- generatenetworkslices(g, slice)
    graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
    E(graphAgg)$weight <- 1

    #DEGREE AGGREGATE - DONE!
    degreeAgg <- igraph::degree(graphAgg)
    degreeAgg <- ((2*degreeAgg) / (2 * ( gorder(graphAgg) - 1)))
    r_degree <- data.frame( min(degreeAgg),  mean(degreeAgg), max(degreeAgg) )
    write.table(r_degree,file = paste("../../resultados-numericos/intervalos/", n_name, "degreeInt.txt", sep = ""), 
                sep = " ",row.names= F , col.names = FALSE,quote=FALSE, append = T)

    #CLOSENESS AGGREGATE - NAO FUNCIONA!
    #numberVertices <- ( gorder(graphAgg) - 1 )
    #clsAgg<-NULL
    #for(v in V(graphAgg)$name ){
    #   dist <- distances(graphAgg, v ,V(graphAgg)$name)
    #   clsAgg[length(clsAgg)+1] <- numberVertices / rowSums(dist*is.finite(dist),na.rm=TRUE)
    #   print(is.finite(dist))
    #}
    #r_cls <- data.frame( min(clsAgg) , mean(clsAgg), max(clsAgg) )
    #write.table(r_cls,file = paste("../../resultados-numericos/intervalos/", n_name, "closInt.txt", sep = ""),
    #            sep = " ",row.names= F , col.names = FALSE,quote=FALSE, append = T) 
    
    #BETWENESS AGGREGATE
    bt <- igraph::betweenness(graphAgg) / ((gorder(graphAgg) - 2) * (gorder(graphAgg) - 1)  / 2)
    r_bt <- data.frame( min(bt) , mean(bt), max(bt) ) 
    write.table(r_bt,file = paste("../../resultados-numericos/intervalos/", n_name, "btwInt.txt", sep = ""), 
                sep = " ",row.names= F , col.names = FALSE,quote=FALSE, append = T) 
  }  
  
  print(paste("FIM: ", n_name))
  
}

calc(colonia,"col-")
calc(fra79, "fra79-")
calc(fra1719, "fra1719-")
calc(A6, "a6-")
calc(M40, "m40-")




