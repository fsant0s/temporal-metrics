library(ggplot2)

colonia <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/Tempo_de_contato/colonia.txt"), class = "Cologne")
fra_79 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/Tempo_de_contato/fra_79.txt"), class = "Créteil 7AM-9AM")
fra_1719 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/Tempo_de_contato/fra_1719.txt"), class = "Creteil 5PM-7PM")
A6 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/Tempo_de_contato/A6.txt"), class = "Autovía A6")
M40 <- data.frame(read.table("/home/fillipe/Dropbox/Projeto Raquel/Tempo_de_contato/M40.txt"), class = "Motorway M40")


a <- 1.6
b <- 1.2

rotate_x <- function(data, column_to_plot, labels_vec, rot_angle) {
  plt <- barplot(data[[column_to_plot]], col='steelblue', xaxt="n")
  text(plt, par("usr")[3], labels = labels_vec, srt = rot_angle, adj = c(1.1,1.1), xpd = TRUE, cex=0.6) 
}

boxplot(colonia$V1,fra_79$V1, fra_1719$V1, A6$V1, M40$V1,
        ylab = "Average contact time",
        main = "Average vechicles contact time for all scenarios",
        cex.axis= a,
        cex.lab= a,
        cex.main = 2
        )
axis(1, at=c(seq(1,5,1)), labels=c("Cologne", "Créteil 7AM-9AM", "Creteil 5PM-7PM",  "Autovía A6", "Motorway M40"), 
     tick=FALSE, line=1, cex.axis = a)
