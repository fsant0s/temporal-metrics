
dA <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/resutados - NUMÉRICOS/M40/degreeAgregado.txt")
dT <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/resutados - NUMÉRICOS/M40/degreeTemporal.txt")

cA <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/resutados - NUMÉRICOS/M40/closAgregado.txt")
cT <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/resutados - NUMÉRICOS/M40/clsTemporal.txt")

bA <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/resutados - NUMÉRICOS/M40/btwAgregado.txt")
bT <- read.table("C:/Users/Filli/Dropbox/Projeto Raquel/resutados - NUMÉRICOS/M40/btwTemp.txt")

dA <- sort(dA$V1)
dT <- sort(dT$V1)

cA <- sort(cA$V1)
cT <- sort(cT$V1)

bA <- sort(bA$V1)
bT <- sort(bT$V1)

# shapiro.test(dA)
# shapiro.test(dT)
# shapiro.test(cA)
# shapiro.test(cT)
# shapiro.test(bA)
# shapiro.test(bT)

#wilcox.test(x paired = TRUE, conf.level = 0.95, conf.int = TRUE, exact = FALSE)

a <- wilcox.test(dA, conf.level = 0.95, conf.int = TRUE, exact = FALSE)
wilcox.test(dT, conf.level = 0.95, conf.int = TRUE, exact = FALSE)
wilcox.test(cA, conf.level = 0.95, conf.int = TRUE, exact = FALSE)
wilcox.test(cT, conf.level = 0.95, conf.int = TRUE, exact = FALSE)
wilcox.test(bA, conf.level = 0.95, conf.int = TRUE, exact = FALSE)
wilcox.test(bT, conf.level = 0.95, conf.int = TRUE, exact = FALSE)

boxplot(a)


