library(igraph)
library(plyr)
library(timeordered)
library(ggplot2)
library(graphics)

svg("D:/Dropbox/Projeto Raquel/Codigos/Outros/fra79-edges.svg")


#teste <- read.table("D:/Dropbox/Projeto Raquel/Codigos/Intervalos/graph.txt", head = T)

#colonia <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/COLONIA/Graph24/communities24T.txt", head = T)

 fra79 <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/7h-9h/graphVanet-7-9.txt", head = T)

#fra1719 <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/17h-19h/graphVanet-17-19.txt", head = T)

# A6 <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/A6/A6.txt", head = T)

#M40 <- read.table("D:/Dropbox/Projeto Raquel/DataSets + Grafos/MADRID/main/M40/M40.txt", head = T)

calc = function(data, name){
  
  
  g <- generatetonetwork(data)
  edges <- 0
  vertex <- 0
  
  #agg graph
  timeStart <- min(data[['TimeStart']])
  timeStop <- max(data[['TimeStop']])
  
  slice_agg <- generatetimedeltas(timeStart , timeStop+1, timeStop)
  graphSlice_agg <- generatenetworkslices(g, slice_agg)
  graphAgg <- as.undirected(graphSlice_agg[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
  E(graphAgg)$weight <- 1
  
  #Calcular quantidade d evertices e arestas no grafo agregado.
  # v1_agg <- unique(data["VertexFrom"])
  # v2_agg <- unique(data["VertexTo"])
  # 
  # numb_vertices_agg <- length(unique(c(v1_agg$VertexFrom,v2_agg$VertexTo)))
  # numb_edgs_agg <- gsize(graphAgg)
  # 
  # print(numb_vertices_agg)
  # print(numb_edgs_agg),
  
  for(i in unique(data[['TimeStart']])){
    
    slice <- generatetimedeltas(i , i+1, 1 )
    graphSlice <- generatenetworkslices(g, slice)
    staticGraph <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
    E(staticGraph)$weight <- 1
    
    edges[i] <- gsize(staticGraph)
    vertex[i] <- length( unique(data[data["TimeStart"] == i]) ) -1 # n = |v|
    
  }
  
  seqq <- 1:25
  cexx <- 2
  lab <- c(expression('G'[1]),"","",expression('G'[4]),"",
           "",expression('G'[7]), "","", expression('G'[10]),
           "", "",expression('G'[13]), "", "",
           expression('G'[16]),"", "", expression('G'[19]), "",
           "",expression('G'[22]), "", "", expression('G'[25])
  )
  
  # (" ~ G[t]^i ~"," ~ "1" <= {"i" <= 25} ~ ")"
  plot(seqq, edges, xlab= "", ylab="Number of Edges", cex = cexx, col=rgb(0,0,0),
       pch=15, cex.lab=2, ylim = c(0,6000), cex.axis=cexx, xaxt = "n"
  )
  
  axis(1, at = seqq, cex.axis=cexx,
       labels = lab,
       line = 1,
       lwd = 0, lwd.ticks = 0
  )
  
  axis(1, at = seqq, cex.axis=cexx,
       labels = c("","","","","","","","","","","","","","","","","","","","","","","","","")
       #lwd = 0, lwd.ticks = 0,
       #labels = lab,
       #line =1
  )
  mtext("Graph", side = 1,line = 3.5, cex = cexx)
  
  # points(1:i,vertex,lwd=3 , pch=19 , type="b", cex = cexx)
  # points(1:i,rep(numb_vertices_agg,i), col=rgb(0.8,0.4,0.1,0.7) , lwd=3 , pch=10 , type="b" )
  # points(1:i,rep(numb_edgs_agg,i), col=rgb(0.8,0.4,0.1,0.7) , lwd=3 , pch=10 , type="b" )
  
  #lines(edges)
  lines(seqq, edges)
  # lines(rep(numb_vertices_agg,i))
  # lines(rep(numb_edgs_agg,i))
  
  
  # legend("topleft",
  #       legend = c("Edges", "Vertex"),
  #       # col = c(rgb(0,0,0),
  #       #         rgb(0.8,0.4,0.1,0.7)),
  #       inset=c(0.002,-0.17),
  #       ncol=2,
  #       xpd = TRUE,
  #       bty="n",
  #       pch = c(15,19),
  #       cex = 2.5,
  #       pt.cex = cexx, #tamanho da bola da legenda
  #       text.col = "black",
  #       horiz = F
  #       #inset = c(0.005,5)
  # )
}

# par(mfrow=c(1,5), par(mar=c(4.5, 4.5, 4.1, 2.1) ))
# calc(colonia, "Cologne")
 calc(fra79,  "Créteil 7AM-9AM")
# calc(fra1719, "Créteil 5PM-7PM")
# calc(A6, "Autov????a A6")
# calc(M40, "Motorway M40")

dev.off() 
