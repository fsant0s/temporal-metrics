
he.distance <- function(p,q){
  D <- (1/sqrt(2))*(sqrt(sum((sqrt(p)-sqrt(q))^2)))
  return(D);
}

he.distance.hist <- function(pi,qi){
  p <- get.probabilities(pi);q <- get.probabilities(qi);
  D <- he.distance(p,q);
  
  print("kkkkkkkk")
  print(length(p))
  print(length(q))
  
  return(D);
}
# Generate probabilities
get.probabilities <- function(p_c){
  p <- p_c/sum(p_c); 
  return(p);
}

dA <- read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/semID/17-19/degreeAgregado.txt")
dT <- read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/semID/17-19/degreeTemporal.txt")

cA <- read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/semID/17-19/closAgregado.txt")
cT <- read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/semID/17-19/clsTemporal.txt")

bA <- read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/semID/17-19/btwAgregado.txt")
bT <- read.table("D:/Dropbox/Projeto Raquel/resultados-numericos/semID/17-19/btwTemp.txt")


#CalcHellingerDist(hist(dA$V1)$density,hist(dT$V1)$density)

# CalcHellingerDist(cA$V1,cT$V1)

h.dA <- hist(dA$V1, probability = T)
h.dT <- hist(dT$V1, probability = T)

h.cA <- hist(cA$V1, probability = T)
h.cT <- hist(cT$V1, probability = T)

h.bA <- hist(bA$V1, probability = T)
h.bT <- hist(bT$V1, probability = T)

#print(he.distance.hist(h.dA$density,h.dT$density))

#print(he.distance.hist(h.cA$density,h.cT$density))

print(he.distance.hist(h.bA$density,h.bT$density))
