baseDirectory <- '/Users/ntustison/Data/Public/UKBiobank/ukbiobank/'

demographicsFile <- paste0( baseDirectory, "ukb47304.tab" )
readConnection <- file( demographicsFile, "r" )
line <- readLines( readConnection, 1 )

outputFile <- paste0( baseDirectory, "ukb47304_trimmed.csv" )
writeConnection <- file( outputFile, "w" ) 

tokens <- strsplit( line, "\t" )[[1]]
writeLines( paste0( tokens, collapse = "," ), writeConnection )

pb <- txtProgressBar( min = 0, max = 502464, style = 3 )

count <- 0
while( count < 502464 )
  {
  setTxtProgressBar( pb, count )    
  line <- readLines( readConnection, 1 )
  if( length( line ) == 0 )
    {
    break    
    }
  tokens <- strsplit( line, "\t", )[[1]]  
  imaging <- tokens[12032]
  if( imaging != "NA" )
    {
    writeLines( paste( tokens, collapse = "," ), writeConnection )
    }
  count <- count + 1
  }



