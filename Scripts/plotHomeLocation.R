library( ggmap )
library( geosphere )

baseDirectory <- "../Data/ukbiobank/"

data <- read.csv( paste0( baseDirectory, "ukb47304_imaging_only_Brian.csv" ) )
data <- data[which( ! is.na( data$Longitude ) ),]

numberOfSubjectsToPlot <- 5000
subjectIndices <- sample.int( nrow( data ), size = numberOfSubjectsToPlot )
plotData <- data[subjectIndices,]

ukMapFile <- "./ukMap.RData"
if( file.exists( ukMapFile ) )
  {
  load( ukMapFile )
  } else {
  ukMap <- get_map( location = "Great Britain", source = "google", maptype = "terrain", zoom = 5 )
  }

plotData$photoPeriod <- daylength( plotData$Latitude, plotData$f.53.2.0 )

ukPlot <- ggmap( ukMap ) + 
             geom_point( aes( x = Longitude, y = Latitude, color = photoPeriod ), data = plotData, alpha = 0.3, size = 2 ) +
             scale_colour_gradientn( colours = rev( c( 'gold', 'orange', 'red', 'darkred', 'red4', 'black'  ) ) ) +
             xlab( "Longitude" ) + 
             ylab( "Latitude" )
ggsave( paste0( baseDirectory, "ukbbMap.pdf" ), ukPlot, units = "in", width = 10, height = 10 )

