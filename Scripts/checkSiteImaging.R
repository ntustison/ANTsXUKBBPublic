
demo <- read.csv( "imageStatus.csv" )
demo$X <- NULL
demo$site <- as.factor( substr( demo$subject, 1, 3 ) )

statsImageAcq <- data.frame( Site = character(),
                             TotalTimePoints = numeric(),
                             T1w = numeric(),
                             DWI = numeric(),
                             FMRI = numeric(),
                             Complete = numeric() )

for( i in seq.int( length( levels( demo$site ) ) ) )
  {
  whichSite <- levels( demo$site )[i]
  nSite <- nrow( demo[which( demo$site == whichSite ), ] )

  nT1 <- nrow( demo[which( demo$site == whichSite & demo$thickness == 1 ), ] )
  nDwi <- nrow( demo[which( demo$site == whichSite & demo$fa == 1 ), ] )
  nFmri <- nrow( demo[which( demo$site == whichSite & demo$defaultMode == 1 ), ] )
  nComplete <- nrow( demo[which( demo$site == whichSite & demo$thickness == 1 & demo$fa == 1 & demo$defaultMode == 1 ), ] )

  siteStatsImageAcq <- data.frame( Site = whichSite,
                                      TotalTimePoints = nSite,
                                      T1w = nT1,
                                      DWI = nDwi,
                                      FMRI = nFmri,
                                      Complete = nComplete )
  statsImageAcq <- rbind( statsImageAcq, siteStatsImageAcq )
  }
