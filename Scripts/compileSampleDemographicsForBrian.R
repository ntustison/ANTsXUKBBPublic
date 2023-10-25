baseDirectory <- '/Users/ntustison/Data/Public/UKBiobank/ukbiobank/'

demo <- read.csv( paste0( baseDirectory, "ukb50844_imaging_only.csv" ) )

fieldPairs <- c(
  "ReportedSex", "31.0.0",
  "GeneticSex", "22001.0.0",
  "Handedness", "1707.0.0",
  "YearOfBirth", "34.0.0",
  "MonthOfBirth", "52.0.0",
  "BirthWeight", "20022.0.0",
  "EthnicBackground", "21000.0.0",
  "TownsendDeprivationIndex", "189.0.0",

  "RiskTaking", "2040.2.0",
  "SameSexIntercourse", "2159.2.0",
  "NonviablePregnancy", "2774.2.0",
  "Pregnant", "3140.2.0",

  "EverSelfHarmed", "20480.0.0",
  "MentalHealthDiagnosis", "20544.0.1",
  "EverTakenCannabis", "20453.0.0",
  "NumberOfDepressedPeriods", "20442.0.0",
  "ProlongedSadnessOrDepression", "20446.0.0",
  "AnxiousForMonthOrLonger", "20421.0.0",
  "DurationOfWorstDepression", "20438.0.0",

  "AgeCompletedFullTimeEducation", "845.0.0",
  "NeuroticismScore", "20127.0.0",
  "FluidIntelligenceScore", "20191.0.0",
  "NumericMemory", "20240.0.0",

  "DateOfImagingVisit1", "53.2.0",
  "DateOfImagingVisit2", "53.3.0",
  "HomeLocationEastCoordinateRoundedAtImagingVisit1", "20074.2.0",
  "HomeLocationNorthCoordinateRoundedAtImagingVisit1", "20075.2.0",
  "EuclideanDistanceToCoast", "24508.0.0",
  "UKBiobankAssessmentCenterAtImagingVisit1", "54.2.0",
  "UKBiobankAssessmentCenterAtImagingVisit2", "54.3.0",

  "AgeAtImagingVisit1", "21003.2.0",
  "AgeAtImagingVisit2", "21003.3.0",
  "WeightAtImagingVisit1", "12143.2.0",
  "WeightAtImagingVisit2", "12143.3.0",
  "HeightAtImagingVisit1", "12144.2.0",
  "HeightAtImagingVisit2", "12144.3.0",
  "BodyMassIndexAtImagingVisit1", "21001.2.0",
  "BodyMassIndexAtImagingVisit2", "21001.3.0",
  "WaistCircumferenceAtImagingVisit1", "48.2.0",
  "WaistCircumferenceAtImagingVisit2", "48.3.0",
  "HipCircumferenceAtImagingVisit1", "49.2.0",
  "HipCircumferenceAtImagingVisit2", "49.2.0",
  "AlcoholUseFrequencyAtImagingVisit1", "1558.2.0",
  "AlcoholUseFrequencyAtImagingVisit2", "1558.3.0",
  "OverallHealthRatingAtImagingVisit1", "2178.2.0",
  "OverallHealthRatingAtImagingVisit2", "2178.3.0",
  "SystolicBloodPressureAtImagingVisit1", "93.2.0",
  "SystolicBloodPressureAtImagingVisit2", "93.3.0",
  "DiastolicBloodPressureAtImagingVisit1", "94.2.0",
  "DiastolicBloodPressureAtImagingVisit2", "94.3.0",
  "PulseRateAtImagingVisit1", "102.2.0",
  "PulseRateAtImagingVisit2", "102.3.0",
  "SpeechReceptionThresholdEstimateLeftAtImagingVisit1", "20019.2.0",
  "SpeechReceptionThresholdEstimateLeftAtImagingVisit2", "20019.3.0",
  "SpeechReceptionThresholdEstimateRightAtImagingVisit1", "20021.2.0",
  "SpeechReceptionThresholdEstimateRightAtImagingVisit2", "20021.3.0",

  # c( rbind( paste0( "GeneticPrinicipalComponent", paste0( c( 1:40 ) ) ),  
  #           paste0( "220009.0.", c( 1:40 ) ) ) ),

  "TouchscreenDurationAtImagingVisit1", "630.2.0",
  "TouchscreenDurationAtImagingVisit2", "630.3.0",
  "AverageTotalHouseholdIncomeBeforeTaxAtImagingVisit1", "738.2.0",
  "AverageTotalHouseholdIncomeBeforeTaxAtImagingVisit2", "738.3.0",
  "NumberOfDaysPerWeekWalkedTenPlusMinutesAtImagingVisit1", "864.2.0",
  "NumberOfDaysPerWeekWalkedTenPlusMinutesAtImagingVisit2", "864.3.0",
  "TimeSpentWatchingTelevisionAtImagingVisit1", "1070.2.0",
  "TimeSpentWatchingTelevisionAtImagingVisit2", "1070.3.0",
  "TimeSpentUsingComputerAtImagingVisit1", "1080.2.0",
  "TimeSpentUsingComputerAtImagingVisit2", "1080.3.0",
  "SleepDurationAtImagingVisit1", "1160.2.0",
  "SleepDurationAtImagingVisit2", "1160.3.0",
  "GettingUpInTheMorningAtImagingVisit1", "1170.2.0",
  "GettingUpInTheMorningAtImagingVisit2", "1170.3.0",
  "CurrentTobaccoSmokingAtImagingVisit1", "1239.2.0",
  "CurrentTobaccoSmokingAtImagingVisit2", "1239.3.0",
  "PastTobaccoSmokingAtImagingVisit1", "1249.2.0",
  "PastTobaccoSmokingAtImagingVisit2", "1249.3.0",
  "ExposureToTobaccoSmokeAtHomeAtImagingVisit1", "1269.2.0",
  "ExposureToTobaccoSmokeAtHomeAtImagingVisit2", "1269.3.0",
  "ExposureToTobaccoSmokeOutsideHomeAtImagingVisit1", "1269.2.0",
  "ExposureToTobaccoSmokeOutsideHomeAtImagingVisit2", "1269.3.0",

  "VolumeOfBrainAtImagingVisit1", "25010.2.0",
  "VolumeOfBrainAtImagingVisit2", "25010.3.0",
  "VolumeOfVentricularCSFAtImagingVisit1", "25004.2.0",
  "VolumeOfVentricularCSFAtImagingVisit2", "25004.3.0",
  "VolumeOfGreyMatterAtImagingVisit1", "25006.2.0",
  "VolumeOfGreyMatterAtImagingVisit2", "25006.3.0",
  "VolumeOfWhiteMatterAtImagingVisit1", "25007.2.0",
  "VolumeOfWhiteMatterAtImagingVisit2", "25007.3.0",
  "MeanfMRIHeadMotionAtImagingVisit1", "25742.2.0",
  "MeanfMRIHeadMotionAtImagingVisit2", "25742.3.0",

  "logMARFinalLeft", "5208.0.0",
  "logMARFinalRight", "5201.0.0",
 
  "HearingDifficultiesAtImagingVisit1", "2247.2.0",
  "HearingDifficultiesAtImagingVisit2", "2247.3.0",
  "HearingDifficultiesWithBackgroundNoiseAtImagingVisit1", "2257.2.0",
  "HearingDifficultiesWithBackgroundNoiseAtImagingVisit2", "2257.3.0",

  "PairsTestRound1.CorrectMatches", "20131.0.0",
  "PairsTestRound2.CorrectMatches", "20131.0.1",
  "PairsTestRound3.CorrectMatches", "20131.0.2",
  "PairsTestRound1.IncorrectMatches", "20132.0.0",
  "PairsTestRound2.IncorrectMatches", "20132.0.1",
  "PairsTestRound3.IncorrectMatches", "20132.0.2",
  "PairsTestRound1.ElapsedTime", "20133.0.0",
  "PairsTestRound2.ElapsedTime", "20133.0.1",
  "PairsTestRound3.ElapsedTime", "20133.0.2",
  "DurationTrailMaking1", "20156.0.0",
  "DurationTrailMaking2", "20157.0.0"

  )

fieldNames <- c( "Subject", fieldPairs[seq.int( 1, length( fieldPairs ), by = 2 )] )
fieldIds <- fieldPairs[seq.int( 2, length( fieldPairs ), by = 2 )]
xfieldIds <- c( "f.eid", paste0( "f.", fieldIds ) )

isMissing <- FALSE
for( i in seq.int( length( xfieldIds ) ) )
  {
  if( ! xfieldIds[i] %in% colnames( demo ) )
    {
    cat( xfieldIds[i], " (", fieldNames[i], ")", " not in demo.\n" ) 
    isMissing <- TRUE
    }  
  }
if( isMissing )
  {
  stop( "Missing" )
  }


demoTrimmed <- demo[, xfieldIds]
# colnames( demoTrimmed ) <- fieldNames 

fatherIllnesses <- demo[, 8610:8649]
fatherAlzheimers <- rep( NA, nrow( fatherIllnesses ) )
fatherParkinsons <- rep( NA, nrow( fatherIllnesses ) )
fatherDepression <- rep( NA, nrow( fatherIllnesses ) )
pb <- txtProgressBar( min = 0, max = nrow( fatherIllnesses ), style = 3 )
for( i in seq.int( nrow( fatherIllnesses ) ) )
  {
  setTxtProgressBar( pb, i )
  fatherAlzheimers[i] <- as.numeric( 10 %in% fatherIllnesses[i,] )  
  fatherParkinsons[i] <- as.numeric( 11 %in% fatherIllnesses[i,] )  
  fatherDepression[i] <- as.numeric( 12 %in% fatherIllnesses[i,] )  
  }
cat( "\n" )  

motherIllnesses <- demo[, 8705:8748]
motherAlzheimers <- rep( NA, nrow( motherIllnesses ) )
motherParkinsons <- rep( NA, nrow( motherIllnesses ) )
motherDepression <- rep( NA, nrow( motherIllnesses ) )
pb <- txtProgressBar( min = 0, max = nrow( motherIllnesses ), style = 3 )
for( i in seq.int( nrow( motherIllnesses ) ) )
  {
  setTxtProgressBar( pb, i )
  motherAlzheimers[i] <- as.numeric( 10 %in% motherIllnesses[i,] )  
  motherParkinsons[i] <- as.numeric( 11 %in% motherIllnesses[i,] )  
  motherDepression[i] <- as.numeric( 12 %in% motherIllnesses[i,] )  
  }
cat( "\n" )  

demoTrimmed$f.20107.Alzheimers <- fatherAlzheimers
demoTrimmed$f.20110.Alzheimers <- motherAlzheimers
demoTrimmed$f.20107.Parkinsons <- fatherParkinsons
demoTrimmed$f.20110.Parkinsons <- motherParkinsons
demoTrimmed$f.20107.Depression <- fatherDepression
demoTrimmed$f.20110.Depression <- motherDepression

key <- data.frame( UKBB.code = c( "eid", fieldIds, "20107.Alzheimers", "20110.Alzheimers", "20107.Parkinsons", "20110.Parkinsons", "20107.Depression", "20110.Depression" ),
                   Description = c( fieldNames, "FatherAlzheimers", "MotherAlzheimers", 
                                                "FatherParkinsons", "MotherParkinsons",
                                                "FatherDepression", "MotherDepression" ) )

write.csv( demoTrimmed, paste0( baseDirectory, "ukb50844_imaging_only_Brian.csv" ), row.names = FALSE )
write.csv( key, paste0( baseDirectory, "ukb50844_imaging_only_Brian_key.csv" ), row.names = FALSE )

