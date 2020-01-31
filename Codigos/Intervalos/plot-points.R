
plottt = function(agg,df,temp,measure){
  
  #PLOT ONE
  # create empty plot
  print((max(df[1], agg[1], temp[1])))
  plot(x=1:nrow(df), y=1:nrow(df), pch=NA, # plot some data but don't show it
       ylim=c(0, (max(df[1], agg[1], temp[1]) + 0.0001)),       # adjust y axis limit
       #xaxt="n", yaxt="n",                  # remove axes
       #bty="n",                             # remove box around plot
       xlab="Time", ylab="Minimum", main="")           # label axes and title
  

  points(x=1:nrow(df), y=df$V1, pch=15, col="black")#forestgreen
  points(x=1:nrow(df), y=df$V1, type="l")

  points(x=1:nrow(df), y=rep(agg[1],nrow(df)), type="l")
  points(x=1:nrow(df), y=rep(agg[1], max(nrow(df)) ), pch=19,  col="forestgreen")
  
  points(x=1:nrow(df), y=rep(temp[1],nrow(df)), type="l")
  points(x=1:nrow(df), y=rep(temp[1], max(nrow(df)) ), pch=19,  col="blue4")

  legend("topleft", legend = c("Aggregate", "Temporal", "Interval"),
         fill = c("forestgreen", "blue4", "black"), box.lty = 1, cex = 1, inset=c(0,-0.1), inlin, ncol = 2)
  
  
  # PLOT TWO
  plot(x=1:nrow(df), y=1:nrow(df), pch=NA, # plot some data but don't show it
       ylim=c(0, (max(df[2], agg[2], temp[2]) + 0.001)),       # adjust y axis limit
       #xaxt="n", yaxt="n",                  # remove axes
       #bty="n",                             # remove box around plot
       xlab="Time", ylab="Mean", main= measure, cex.main=2)           # label axes and title

  points(x=1:nrow(df), y=df$V2, type="l")
  points(x=1:nrow(df), y=df$V2, pch=19, col="black")

  points(x=1:nrow(df), y=rep(agg[2],nrow(df)), type="l")
  points(x=1:nrow(df), y=rep(agg[2], max(nrow(df)) ), pch=19,  col="forestgreen")

  points(x=1:nrow(df), y=rep(temp[2],nrow(df)), type="l")
  points(x=1:nrow(df), y=rep(temp[2], max(nrow(df)) ), pch=19,  col="blue4")

  print(max(df[3], agg[3], temp[3]))
  print(max(df[3], agg[3], temp[3]))
  plot(x=1:nrow(df), y=1:nrow(df), pch=NA, # plot some data but don't show it
       ylim=c(0, (max(df[3], agg[3], temp[3]) + 0.01)),       # adjust y axis limit
       #xaxt="n", yaxt="n",                  # remove axes
       #bty="n",                             # remove box around plot
       xlab="Time", ylab="Maximum", main="")           # label axes and title
  
  points(x=1:nrow(df), y=df$V3, type="l")
  points(x=1:nrow(df), y=df$V3, pch=19, col="black")
  
  points(x=1:nrow(df), y=rep(agg[3],nrow(df)), type="l")
  points(x=1:nrow(df), y=rep(agg[3], max(nrow(df)) ), pch=19,  col="forestgreen")
  
  points(x=1:nrow(df), y=rep(temp[3],nrow(df)), type="l")
  points(x=1:nrow(df), y=rep(temp[3], max(nrow(df)) ), pch=19,  col="blue4")
  
  
  

  # add back axes
  # axis(side=1, 1:nrow(df))
  # axis(side=2, 0:(ceiling(max(df))+2))
  
  # an example of how to add text
  #text(x=1:nrow(df), y=df$V3, labels=format(df$V3,digits=2), pos=3)
}



