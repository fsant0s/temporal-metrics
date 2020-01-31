library(igraph)
library(plyr)
library(timeordered)

data <- read.table("files/graph24T.txt", head= TRUE)
#data <- read.table("C:/Users/Filli/Desktop/graph.txt", head= TRUE)

g <- generatetonetwork(data)
m <- max(data["TimeStart"])

for(i in 1:m){
  
    slice <- generatetimedeltas(i, i+1, 1)
    
    graphSlice <- generatenetworkslices(g, slice)
    graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
    E(graphAgg)$weight <- 1
    
    wc <- cluster_louvain(graphAgg)
    #wc <- cluster_edge_betweenness(g)
    sz <- sizes(wc)
    
    subgrafo <- induced.subgraph(graphAgg, which(membership(wc) == which(sz %in% max(sz))[1]))
    v <- get.edgelist(subgrafo)
    
    num <- v
    num[,1] <- i
    num[,2] <- i
    v <- cbind(v,num)
    
    write.table(v,"files/communities24T.txt", col.names = FALSE, row.names = FALSE,quote = FALSE,append = TRUE)
}
