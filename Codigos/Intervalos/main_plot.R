
source("plot.R")
source("plot-points.R")

a6_dg_int <- read.table("../../resultados-numericos/intervalos/a6-degreeInt.txt")
a6_dg_agg <- read.table("../../resultados-numericos/semID/A6/degreeAgregado.txt")
a6_dg_temp <- read.table("../../resultados-numericos/semID/A6/degreeTemporal.txt")

a6_cls_int <- read.table("../../resultados-numericos/intervalos/a6-clsInt.txt")
a6_cls_agg <- read.table("../../resultados-numericos/semID/A6/closAgregado.txt")
a6_cls_temp <- read.table("../../resultados-numericos/semID/A6//clsTemporal.txt")

a6_btw_int <- read.table("../../resultados-numericos/intervalos/a6-btwInt.txt")
a6_btw_agg <- read.table("../../resultados-numericos/semID/A6/btwAgregado.txt")
a6_btw_temp <- read.table("../../resultados-numericos/semID/A6/btwTemp.txt")

col_dg_int <- read.table("../../resultados-numericos/intervalos/col-degreeInt.txt")
col_dg_agg <- read.table("../../resultados-numericos/semID/col/degreeAgregado.txt")
col_dg_temp <- read.table("../../resultados-numericos/semID/col/degreeTemporal.txt")

col_cls_int <- read.table("../../resultados-numericos/intervalos/cologne-clsInt.txt")
col_cls_agg <- read.table("../../resultados-numericos/semID/col/closAgregado.txt")
col_cls_temp <- read.table("../../resultados-numericos/semID/col/clsTemporal.txt")

col_btw_int <- read.table("../../resultados-numericos/intervalos/col-btwInt.txt")
col_btw_agg <- read.table("../../resultados-numericos/semID/col/btwAgregado.txt")
col_btw_temp <- read.table("../../resultados-numericos/semID/col/btwTemp.txt")



fra79_dg_int <- read.table("../../resultados-numericos/intervalos/fra79-degreeInt.txt")
fra79_dg_agg <- read.table("../../resultados-numericos/semID/7-9/degreeAgregado.txt")
fra79_dg_temp <- read.table("../../resultados-numericos/semID/7-9/degreeTemporal.txt")

fra79_cls_int <- read.table("../../resultados-numericos/intervalos/fra79-clsInt.txt")
fra79_cls_agg <- read.table("../../resultados-numericos/semID/7-9/closAgregado.txt")
fra79_cls_temp <- read.table("../../resultados-numericos/semID/7-9/clsTemporal.txt")

fra79_btw_int <- read.table("../../resultados-numericos/intervalos/fra79-btwInt.txt")
fra79_btw_agg <- read.table("../../resultados-numericos/semID/7-9/btwAgregado.txt")
fra79_btw_temp <- read.table("../../resultados-numericos/semID/7-9/btwTemp.txt")



fra1719_dg_int <- read.table("../../resultados-numericos/intervalos/fra1719-degreeInt.txt")
fra1719_dg_agg <- read.table("../../resultados-numericos/semID/17-19/degreeAgregado.txt")
fra1719_dg_temp <- read.table("../../resultados-numericos/semID/17-19/degreeTemporal.txt")

fra1719_cls_int <- read.table("../../resultados-numericos/intervalos/fra1719-clsInt.txt")
fra1719_cls_agg <- read.table("../../resultados-numericos/semID/17-19/closAgregado.txt")
fra1719_cls_temp <- read.table("../../resultados-numericos/semID/17-19/clsTemporal.txt")

fra1719_btw_int <- read.table("../../resultados-numericos/intervalos/fra1719-btwInt.txt")
fra1719_btw_agg <- read.table("../../resultados-numericos/semID/17-19/btwAgregado.txt")
fra1719_btw_temp <- read.table("../../resultados-numericos/semID/17-19/btwTemp.txt")




m40_dg_int <- read.table("../../resultados-numericos/intervalos/m40-degreeInt.txt")
m40_dg_agg <- read.table("../../resultados-numericos/semID/M40/degreeAgregado.txt")
m40_dg_temp <- read.table("../../resultados-numericos/semID/M40/degreeTemporal.txt")

m40_cls_int <- read.table("../../resultados-numericos/intervalos/m40-clsInt.txt")
m40_cls_agg <- read.table("../../resultados-numericos/semID/M40/closAgregado.txt")
m40_cls_temp <- read.table("../../resultados-numericos/semID/M40/clsTemporal.txt")

m40_btw_int <- read.table("../../resultados-numericos/intervalos/m40-btwInt.txt")
m40_btw_agg <- read.table("../../resultados-numericos/semID/M40/btwAgregado.txt")
m40_btw_temp <- read.table("../../resultados-numericos/semID/M40/btwTemp.txt")


#PRECISA NORMALIZAR OS VALORES DO A6_CLS_AGG.

measure <- "Créteil 5PM-7PM: closeness" #degree\n"#closeness\n" #betweenness\n"
agg <- fra1719_cls_agg$V1 
temp <-fra1719_cls_temp$V1
df_int <- fra1719_cls_int

c_agg <- c(min(agg), mean(agg), max(agg))
c_temp <- c(min(temp), mean(temp), max(temp))

# all <- data.frame(agg = c_agg[3], temp = c_temp[3])
# all <- as.data.frame(lapply(all, rep, nrow(df_int)))
# all$int <- df_int$V3
# all <- t(all)

par(mfrow=c(1,3), par(mar=c(4.5, 4.5, 4.1, 2.1) ))


#plott(all, c_agg, df_int, c_temp)
plottt(c_agg, df_int, c_temp,measure)



