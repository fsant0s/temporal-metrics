library(ggplot2) 
library(sm)
library(scales)
library(plyr)

acol <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/COLONIA/btwAgregado.txt"), grupo = "Cologne", tipo = "agg")
tcol <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/COLONIA/btwTemp.txt"), grupo = "Cologne", tipo = "temp")

am40 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/M40/btwAgregado.txt"), grupo = "Motorway M40", tipo = "agg")
tm40 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/M40/btwTemp.txt"), grupo = "Motorway M40", tipo = "temp")

aA6 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/A6/btwAgregado.txt"), grupo = "Autovía A6", tipo = "agg")
tA6 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/A6/btwTemp.txt"), grupo = "Autovía A6", tipo = "temp")

a79 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/7-9/btwAgregado.txt"), grupo = "Créteil 7AM-9AM", tipo = "agg")
t79 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/7-9/btwTemp.txt"), grupo = "Créteil 7AM-9AM", tipo = "temp")

a1719 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/17-19/btwAgregado.txt"), grupo = "Creteil 5PM-7PM", tipo = "agg")
t1719 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/resultados-numericos/semID/17-19/btwTemp.txt"), grupo = "Creteil 5PM-7PM", tipo = "temp")

rcol <- rbind(acol,tcol)
rm40 <- rbind(am40,tm40)
ra6 <- rbind(aA6,tA6)
r79 <- rbind(a79,t79)
r1719 <- rbind(a1719,t1719)

df <- rbind.fill(rcol,rm40,ra6,r79,r1719)

color.1 <- "black"
color.2 <- "grey"

print(ggplot( df, aes(x = V1, colour = tipo)) +
        geom_density(aes(fill= tipo), size=0, alpha=0.7, binwidth = 1)+
        scale_fill_manual( values = c(color.1,color.2))+
        scale_colour_manual(values= c(color.1,color.2))+
        theme(legend.position="none")+
        labs(x = "value")+
        labs(y = "density")+
        theme(legend.title=element_blank(),axis.text=element_text(size=12),axis.text.x = element_text(size=12), axis.title=element_text(size=14))+
        scale_x_continuous(trans = "log",labels = trans_format("log2", math_format(10^.x)), breaks = trans_breaks("log2", function(x) exp(x), by=1))+
        facet_grid(~ grupo, scales = "free_x") #scales = "free_x"
)
  
  



