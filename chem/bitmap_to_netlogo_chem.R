library(tidyverse)
library(bmp)
library(pixmap)

files<-list.files(path = "/home/lauterbur/Desktop/AAUW_project/chem",pattern = "*.bmp",full.names = TRUE) 
maps<- files[which(!grepl("sig",files))] %>%
  map(~read.bmp(.))
maps
names(maps)<-files[which(!grepl("sig",files))]
maps

for (name in names(maps)) {
  #  print(i)
  b<-maps[[name]]
  m<-as.raster(b,max=255L)
  plot(1, type = "n", axes = FALSE, xlab = "", ylab = "")
  usr <- par("usr")
  rasterImage(m, usr[1], usr[3], usr[2], usr[4])
  
  dict<-setNames(c(38,9.9,63,45,95,114,56,15,1,103,34,25),unique(m))
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
