library(tidyverse)
library(bmp)
library(pixmap)

files<-list.files(path = "/home/lauterbur/Desktop/AAUW_project/wifi_maps",pattern = "*.bmp",full.names = TRUE) 
maps<- files[which(!grepl("sig",files))] %>%
  map(~read.bmp(.))
maps
names(maps)<-files[which(!grepl("sig",files))]
maps

sigfiles<-list.files("/home/lauterbur/Desktop/AAUW_project/wifi_maps/",pattern = "*sig.txt",full.names = TRUE)
sigmaps<- sigfiles %>%
  map(~read_csv(.,col_names = FALSE))
sigmaps
names(sigmaps)<-sigfiles
sigmaps

for (name in names(maps)) {
#  print(i)
  b<-maps[[name]]
  m<-as.raster(b,max=255L)
  plot(1, type = "n", axes = FALSE, xlab = "", ylab = "")
  usr <- par("usr")
  rasterImage(m, usr[1], usr[3], usr[2], usr[4])
  
  dict<-setNames(c(7,9.9,115,66,15,95,87,95,1,45,62,33,103,125),unique(m))
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

for (name in names(sigmaps)) {
  #  print(i)
  b<-sigmaps[[name]]
  #b<-as.raster(b,max=255L)
  # 
  # dict<-setNames(c(7,9.9,115,66,15,95,87,95,1,45,62,33,103,125),unique(m))
  # dict
  # m_matrix<-matrix(unname(dict[as.vector(m)]), nrow=nrow(m),byrow=TRUE)
  m_matrix<-as.matrix(b)
  
  coords<-data.frame(x=as.vector(col(m_matrix)),y=rev(as.vector(row(m_matrix))),color=as.vector(m_matrix))
  coords<-t(coords)
  coords[3,]
  
  newname<-str_remove(name,".txt")
  write.table(coords,paste(newname,"_netlogo.txt",sep=""),row.names=FALSE,col.names=FALSE)
  
}

# 
# m
# 
# b <- read.bmp(file)
# b
# 
# m<-as.raster(b,max=255L)
# m
# 
# plot(1, type = "n", axes = FALSE, xlab = "", ylab = "")
# usr <- par("usr")
# rasterImage(m, usr[1], usr[3], usr[2], usr[4])
# 
# dict<-setNames(c(7,9.9,115,66,15,95,87,1,45,62,33,103),unique(m))
# dict
# m_matrix<-matrix(unname(dict[as.vector(m)]), nrow=nrow(m),byrow=TRUE)
# m_matrix
# 
# coords<-data.frame(x=as.vector(col(m_matrix)),y=rev(as.vector(row(m_matrix))),color=as.vector(m_matrix))
# coords<-t(coords)
# coords[3,]
# 
# m
# write.table(coords,"/home/lauterbur/Desktop/TownTechMap_netlogo.txt",row.names=FALSE,col.names=FALSE)
