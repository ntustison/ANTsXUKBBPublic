baseDirectory <- "../Data/ukbiobank/ExperimentalResults/LinearModel90PercentTrainingData/"

variables <- c( "Age", "FluidIntelligenceScore", "NeuroticismScore", "NumericMemory", "BMI", "TownsendDeprivationIndex" )

for( v in seq.int( length( variables ) ) )
  {
  csvFiles <- list.files( path = baseDirectory, full.names = TRUE, pattern = paste0( ".*_lm_.*", variables[v], ".*.csv" ) )

  cat( variables[v], "\n" )
  cat( "==================\n" )
  for( i in seq.int( from = length( csvFiles ), to = 1, by = -1 ) )
    {
    csvData <- read.csv( csvFiles[i] )
    rsquared <- mean( csvData$RSquared )
    if( ! is.na( rsquared ) ) 
      {
      baseFilename <- basename( csvFiles[i] ) 
      baseTokens <- strsplit( baseFilename, "_" )
      baseTokens[[1]][length( baseTokens[[1]] )] <- sub( ".csv", "", baseTokens[[1]][length( baseTokens[[1]] )] )
      cat( "R^2_{", baseTokens[[1]][length( baseTokens[[1]] )], "} = ", round( rsquared, digits = 2 ), "\n", sep = "" )
      }
    }
  cat( "==================\n\n" )
  }