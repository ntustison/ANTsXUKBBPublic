
baseDirectory <- '/Users/ntustison/Data/Public/UKBiobank/'
demo <- read.csv( paste0( baseDirectory, "ukb47304_imaging_only.csv" ) )
descriptionKey <- read.csv( paste0( baseDirectory, "ukbiobank/ukb47304.csv" ) )

measure.ukbbCode <-
           c( "1558.2.0", "22037.0.0", "22038.0.0", "22039.0.0", "1160.2.0", "20161.2.0" )
measure.variable <-
           c( "Alcohol intake frequency", 
              "MET minutes per week for walking",
              "MET minutes per week for moderate activity",
              "MET minutes per week for vigorous activity",
              "Sleep duration (hours)",
              "Cigarettes smoked (pack-years)" )

# Table S7
moodSentiment.ukbbCode <- 
           c( "2040.2.0", "4526.2.0", "4537.2.0", "4548.2.0", "4559.2.0", 
              "4570.2.0", "4581.2.0", "4598.2.0", "4609.2.0", "4620.2.0", 
              "4631.2.0", "4642.2.0", "4653.2.0", "2050.2.0", "2060.2.0", 
              "2070.2.0", "2080.2.0", "2090.2.0", "2100.1.0", "5375.2.0", 
              "5386.2.0", "5663.2.0", "5674.2.0", "6145.2.0", "6156.2.0" )
moodSentiment.variable <- 
           c( "Risk taking",
              "Happiness",
              "X   Work/job satisfaction",
              "Health satisfaction",
              "X   Family relationship satisfaction",
              "X   Friendships satisfaction", 
              "X   Financial situation satisfaction", 
              "Ever depressed for a whole week",
              "Longest period of depression",
              "Number of depression episodes",
              "Ever unenthusiastic/disinterested for a whole week",
              "Ever manic/hyper for 2 days",
              "Ever highly irritable/argumentative for 2 days",
              "Frequency of depressed mood in last 2 weeks",
              "Frequency of unenthusiasm / disinterest in last 2 weeks", 
              "Frequency of tenseness / restlessness in last 2 weeks", 
              "Frequency of tiredness / lethargy in last 2 weeks",
              "Seen doctor (GP) for nerves, anxiety, tension or depression", 
              "Seen a psychiatrist for nerves, anxiety, tension or depression", 
              "Longest period of unenthusiasm / disinterest",
              "Number of unenthusiastic/disinterested episodes",
              "Length of longest manic/irritable episode",
              "Severity of manic/irritable episode",
              "Illness, injury, bereavement, stress in last 2 years", 
              "Manic/hyper symptoms" )
moodSentiment.ukbbCode[2] <- "20458.0.0"  # General happiness
moodSentiment.ukbbCode[4] <- "20459.0.0"  # General happiness with own health
moodSentiment.remove <- c( 3, 5, 6, 7 )
moodSentiment.ukbbCode <- moodSentiment.ukbbCode[-moodSentiment.remove]
moodSentiment.variable <- moodSentiment.variable[-moodSentiment.remove]

ageSex.ukbbCode <- 
           c( "31.0.0", "34.0.0", "52.0.0", "21022.0.0", "21003.2.0" )
ageSex.variable <- 
           c( "Sex", 
              "Year of birth",
              "Month of birth",
              "Age at recruitment",
              "Age when attended assessment centre" )

education.ukbbCode <- 
           c( "6138.2.0", "845.2.0" )
education.variable <- 
           c( "Qualifications",
              "Age completed full time education" )

earlyLife.ukbbCode <- 
           c( "1647.2.0", "1677.2.0", "1687.2.0", "1697.2.0", "1707.2.0", "1767.2.0", 
              "1777.2.0", "1787.2.0" )
earlyLife.variable <-
           c( "Country of birth (UK/elsewhere)", 
              "Breastfed as a baby",
              "Comparative body size at age 10",
              "Comparative height size at age 10",
              "Handedness (chirality/laterality)", 
              "Adopted as a child",
              "Part of a multiple birth", 
              "Maternal smoking around birth" )

lifestyle.ukbbCode <- 
           c( "670.2.0", "680.2.0", "6139.2.0", "699.2.0", "709.2.0", "6141.2.0", 
              "728.2.0", "738.2.0", "796.2.0", "757.2.0", "767.2.0", "777.2.0", 
              "6143.2.0", "6142.2.0", "806.2.0", "816.2.0", "826.2.0", "3426.2.0", 
              "1031.2.0", "6160.2.0", "2110.2.0", "1239.2.0", "1249.2.0", "1259.2.0", 
              "1269.2.0", "1279.2.0", "2644.2.0", "2867.2.0", "2877.2.0", "2887.2.0", 
              "2897.2.0", "2907.2.0", "2926.2.0", "2936.2.0", "3436.2.0", "3446.2.0", 
              "3456.2.0", "3466.2.0", "3476.2.0", "3486.2.0", "3496.2.0", "3506.2.0", 
              "5959.2.0", "6157.2.0", "6158.2.0" )
lifestyle.variable <- 
           c( "Type of accommodation lived in",
              "Own or rent accommodation lived in", 
              "Gas or solid-fuel cooking/heating", 
              "Length of time at current address", 
              "Number in household", 
              "How are people in household related to participant", 
              "Number of vehicles in household", 
              "Income before tax", 
              "Distance between home and job workplace", 
              "Time employed in main current job", 
              "Length of working week for main job", 
              "Freq. of travelling from home to job workplace",
              "Transport type for commuting to job workplace", 
              "Current employment status", 
              "Job involves mainly walking or standing", 
              "Job involves heavy manual or physical work", 
              "Job involves shift work", 
              "Job involves night shift work", 
              "Freq. of friend/ family visits", 
              "Leisure/social activities", 
              "Able to confide", 
              "Current tobacco smoking", 
              "Past tobacco smoking", 
              "Smoking/smokers in household", 
              "Exposure to tobacco smoke at home", 
              "Exposure to tobacco smoke outside home", 
              "Light smokers, at least 100 smokes in lifetime", 
              "Age started smoking in former smokers", 
              "Type of tobacco previously smoked", 
              "Number of cigarettes previously smoked daily", 
              "Age stopped smoking", 
              "Ever stopped smoking for 6+ months", 
              "Number of unsuccessful stop-smoking attempts",
              "X   Likelihood of resuming smoking", 
              "Age started smoking in current smokers", 
              "Type of tobacco currently smoked", 
              "Number of cigarettes currently smoked daily (current cigarette smokers)", 
              "Time from waking to first cigarette", 
              "X   Difficulty not smoking for 1 day", 
              "X   Ever tried to stop smoking", 
              "X   Wants to stop smoking", 
              "Smoking compared to 10 years previous", 
              "Previously smoked cigarettes on most/all days", 
              "Why stopped smoking", 
              "Why reduced smoking" )
lifestyle.remove <- c( 34, 39, 40, 41 )
lifestyle.ukbbCode <- lifestyle.ukbbCode[-lifestyle.remove]
lifestyle.variable <- lifestyle.variable[-lifestyle.remove]

sMRI.ukbbCode <- c( "25000.2.0", 
                    paste0( seq.int( 25002, 25010, by = 2 ), ".2.0" ), 
                    paste0( 25011:25025, ".2.0" ), 
                    paste0( 25781:25920, ".2.0" ) )
sMRI.variable <- rep( "Volume via brain imaging", length( sMRI.ukbbCode ) ) 

for( i in seq.int( length( sMRI.ukbbCode ) ) )
  {
  codePrefix <- paste0( "^", sub( ".2.0", "", sMRI.ukbbCode[i] ), "-" )
  codeIndex <- grep( codePrefix, descriptionKey$UDI )[1]
  sMRI.variable[i] <- descriptionKey$Description[codeIndex]
  }
 

ukbbCode <- c( measure.ukbbCode, moodSentiment.ukbbCode, ageSex.ukbbCode, education.ukbbCode, earlyLife.ukbbCode, lifestyle.ukbbCode, sMRI.ukbbCode )
variable <- c( measure.variable, moodSentiment.variable, ageSex.variable, education.variable, earlyLife.variable, lifestyle.variable, sMRI.variable )

type <- c( rep( "Target or proxy measure", length( measure.ukbbCode ) ),
           rep( "Mood and sentiment", length( moodSentiment.ukbbCode ) ),
           rep( "Age and sex", length( ageSex.ukbbCode ) ),
           rep( "Education", length( education.ukbbCode ) ),
           rep( "Early life", length( earlyLife.ukbbCode ) ),
           rep( "Lifestyle", length( lifestyle.ukbbCode ) ),
           rep( "structural MRI", length( sMRI.ukbbCode ) ) )

key <- data.frame( UKBB.code = ukbbCode,
                   Category = type,
                   Description = variable )



fieldIds <- ukbbCode
xfieldIds <- c( "f.eid", paste0( "f.", fieldIds ) )

isMissing <- FALSE
for( i in seq.int( length( xfieldIds ) ) )
  {
  if( ! xfieldIds[i] %in% colnames( demo ) )
    {
    cat( xfieldIds[i], " (", variable[i-1], ")", " not in demo.\n" ) 
    isMissing <- TRUE
    }  
  }
# if( isMissing )
#   {
#   stop( "Missing" )
#   }

demoTrimmed <- demo[, xfieldIds]
write.csv( demoTrimmed, paste0( baseDirectory, "ukb47304_imaging_only_Dali2021.csv" ), row.names = FALSE )
write.csv( key, paste0( baseDirectory, "ukb47304_imaging_only_Dali2021_key.csv" ), row.names = FALSE )

