library(rasterVis)

#X <- "clip_4"
ste.plot_input <- function(X){
# read RasterStackTS from file X
rt <- read.rts(X)
r <- rt@raster

colors1 <- c('palegreen', 'midnightblue', 'indianred1', 'gold','deepskyblue', 'deeppink', 
             'blue','red','darkgreen', 'darkgray', 'darkmagenta','goldenrod4', 'darkred', 'chartreuse1', 'deeppink', 'darkgreen')

#test (acrescentar no parser)
pattern2 <- c("Fallow_Cotton","NonComerc_Cotton","Pasture_2","Savanna","Soybean_Fallow_1","Soybean_NonComerc_1","Soybean_Pasture")
colors2 <- c('palegreen', 'gold','deeppink','red','darkmagenta','blue', 'darkgreen')


myKey <- list(rectangles=list(col = colors2),text=list(lab=pattern2),
              space='bottom',
              font=.5,
              width=.4,
              columns=3)
levelplot(r, col.regions=colors1, colorkey=FALSE,key = myKey, names.attr = dates, scales=list(draw=FALSE), pretty=FALSE)
}

