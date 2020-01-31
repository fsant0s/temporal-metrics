library(ggplot2) 
library(sm)
library(scales)
library(plotrix)
library(plyr)

#par(mgp=c(3.5,2,1))
#par(mar=c(5,6,4,2)+0.9)

acol <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/col/closAgregado.txt"), grupo = "Cologne", tipo = "agg")
tcol <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/col/clsTemporal.txt"), grupo = "Cologne", tipo = "temp")

am40 <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/M40/closAgregado.txt"), grupo = "Motorway M40", tipo = "agg")
tm40 <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/M40/clsTemporal.txt"), grupo = "Motorway M40", tipo = "temp")

aA6 <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/A6/closAgregado.txt"), grupo = "Autovía A6", tipo = "agg")
tA6 <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/A6/clsTemporal.txt"), grupo = "Autovía A6", tipo = "temp")

a79 <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/7-9/closAgregado.txt"), grupo = "Créteil 7AM-9AM", tipo = "agg")
t79 <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/7-9/clsTemporal.txt"), grupo = "Créteil 7AM-9AM", tipo = "temp")

a1719 <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/17-19/closAgregado.txt"), grupo = "Créteil 5PM-7PM", tipo = "agg")
t1719 <- data.frame(read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/comID/17-19/clsTemporal.txt"), grupo = "Créteil 5PM-7PM", tipo = "temp")

txt <- "closeness" #"degree" #"betweenness"

acol <- acol[order(acol$V1, decreasing=c(TRUE)), ]
tcol <- tcol[order(tcol$V1, decreasing=c(TRUE)), ]

am40 <- am40[order(am40$V1, decreasing=c(TRUE)), ]
tm40 <- tm40[order(tm40$V1, decreasing=c(TRUE)), ]

aA6 <- aA6[order(aA6$V1, decreasing=c(TRUE)), ]
tA6 <- tA6[order(tA6$V1, decreasing=c(TRUE)), ]

a79 <- a79[order(a79$V1, decreasing=c(TRUE)), ]
t79 <- t79[order(t79$V1, decreasing=c(TRUE)), ]

a1719 <- a1719[order(a1719$V1, decreasing=c(TRUE)), ]
t1719 <- t1719[order(t1719$V1, decreasing=c(TRUE)), ]

par(mfrow=c(1,5), par(mar=c(4.5, 4.5, 4.1, 2.1) ))
a <- 0.01
b <- 0.1

plot(acol$V2, tcol$V2, main= "Cologne", ylim=c(0,a), xlim=c(0,b),  xlab= paste("Aggregate",txt, "\n(a)"), ylab= paste("Temporal",txt), pch=19, cex.lab=2, cex.axis=2, cex.main=2.5, cex.sub=2)
abline(lm(tcol$V2 ~ acol$V2))

plot(am40$V2, tm40$V2, main="Motorway M40", ylim=c(0,a), xlim=c(0,b), xlab= paste("Aggregate",txt, "\n(b)"), ylab= paste("Temporal",txt), pch=19, cex.lab=2, cex.axis=2, cex.main=2.5, cex.sub=2)
abline(lm(tm40$V2 ~ am40$V2))

plot(aA6$V2, tA6$V2, main="Autovia A6", ylim=c(0,a), xlim=c(0,b), xlab= paste("Aggregate",txt, "\n(c)"), ylab= paste("Temporal",txt) , pch=19, cex.lab=2, cex.axis=2, cex.main=2.5, cex.sub=2)
abline(lm(tA6$V2 ~ aA6$V2))

plot(a79$V2, t79$V2, main="Creteil 7AM-9AM", ylim=c(0,a), xlim=c(0,b), xlab= paste("Aggregate",txt , "\n(d)"), ylab= paste("Temporal",txt), pch=19, cex.lab=2, cex.axis=2, cex.main=2.5, cex.sub=2)
abline(lm(t79$V2 ~ a79$V2))

plot(a1719$V2, t1719$V2, main="Creteil 5PM-7PM", ylim=c(0,a), xlim=c(0,b), xlab= paste("Aggregate",txt , "\n(e)"), ylab= paste("Temporal",txt), pch=19, cex.lab=2, cex.axis=2, cex.main=2.5, cex.sub=2)
abline(lm(t1719$V2 ~ a1719$V2))


