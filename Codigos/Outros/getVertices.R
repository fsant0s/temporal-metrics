

data <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/7h-9h/graphVanet-7-9.txt", head = T)
df <- union(data$VertexFrom, data$VertexTo)



write.table(df,"C:/Users/FS-Ma/Dropbox/Projeto Raquel/DataSets + Grafos/FRANCE/7h-9h/vertices.txt", quote = F, row.names = F, col.names = F)