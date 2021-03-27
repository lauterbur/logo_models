library(tidyverse)
library(bmp)
library(pixmap)

b <- read.bmp("/home/lauterbur/Desktop/TownTechMap_Base.bmp")
b
m<-as.raster(b,max=255L)
m

plot(1, type = "n", axes = FALSE, xlab = "", ylab = "")
usr <- par("usr")
rasterImage(m, usr[1], usr[3], usr[2], usr[4])

dict<-setNames(c(seq(2,112,10)),unique(m))
dict
m_vec<-matrix(unname(dict[as.vector(m)]), nrow=nrow(m),byrow=TRUE)
m_vec

coords<-data.frame(x=as.vector(col(map_matrix)),y=as.vector(row(map_matrix)),color=as.vector(map_matrix))
coords<-t(coords)
coords[3,]

m
write.table(coords,"/home/lauterbur/Desktop/TownTechMap_netlogo.txt",row.names=FALSE,col.names=FALSE)
