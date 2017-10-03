# timeSeries tiff preparation
#X = "clip4_rt"
#path = "/home/carlos/Dropbox/MESTRADO/STE/example"
library(rts)

ste.import <- function(X,path){
  
  # location of files
  setwd(path)
   
  #the tiff files must be arranged sequentially in time and placed in the images subfolder
  path.raster <- paste(path, "/raster", sep='')
  
  # list of raster files:
  lst <- list.files(path=path.raster,pattern='.tif$',full.names=TRUE)
  
  # creating a RasterStack object
  r <- stack(lst)
  
  # import dates from file "dates.txt" with the dates for each image
  dates <-read.table(file="dates.txt",header=F)
  d <- as.character(dates$V1)
  d.d <- as.Date(d)
  
  # save dates in format YYYYMMDD
  as.year <- function(x) (as.numeric(floor(as.yearmon(x))))*10000
  y <<- as.year(d.d)
 
  # creating a RasterStackTS object:
  rt <- rts(r,d.d)

  # write RasterStackTS in file X
  write.rts(rt,X, overwrite=TRUE)
  d <<- d
  
  # import from file "metadata.txt" the patterns and Digital Number
  md <-read.table(file="metadata.txt",header=F,sep=",")
  
  pattern <<- as.character(md$V2)
  
  md <<- paste(as.character(md$V1),md$V2,sep=" . ")
  
  rm(lst,d,r,path,as.year)
  
}
