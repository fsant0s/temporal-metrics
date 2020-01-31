library(igraph)
library(plyr)
library(timeordered)
library(ggplot2)
library(graphics)
library(ProNet)
library(MASS)
library(sm)
library(scales)
library(gridExtra)
library(grid)

source("C:/Users/FS-Ma/Dropbox/Projeto Raquel/Códigos/Outros/PlotDegreeDistribution.r")

data <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/COLONIA/Graph24/communities24T.txt", head = T)
cenario <- "Colônia"
  
g <- generatetonetwork(data)

# inicio agregado
timeStart <- min(data[['TimeStart']])
timeStop <- max(data[['TimeStop']])

slice <- generatetimedeltas(timeStart , timeStop+1, timeStop)
graphSlice <- generatenetworkslices(g, slice)
graphAgg <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
E(graphAgg)$weight <- 1

degreeAgg <- 1:max(igraph::degree(graphAgg)) - 1 #Grau agregado
distribuitionAgg <- degree_distribution(graphAgg) #Distribuição dos graus na rede Agregada
zerosAgg <- (distribuitionAgg == 0) # para remover os zeros (pois log(0) é infinito)
#fim agregado

#inicio temporal
dg <- NA
degreeTemp <- 0
for(i in unique(data[['TimeStart']])){

    slice <- generatetimedeltas(i , i+1, 1 )
    graphSlice <- generatenetworkslices(g, slice)
    staticGraph <- as.undirected(graphSlice[1][[1]], mode = c("collapse", "each", "mutual"),edge.attr.comb = igraph_opt("edge.attr.comb"))
    E(staticGraph)$weight <- 1

    temporalDistribution <- t(matrix(degree_distribution(staticGraph))) #distribuição temporal
    degreeTemp <- degreeTemp + igraph::degree(staticGraph)*2 # grau temporal

    dg <- rbind.fill.matrix(dg,temporalDistribution)

}

degreeTemp <- 1:max(degreeTemp) - 1
dg[is.na(dg)] <- 0
zerosTemp <- (dg == 0) # para remover os zeros (pois log(0) é infinito)
distributionTemporal <- (colSums(dg))/timeStop



par(mfrow=c(1,2),oma = c(0, 0, 2, 0))

p1 <- fit_power_law(degreeAgg,distribuitionAgg,1e-05,1, "Aggregate", cenario) 
p2 <- fit_power_law(degreeTemp,distributionTemporal,1e-05,1, "Temporal", cenario)

main=textGrob(paste("Degree Distribution: ", cenario),gp=gpar(fontsize=36,font=2))
grid.arrange(p1,p2,ncol =2, top = main)



