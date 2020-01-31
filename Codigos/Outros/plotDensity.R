library(ggplot2) 
library(sm)
library(scales)

degreeAgg <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/Resutados númericos/semID/Colonia/degreeAgregado.txt")
degreeTemporal <- read.table("C:/Users/FS-Ma/Dropbox/Projeto Raquel/Resutados númericos/semID/Colonia/degreeTemporal.txt")

# clsAgg <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/Resutados númericos/comID/A6/closAgregado.txt")
# clsTemporal <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/Resutados númericos/comID/A6/clsTemporal.txt")
# 
# btwAgg <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/Resutados númericos/comID/A6/btwAgregado.txt")
# btwTemporal <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/Resutados númericos/comID/A6/btwTemp.txt")

r <- rbind(degreeAgg,degreeTemporal)

degreeAgg[,1] <- "Agregado"
degreeTemporal[,1] <- "Temporal"

s <- rbind(degreeAgg,degreeTemporal)

color.1 <- "black"
color.2 <- "grey"

a <- data.frame(r,s)

print(ggplot( a, aes(x = V1, colour = V1.1)) +
  geom_density(aes(fill= V1.1), size=0, alpha=0.7, binwidth = 1)+
  scale_fill_manual( values = c(color.1,color.2))+
  scale_colour_manual(values= c(color.1,color.2))+
  theme(legend.position="none")+
  labs(x = "Valor")+
  labs(y = "Densidade")+
  theme(legend.title=element_blank(),axis.text=element_text(size=22),axis.text.x = element_text(size=22), axis.title=element_text(size=22))+
  scale_x_continuous(trans = "log2",labels = trans_format("log2", math_format(e^.x)), breaks = trans_breaks("log2", function(x) exp(x), by=1))+
  scale_y_continuous(limits = c(0,1)))
  
  



