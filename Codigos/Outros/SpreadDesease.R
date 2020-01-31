#n = 1 - Comerciante
#v = 5 - Vilas
#Î³ = 6 - residentes para cada fila
#p = 0.4 probabilidade do comerciante mover 
#d = 0.1 - umac aresta vai DESAPARECER da vila
#b = 0.1  uma aresta vai APARECER 

library(igraph)

g.v1 <- graph.full(6, directed= FALSE)
E(g.v1)$weight <- 1
V(g.v1)$name <- c("A","B","C","D","E","F")

g.v2 <- graph.full(6, directed= FALSE)
E(g.v2)$weight <- 1
V(g.v2)$name <- c("A","B","C","D","E","F")

g.v3 <- graph.full(6, directed= FALSE)
E(g.v3)$weight <- 1
V(g.v3)$name <- c("A","B","C","D","E","F")

g.v4 <- graph.full(6, directed= FALSE)
E(g.v4)$weight <- 1
V(g.v4)$name <- c("A","B","C","D","E","F")

g.v5 <- graph.full(6, directed= FALSE)
E(g.v5)$weight <- 1
V(g.v5)$name <- c("A","B","C","D","E","F")

g.merchant <- graph.empty(n=1, directed=FALSE)
E(g.merchant)$weight <- 1
V(g.merchant)$name <- "merchant"

g.novo <- g.v1 + g.merchant
v.aleatorio <- sample((V(g.v1)$name), 1)
g.novo["merchant",v.aleatorio[1]] <- 1;
g.v1 <- g.novo;
E(g.v1)$weight <- 1;

#par(mfrow=c(2,3))
#plot(g.v1, edge.label=(E(g.v1)$weight),edge.arrow.size = 0)

#DONE! ERRADOna função ANY
findMerchant <- function(viles){ #Retorna o grafo onde o comerciante está.
  x <- 0
  for(v in viles){
    x <- x + 1
    if(any(V(v)$name == "merchant",  na.rm = TRUE)){
      return (x)
      break
    }
  }
}

viles <- list(g.v1,g.v2,g.v3,g.v4,g.v5)

degree.merchant.temp <- 0
dg1 <- double(6)
dg2 <- double(6)
dg3 <- double(6)
dg4 <- double(6)
dg5 <- double(6)

#Inicio do Cálculo do grau agregado do comerciante!
y <- findMerchant(viles)
degree.merchant.agg <- list(paste(c(y , adjacent_vertices(viles[[y]],"merchant") ),  collapse=""))

for (i in 1:100){ #100 steps
  
  #Cálculo das métricas!
  
  #Grau temporal Comerciante
  y <- findMerchant(viles)
  dG <- degree(viles[[y]])
  degree.merchant.temp <- (degree.merchant.temp + 2*dG["merchant"])
  
  #Grau temporal Comerciante
  dg1 <- dg1 + 2*degree(viles[[1]])
  dg2 <- dg2 + 2*degree(viles[[2]])
  dg3 <- dg3 + 2*degree(viles[[3]])
  dg4 <- dg4 + 2*degree(viles[[4]])
  dg5 <- dg5 + 2*degree(viles[[5]])
  
   cont <- 0
    for(vile in viles){
      cont <- cont + 1
      
      if(sample(1:10,1) <= 1){ # Aresta interna aparecer
        graphFULL <- graph.full(6,directed = FALSE)
        E(graphFULL)$weight <- 1
        V(graphFULL)$name <- c("A","B","C","D","E","F")
        
        graphInverse <- graphFULL - vile;
        allEdgesInverse <- get.edgelist(graphInverse);
        randomEdge <- sample(1:length(allEdgesInverse[,1]),1);
        
        if(length(allEdgesInverse[,1]) != 0){ # Se o grafo nao for completo.
          vile[allEdgesInverse[randomEdge,][1],allEdgesInverse[randomEdge,][2]] <- 1;
          
          viles[[cont]] <- vile
        }
        
      }
      if(sample(1:10,1) <= 1){ # Aresta interna desaparecer
          allEdges <- get.edgelist(vile); 
          randomEdge <- sample(1:length(allEdges[,1]),1);
          vile[allEdges[randomEdge,][1],allEdges[randomEdge,][2]] <- NULL #Vertice deletado
          
          viles[[cont]] <- vile
      }
    
    }

    
    #DONE!
    if(sample(1:10,1) >= 5){ # Each merchant moves with a probability randomly assigned between 0.5 and 1.
      x <- findMerchant(viles)
      viles[[x]] <- delete.vertices(viles[[x]] ,"merchant")
      numb <- 0
      while(TRUE){
          numb <- sample(1:5,1)
          if(numb != x){break}
      }
      
      g.novo <- viles[[numb]] + g.merchant

      v.aleatorio <-  sample((V(viles[[numb]])$name), 1)
      g.novo["merchant",v.aleatorio[1]] <- 1;
      g.novo$weight <- 1
      viles[[numb]] <- g.novo;
    }

   #Grau Agregado Comerciante
   y <- findMerchant(viles)
   degree.merchant.agg <- append(degree.merchant.agg,(paste(c(y , adjacent_vertices(viles[[y]],"merchant") ),  collapse="")))
      
}


#par(mfrow=c(2,3))
#for(i in viles){
#  plot(i)
#}

#DEGREE
degreeR.temp <- dg1 + dg2 + dg3 + dg4 + dg5 #Média de todos os vértices!
degreeR.temp <- (degreeR.temp["A"] + degreeR.temp["B"] + degreeR.temp["C"] + degreeR.temp["D"] + degreeR.temp["E"]) / 30
agg.R <- degreeR.temp/(2*(31-1)*100)
print(agg.R)
tem.M <- (degree.merchant.temp/(2*(31 - 1)*100) )

barplot(c( 0.2, 2*length(unique(degree.merchant.agg))/(2*(31 - 1)*1),
        agg.R, tem.M,
        agg.R, tem.M),
        names.arg=c("Agg.R","Agg.M","Ave.R","Ave.M","Tem.R","Tem.M"), cex.names=0.7,main="DEGREE", ylim = c(0,1), col = c("black","grey"))


#CLOSSENES
for(i in viles){
  print(closeness(i))
}


barplot(c( 0.2, 2*length(unique(degree.merchant.agg))/(2*(31 - 1)*1),
        #  agg.R, tem.M,
           agg.R, tem.M),
        names.arg=c("Agg.R","Agg.M","Ave.R","Ave.M","Tem.R","Tem.M"), cex.names=0.7,main="DEGREE", ylim = c(0,1), col = c("black","grey"))


#BETWENNESS





