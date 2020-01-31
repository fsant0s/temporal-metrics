
plottt = function(agg,df,temp){
  
  # create empty plot
  print(max(df[2], agg[2], temp[2]))
  plot(x=1:nrow(df), y=1:nrow(df), pch=NA, # plot some data but don't show it
       ylim=c(0, (max(df[2], agg[2], temp[2]) + 0.001)),       # adjust y axis limit
       #xaxt="n", yaxt="n",                  # remove axes
       #bty="n",                             # remove box around plot
       xlab="", ylab="", main="")           # label axes and title
  
  # Plot Intervalos
  #add horizontal lines
  points(x=1:nrow(df), y=df$V2, type="l")
  #add points
  #oints(x=1:nrow(df), y=df$V1, pch=15, col="black")#forestgreen
  points(x=1:nrow(df), y=df$V2, pch=19, col="black")
  #points(x=1:nrow(df), y=df$V3, pch=8,  col="black")
  # add vertical lines
  #for(i in 1:nrow(df)) {
  #  points(x=c(i,i), y=c(df$V1[i], df$V3[i]), type="l")
  #}
  
  # add horizontal lines
  points(x=1:nrow(df)+t, y=rep(agg[2],nrow(df)), type="l")
  # add points agg
  # points(x=1:nrow(df)+t, y=rep(agg[1], max(nrow(df)) ), pch=15,  col="forestgreen")
  points(x=1:nrow(df), y=rep(agg[2], max(nrow(df)) ), pch=19,  col="forestgreen")
  # points(x=1:nrow(df)+t, y=rep(agg[3], max(nrow(df)) ), pch=8,  col="forestgreen")
  # #add vertical lines
  # for(i in 1:nrow(df)) {
  #  points(x=c(i,i)+t, y=c(agg[1], agg[3]), type="l")
  # }

  # add horizontal lines
  points(x=1:nrow(df)+t, y=rep(temp[2],nrow(df)), type="l")
  # # add points temp
  # points(x=1:nrow(df)+t, y=rep(temp[1], max(nrow(df)) ), pch=15,  col="blue4")
  points(x=1:nrow(df)+t, y=rep(temp[2], max(nrow(df)) ), pch=19,  col="blue4")
  # points(x=1:nrow(df)+t, y=rep(temp[3], max(nrow(df)) ), pch=8,  col="blue4")
  # # add vertical lines
  # for(i in 1:nrow(df)) {
  #  points(x=c(i,i)+t, y=c(temp[1], temp[3]), type="l")
  # }

  #legend("topleft", legend = c("Aggregate", "Temporal", "Intervals"),
  #       fill = my_colors, box.lty = 0, cex = 0.8)
  
  
  # add back axes
  # axis(side=1, 1:nrow(df))
  # axis(side=2, 0:(ceiling(max(df))+2))
  
  # an example of how to add text
  #text(x=1:nrow(df), y=df$V3, labels=format(df$V3,digits=2), pos=3)
}



