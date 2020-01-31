#D,C,B

dev.off()
a <- data.frame(value = c(0.507, 0.771, 0.058),name = "Créteil 7AM-9AM", m = c("Degree","Closeness","Betweenness"))
b <- data.frame(value = c(0.430, 0.839, 0.130),name = "Creteil 5PM-7PM", m = c("Degree","Closeness","Betweenness"))
c <- data.frame(value = c(0.725, 0.880, 0.991),name = "Cologne", m = c("Degree","Closeness","Betweenness"))
d <- data.frame(value = c(0.714, 0.668, 0.694),name = "Autovía A6", m = c("Degree","Closeness","Betweenness"))
e <- data.frame(value = c(0.756, 0.447, 0.725),name = "Motorway M40", m = c("Degree","Closeness","Betweenness"))

df <- rbind(a,b,c,d,e)

print(
  ggplot(data = df, aes(x = name, y = value)) +
    geom_point(aes(pch = factor(m)), size = 3)+
    labs(pch = "Measures")+
    ylab("Hellinger distance")+xlab("Scenarios")+
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme(legend.title=element_blank(),axis.text=element_text(size=12),axis.text.x = element_text(size=14), axis.title=element_text(size=22))+
    scale_y_continuous(limit = c(0, 1))+
    theme(legend.title=element_text(size=16), legend.text =element_text(size=14) )
  
)

