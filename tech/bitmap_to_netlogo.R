library(tidyverse)
library(bmp)
library(pixmap)

b <- read.bmp("/home/lauterbur/Desktop/AAUW_project/tech/TownTechMap_Base.bmp")
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

files<-list.files(path = "/home/lauterbur/Desktop/AAUW_project/tech/wifi_maps/",pattern = "*.bmp",full.names = TRUE) 
maps<- files[which(!grepl("sig",files))] %>%
  map(~read.bmp(.))
maps
names(maps)<-files[which(!grepl("sig",files))]
maps

hex<-c( "#C3C3C3","#FFFFFF","#A349A4","#B5E61D","#ED1C24","#00A2E8","#99D9EA","#000000","#FFF200","#22B14C","#880015","#3F48CC",
        "#FF7F27","#D952FS","#DA51F7","#DE51F7","#D952F5","#DC53F4","#DD52F5")
dict<-setNames(c(7,9.9,115,55,15,95,85,1,45,63,33,105,25,125,125,125,125,125,125),hex)
for (name in names(maps)) {
  #  print(i)
  b<-maps[[name]]
  m<-as.raster(b,max=255L)
  plot(1, type = "n", axes = FALSE, xlab = "", ylab = "")
  usr <- par("usr")
  rasterImage(m, usr[1], usr[3], usr[2], usr[4])
  
  dict
  m_matrix<-matrix(unname(dict[as.vector(m)]), nrow=nrow(m),byrow=TRUE)
  m_matrix
  
  coords<-data.frame(x=as.vector(col(m_matrix)),y=rev(as.vector(row(m_matrix))),color=as.vector(m_matrix))
  coords<-t(coords)
  coords[3,]
  m
  newname<-str_remove(name,".bmp")
  write.table(coords,paste(newname,".txt",sep=""),row.names=FALSE,col.names=FALSE)
  
}
