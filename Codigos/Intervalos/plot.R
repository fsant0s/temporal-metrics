
plott = function(all, agg, df,temp){

  
  plot(x = 1:ncol(df))
  #Define a set of colors
  my_colors <- c("black", "DarkGray", "Gainsboro")
  # Bar plot
  barplot(all, col = my_colors, beside = TRUE, names.arg = 1:ncol(all))
  # Add legend
  legend("topleft", legend = c("Aggregate", "Temporal", "Intervals"),
         fill = my_colors, box.lty = 0, cex = 0.8)

  
  
}



