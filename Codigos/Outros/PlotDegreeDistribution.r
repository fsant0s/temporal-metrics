library(igraph)

fit_power_law = function(dg, dgDist,x,y,subtitle,cenario) {
  main <- paste("Degree Distribution:", cenario)
  subtitle <- subtitle
  t <- c(x,y)
  # calculate degree
  d = dg
  dd = dgDist
  degree = 1:max(d)
  probability = dd[-1]
  # delete blank values
  nonzero.position = which(probability != 0)
  probability = probability[nonzero.position]
  degree = degree[nonzero.position]
  
  #Power Law
  reg = lm(log(probability) ~ log(degree))
  cozf = coef(reg)
  power.law.fit = function(x) exp(cozf[[1]] + cozf[[2]] * log(x))
  
  alpha = -cozf[[2]]
  R.square = summary(reg)$r.squared
  print(paste("Alpha =", round(alpha, 3)))
  print(paste("R square =", round(R.square, 3)))
  
  df2 <- data.frame(degree, dens = dpois(degree, lambda = mean(dgDist)))#Poisson
  
  df <- data.frame(x = degree, y = probability)#Power law
  
    ggplot(df, aes(x,y))+
      
      geom_point(aes(group = 1), shape = 16) +
      
      #stat_function(fun = power.law.fit, linetype=2)+
      
      guides(shape = FALSE,
             colour = guide_legend(override.aes = list(shape = c(16),
                                                       linetype = c("dashed"))))+
      
      scale_y_continuous(trans = "log")+
      scale_x_continuous(trans = "log",labels = function(x) round(x))+ #erro nao função round,procure a função com a escrita correta, estou com sono!
      scale_y_continuous(limits = c(0,0.04))+
  
      annotation_logticks(sides = "trbl")+
      
      theme(axis.title.x = element_text(face = 2, size = 28),
            axis.title.y = element_text(face = 2, size = 28),
            plot.subtitle = element_text( size=28, face="bold"),
            axis.text=element_text(size=28)  )+
      
      labs( subtitle = subtitle,
           x="K", y="P(k)")+
      scale_color_brewer(palette="Dark2")
    
  #SHAPE > http://sape.inf.usi.ch/quick-reference/ggplot2/shape
  
}







