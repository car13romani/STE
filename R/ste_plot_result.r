library(rasterVis)


ste.plot_result <- function(X){
  # read RasterStackTS from file X
  rt <- read.rts(X)
  r <- rt@raster
  
  dates <- c('2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016')
  
  myKey2 <- list(rectangles=list(col = c("#000000", "#FFFFFF")),text=list(lab=c('True', 'False')),
                space='bottom',
                font=.5,
                width=.4,
                columns=1)
  
  levelplot(r, col.regions = c("#FFFFFF","#000000"), colorkey=FALSE, key = myKey2, names.attr = substr(d, 1, 4), scales=list(draw=FALSE))
}

