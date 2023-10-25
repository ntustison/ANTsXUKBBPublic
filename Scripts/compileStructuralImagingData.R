baseDirectory <- '/Users/ntustison/Data/Public/UKBiobank/ukbiobank/'

demo <- read.csv( paste0( baseDirectory, "ukb50588_imaging_only.csv" ) )

fieldFiles <- list.files(baseDirectory, "ukb_.*fields.csv")

for( i in seq.int( length( fieldFiles ) ) )
  {
  fieldFile <- fieldFiles[i]
  outputFile <- sub( "_fields", "", fieldFile )
  outputFile <- sub( "ukb", "ukb50588", outputFile )
  outputMissingFile <- sub( ".csv", "_missingfields.csv", outputFile )
  outputDemoFile <- sub( ".csv", "_demofields.csv", outputFile )

  cat( fieldFile, " -> ", outputFile, "\n" )

  fields <- read.csv( fieldFile )

  fields1 <- paste0( "f.", fields$Field.ID, ".2.0" )
  fields2 <- paste0( "f.", fields$Field.ID, ".3.0" )

  fieldsForDemo <- c( rbind( fields1, fields2 ) )

  missingFields <- NULL
  missingFields$Field.ID <- fieldsForDemo[which( ! fieldsForDemo %in% colnames( demo ) )] 
  missingFields$Field.ID <- sub( "f\\.", "", missingFields$Field.ID )
  missingFields$Field.ID <- sub( "\\.2\\.0", "", missingFields$Field.ID )
  missingFields$Field.ID <- sub( "\\.3\\.0", "", missingFields$Field.ID )
  missingFields$Description <- fields$Description[which( fields$Field.ID %in% missingFields$Field.ID )] 
  missingFields <- as.data.frame( missingFields )
  write.csv( missingFields, outputMissingFile, quote = FALSE, row.names = FALSE )

  fieldsForDemo <- fieldsForDemo[which( fieldsForDemo %in% colnames( demo ) )]
  demoTrimmed <- demo[, fieldsForDemo]
  write.csv( demoTrimmed, outputFile, row.names = FALSE, quote = FALSE )

  presentFields <- NULL
  presentFields$Field.ID <- fieldsForDemo[which( fieldsForDemo %in% colnames( demo ) )] 
  presentFields$Field.ID <- sub( "f\\.", "", presentFields$Field.ID )
  presentFields$Field.ID <- sub( "\\.2\\.0", "", presentFields$Field.ID )
  presentFields$Field.ID <- sub( "\\.3\\.0", "", presentFields$Field.ID )
  presentFields$Description <- fields$Description[which( fields$Field.ID %in% presentFields$Field.ID )] 
  presentFields <- as.data.frame( presentFields )
  write.csv( presentFields, outputDemoFile, quote = FALSE, row.names = FALSE )
  }

