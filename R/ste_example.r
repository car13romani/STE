
#pathCode <- '~/Dropbox/MESTRADO/STE/R'
ste.example <- function(pathCode){

source(paste(pathCode, "/ste_import.r", sep=''))
source(paste(pathCode, "/ste_event.r", sep=''))
source(paste(pathCode, "/ste_plot_input.r", sep=''))
source(paste(pathCode, "/ste_plot_result.r", sep=''))


#ste.import("name_rasterTimeSeries", "path_imagesAndMetadata")
ste.import("rts_example",'~/Dropbox/MESTRADO/STE/example')


#ste.event("name_rasterTimeSeries",name_rasterQueryResult","queryString")
ste.event("rts_example", "rts_example_out", "meetby(Fallow_Cotton, 2006)&before(Fallow_Cotton, 2012)")


ste.plot_input("rts_example")

ste.plot_result("rts_example_out")


#ste.event("clip4_rt", "clip4_out", "before(Fallow_Cotton, 2010)")

#ste.event("rt_clip4_rt", "clip4_out", "meetby(Fallow_Cotton, 2006)")

#ste.event("rt_clip4_rt", "clip4_out", "during(Fallow_Cotton, 2005,2012)")

#ste.event("rt_clip4_rt", "clip4_out", "after(Pasture_2, 2006)")
}



# query expression
#expr <- "before(Fallow_Cotton,2010)|meetby(NonComerc_Cotton,2011)"
#expr <- "before(Fallow_Cotton,2010)"
#expr <- "after(NonComerc_Cotton,2011)"
#expr <- "meetby(Pasture_2,2001)|meetby(Fallow_Cotton,2005)|before(Fallow_Cotton,2005)"
#expr <- "before(Fallow_Cotton,2005)|after(NonComerc_Cotton,2010)"
#expr <- "meetby(Pasture_2, 2003)&meets(Pasture_2, 2010)"
#expr <- "during(Pasture_2, 2003,2010)"
#expr <- "EQUALS(Pasture_2, 2003,2010)"