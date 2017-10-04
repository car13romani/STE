
ste.event<-function(X, out, expr){
  
  # read RasterStackTS from file X
  rt<-read.rts(X)

  # make string with metadata and query expression
  s <- c(md, ",", expr)
  
  # create file with string
  write(s, "expr.txt", ncolumns = 30)
  
  # call parser
  returned = try(system("../parser/teste05 < expr.txt", intern = TRUE))

  # copy data cube from output
  rt.r <- rt@raster
  
  # scanner all coverage series
  for(i in 1:(ncell(rt@raster))){
      vts <- as.numeric(extract(rt, i))
      rt.r[i] <- as.numeric(eval(parse(text = returned)))
  }  

  # creating a RasterStackTS object:
  rt.r <- rts(rt.r, as.Date(d))
  
  # write RasterStackTS in file out
  write.rts(rt.r, out, overwrite=TRUE)
  
  rm(expr, s)
}
