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

dict<-setNames(c(7,9.9,115,66,15,95,87,1,45,62,33,103),unique(m))
dict
m_matrix<-matrix(unname(dict[as.vector(m)]), nrow=nrow(m),byrow=TRUE)
m_matrix

coords<-data.frame(x=as.vector(col(m_matrix)),y=rev(as.vector(row(m_matrix))),color=as.vector(m_matrix))
coords<-t(coords)
coords[3,]

m
write.table(coords,"/home/lauterbur/Desktop/TownTechMap_netlogo.txt",row.names=FALSE,col.names=FALSE)
