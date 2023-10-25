loadIdpData <- function( whichCohort = "ukbiobank",
                         whichData = NULL,
                         completeCases = TRUE,
                         commonSubjects = TRUE,
                         timePoint = 1 ) {

# Notes:
#   * we remove second visit (20252_3_0)

# timePoint is either "1", "2", or "diff"

if( timePoint != 1 && timePoint != 2 && timePoint != "diff" )
  {
  stop( "timePoint is not a valid option." )
  }

if( is.null( whichData ) )
  {
  cat( "whichData options:\n" )
  cat( "  * fsl_fast\n" )
  cat( "  * fsl_first\n" )
  cat( "  * fsl_other\n" )
  cat( "  * freesurfer_aseg\n" )
  cat( "  * freesurfer_dkt\n" )
  cat( "  * freesurfer_dkt_cortical_thickness\n" )
  cat( "  * freesurfer_dkt_cortical_volumes\n" )
  cat( "  * freesurfer_hippocampus_amygdala\n" )
  cat( "  * freesurfer_hippocampus\n" )
  cat( "  * freesurfer_hippocampus_mapped2deepflash\n" )
  cat( "  * ants_dkt_cortical_thickness\n" )
  cat( "  * ants_dkt_cortical_volumes\n" )
  cat( "  * ants_dkt_region_volumes\n" )
  cat( "  * ants_deep_flash\n" )
  cat( "  * ants_deep_flash_hippocampus\n" )
  cat( "  * ants_cerebellum\n" )
  cat( "  * ants_deep_atropos\n" )
  cat( "  * ants_brain_t1\n" )
  cat( "  * ants_brain_t1combined\n" )
  cat( "  * ants_brain_t1nobrainer\n" )
  cat( "  * hippmapper\n" )
  cat( "  * sysu_wmh\n" )
  } 

returnList <- list()

if( whichCohort == "ukbiobank" )
  {
  dataDirectory <- '../Data/ukbiobank/'

  if( timePoint == "diff" )
    {
    idpData1 <- loadIdpData( whichCohort = "ukbiobank", whichData = whichData, completeCases = completeCases, 
                             commonSubjects = commonSubjects, timePoint = 1 )
    idpData2 <- loadIdpData( whichCohort = "ukbiobank", whichData = whichData, completeCases = completeCases, 
                             commonSubjects = commonSubjects, timePoint = 2 )

    for( i in seq.int( length( idpData2 ) ) )
      {
      commonSubjects <- intersect( idpData1[[i]]$Data$Subject, idpData2[[i]]$Data$Subject )

      idpData1[[i]]$Data <- idpData1[[i]]$Data[which( idpData1[[i]]$Data$Subject %in% commonSubjects ),]
      idpData2[[i]]$Data <- idpData2[[i]]$Data[which( idpData2[[i]]$Data$Subject %in% commonSubjects ),]

      returnList[[i]] <- idpData2[[i]]
      returnList[[i]]$Data[2:ncol( returnList[[i]]$Data )] <-
        returnList[[i]]$Data[2:ncol( returnList[[i]]$Data )] - idpData1[[i]]$Data[2:ncol( idpData1[[i]]$Data )]
      }
    names( returnList ) <- names( idpData2 )

    } else {

    if( "fsl_fast" %in% whichData )
      {
      fsl <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_fsl_fast_graymattervolumes.csv' ) )
      Subject <- fsl$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      fsl <- cbind( Subject, fsl[, grepl( timePointString, colnames( fsl ) )] )
      colnames( fsl ) <- gsub( timePointString, "", colnames( fsl ) )

      fsl_fields <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb_fsl_fast_graymattervolumes_fields.csv' ) )
      fsl <- fsl[, c( "Subject", paste0( "f.", fsl_fields$Field.ID ) )]

      returnList$fsl_fast <- list( Data = fsl, Description = c( "Subject", fsl_fields$Description ) )
      }

    if( "fsl_first" %in% whichData )
      {
      fsl <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_fsl_first_subcorticalvolumes.csv' ) )
      Subject <- fsl$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      fsl <- cbind( Subject, fsl[, grepl( timePointString, colnames( fsl ) )] )
      colnames( fsl ) <- gsub( timePointString, "", colnames( fsl ) )

      fsl_fields <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb_fsl_first_subcorticalvolumes_fields.csv' ) )
      fsl <- fsl[, c( "Subject", paste0( "f.", fsl_fields$Field.ID ) )]

      returnList$fsl_first <- list( Data = fsl, Description = c( "Subject", fsl_fields$Description ) )
      }

    if( "fsl_other" %in% whichData )
      {
      fsl <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_fsl_othervolumes.csv' ) )
      Subject <- fsl$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      fsl <- cbind( Subject, fsl[, grepl( timePointString, colnames( fsl ) )] )
      colnames( fsl ) <- gsub( timePointString, "", colnames( fsl ) )

      fsl_fields <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb_fsl_othervolumes_fields.csv' ) )
      fsl <- fsl[, c( "Subject", paste0( "f.", fsl_fields$Field.ID ) )]

      # The following fields are nulled because they're in fsl_first
      for( i in 25011:25024 )
        {
        fsl <- fsl[, -grep( i, colnames( fsl ) )]
        fsl_fields <- fsl_fields[-grep( i, fsl_fields$Field.ID ),]
        }

      # get the wmh volumes
      fsl_dali <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_imaging_only_Dali2021.csv' ) )
      fsl_dali <- data.frame( Subject = fsl_dali$f.eid,
                              f.25781 = fsl_dali$f.25781.2.0 )

      # now merge and add description
      fsl <- merge( fsl_dali, fsl, by = "Subject" )
      fsl_fields <- rbind( c( "25781", "Total volume of white matter hyperintensities (from T1 and T2_FLAIR images)" ),
                           fsl_fields )

      returnList$fsl_other <- list( Data = fsl, Description = c( "Subject", fsl_fields$Description ) )
      }

    if( "freesurfer_dkt" %in% whichData )
      {
      freesurfer <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_freesurfer_dkt.csv' ) )
      Subject <- freesurfer$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      freesurfer <- cbind( Subject, freesurfer[, grepl( timePointString, colnames( freesurfer ) )] )
      colnames( freesurfer ) <- gsub( timePointString, "", colnames( freesurfer ) )

      freesurfer_fields <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb_freesurfer_dkt_fields.csv' ) )
      freesurfer <- freesurfer[, c( "Subject", paste0( "f.", freesurfer_fields$Field.ID ) )]

      returnList$freesurfer_dkt <- list( Data = freesurfer, Description = c( "Subject", freesurfer_fields$Description ) )
      }

    if( "freesurfer_aseg" %in% whichData )
      {
      freesurfer <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_freesurfer_aseg.csv' ) )
      Subject <- freesurfer$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      freesurfer <- cbind( Subject, freesurfer[, grepl( timePointString, colnames( freesurfer ) )] )
      colnames( freesurfer ) <- gsub( timePointString, "", colnames( freesurfer ) )

      # only keep the volumes (i.e., discard the "mean intensity" columns)
      freesurfer_fields <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb_freesurfer_aseg_fields.csv' ) )
      freesurfer_fields <- freesurfer_fields[grepl( "Volume", freesurfer_fields$Description ),]
      freesurfer <- cbind( Subject, freesurfer[, paste0( "f.", freesurfer_fields$Field.ID )] )

      returnList$freesurfer_aseg <- list( Data = freesurfer, Description = c( "Subject", freesurfer_fields$Description ) )
      }

    if( "freesurfer_dkt_cortical_thickness" %in% whichData )
      {
      freesurfer <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_freesurfer_dkt.csv' ) )
      Subject <- freesurfer$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      freesurfer <- cbind( Subject, freesurfer[, grepl( timePointString, colnames( freesurfer ) )] )
      colnames( freesurfer ) <- gsub( timePointString, "", colnames( freesurfer ) )

      # only keep the thickness
      freesurfer_fields <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb_freesurfer_dkt_fields.csv' ) )
      freesurfer_fields <- freesurfer_fields[grepl( "thickness", freesurfer_fields$Description ),]
      freesurfer <- cbind( Subject, freesurfer[, paste0( "f.", freesurfer_fields$Field.ID )] )

      returnList$freesurfer_dkt_cortical_thickness <- list( Data = freesurfer, Description = c( "Subject", freesurfer_fields$Description ) )
      }

    if( "freesurfer_dkt_cortical_volumes" %in% whichData )
      {
      freesurfer <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_freesurfer_dkt.csv' ) )
      Subject <- freesurfer$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      freesurfer <- cbind( Subject, freesurfer[, grepl( timePointString, colnames( freesurfer ) )] )
      colnames( freesurfer ) <- gsub( timePointString, "", colnames( freesurfer ) )

      # only keep the volumes
      freesurfer_fields <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb_freesurfer_dkt_fields.csv' ) )
      freesurfer_fields <- freesurfer_fields[grepl( "Volume", freesurfer_fields$Description ),]
      freesurfer <- cbind( Subject, freesurfer[, paste0( "f.", freesurfer_fields$Field.ID )] )

      returnList$freesurfer_dkt_cortical_volumes <- list( Data = freesurfer, Description = c( "Subject", freesurfer_fields$Description ) )
      }

    if( "freesurfer_hippocampus_amygdala" %in% whichData )
      {
      freesurfer <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_freesurfer_hippocampus_amygdala.csv' ) )
      Subject <- freesurfer$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      freesurfer <- cbind( Subject, freesurfer[, grepl( timePointString, colnames( freesurfer ) )] )
      colnames( freesurfer ) <- gsub( timePointString, "", colnames( freesurfer ) )

      freesurfer_fields <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb_freesurfer_hippocampus_amygdala_fields.csv' ) )
      freesurfer_fields <- freesurfer_fields[grepl( "Volume", freesurfer_fields$Description ),]
      freesurfer <- cbind( Subject, freesurfer[, paste0( "f.", freesurfer_fields$Field.ID )] )

      returnList$freesurfer_hippocampus_amygdala <- list( Data = freesurfer, Description = c( "Subject", freesurfer_fields$Description ) )
      }

    if( "freesurfer_hippocampus" %in% whichData )
      {
      freesurfer <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_freesurfer_hippocampus_amygdala.csv' ) )
      Subject <- freesurfer$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      freesurfer <- cbind( Subject, freesurfer[, grepl( timePointString, colnames( freesurfer ) )] )
      colnames( freesurfer ) <- gsub( timePointString, "", colnames( freesurfer ) )

      freesurfer_fields <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb_freesurfer_hippocampus_amygdala_fields.csv' ) )
      freesurfer_fields <- freesurfer_fields[!is.na( freesurfer_fields$DeepFLASH.mapping ),]
      freesurfer <- cbind( Subject, freesurfer[, paste0( "f.", freesurfer_fields$Field.ID )] )

      returnList$freesurfer_hippocampus <- list( Data = freesurfer, Description = c( "Subject", freesurfer_fields$Description ) )
      }

    if( "freesurfer_hippocampus_mapped2deepflash" %in% whichData )
      {
      # cf Data/ukbiobank/ukb_freesurfer_hippocampus_amygdala_fields.csv
      freesurfer <- read.csv( paste0( dataDirectory, '/UKBBIDPsAndDemographics/ukb50844_freesurfer_hippocampus_amygdala.csv' ) )
      Subject <- freesurfer$f.eid

      if( timePoint == 1 )
        {
        timePointString <- "\\.2\\.0"
        } else if( timePoint == 2 )
        {
        timePointString <- "\\.3\\.0"
        }

      freesurfer <- cbind( Subject, freesurfer[, grepl( timePointString, colnames( freesurfer ) )] )
      colnames( freesurfer ) <- gsub( timePointString, "", colnames( freesurfer ) )

      freesurfer <-
          data.frame( Subject = freesurfer$Subject,
                      left.hippocampus = freesurfer$f.26641,
                      right.hippocampus = freesurfer$f.26663,
                      left.CA1 = freesurfer$f.26622 + freesurfer$f.26626,
                      right.CA1 = freesurfer$f.26644 + freesurfer$f.26648,
                      left.DG_CA2_CA3_CA4 = freesurfer$f.26632 +
                                            freesurfer$f.26637 +
                                            freesurfer$f.26635 +
                                            freesurfer$f.26634,
                      right.DG_CA2_CA3_CA4 = freesurfer$f.26654 +
                                             freesurfer$f.26659 +
                                             freesurfer$f.26657 +
                                             freesurfer$f.26656,
                      left.subiculum = freesurfer$f.26628 +
                                       freesurfer$f.26627 +
                                       freesurfer$f.26625 +
                                       freesurfer$f.26621 +
                                       freesurfer$f.26623,
                      right.subiculum = freesurfer$f.26650 +
                                        freesurfer$f.26649 +
                                        freesurfer$f.26647 +
                                        freesurfer$f.26643 +
                                        freesurfer$f.26645 )

      returnList$freesurfer_hippocampus_mapped2deepflash <- list( Data = freesurfer, Description = colnames( freesurfer ) )
      }

    if( "ants_deep_flash" %in% whichData )
      {
      deepFlash <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_deepflash_ri.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      deepFlash <- deepFlash[which( deepFlash$Visit == timePointString ),]

      deepFlash$Visit <- NULL
      returnList$ants_deep_flash <- list( Data = deepFlash, Description = colnames( deepFlash ) )
      }

    if( "ants_deep_flash_hippocampus" %in% whichData )
      {
      hippocampal_rois <- c( "DG.CA2.CA3.CA4", "CA1", "subiculum", "hippocampus" )
      deepFlash <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_deepflash_ri.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      deepFlash <- deepFlash[which( deepFlash$Visit == timePointString ),]

      deepFlash$Visit <- NULL
      Subject <- deepFlash$Subject
      deepFlash <- cbind( Subject, deepFlash[, c( paste0( 'left.', hippocampal_rois ), paste0( 'right.', hippocampal_rois ) )] )
      returnList$ants_deep_flash_hippocampus <- list( Data = deepFlash, Description = colnames( deepFlash ) )
      }

    if( "ants_deep_atropos" %in% whichData )
      {
      deep <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_deepatropos_tissuevolumes.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      deep <- deep[which( deep$Visit == timePointString ),]

      deep$Visit <- NULL
      returnList$ants_deep_atropos <- list( Data = deep, Description = colnames( deep ) )
      }

    if( "ants_dkt_cortical_thickness" %in% whichData )
      {
      dkt <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_dkt_cortical_thickness.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      dkt <- dkt[which( dkt$Visit == timePointString ),]

      dkt$Visit <- NULL
      colnames( dkt ) <- paste0( colnames( dkt ), ".thickness" )
      colnames( dkt )[1] <- "Subject"
      returnList$ants_dkt_cortical_thickness <- list( Data = dkt, Description = colnames( dkt ) )
      }

    if( "ants_dkt_cortical_volumes" %in% whichData )
      {
      dkt <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_dkt_cortical_volumes.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      dkt <- dkt[which( dkt$Visit == timePointString ),]

      dkt$Visit <- NULL
      colnames( dkt ) <- paste0( colnames( dkt ), ".volume" )
      colnames( dkt )[1] <- "Subject"
      returnList$ants_dkt_cortical_volumes <- list( Data = dkt, Description = colnames( dkt ) )
      }

    if( "ants_dkt_region_volumes" %in% whichData )
      {
      dkt <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_dkt_region_volumes.csv' ) )
      naColumns <- c()
      for( i in seq.int( 3, ncol( dkt ) ) )
        {
        numberNA <- length( which( is.na( dkt[,i] ) ) )
        if( numberNA > 0.5 * nrow( dkt ) )
          {
          naColumns <- append( naColumns, i )
          }
        }
      dkt <- dkt[, -naColumns]

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      dkt <- dkt[which( dkt$Visit == timePointString ),]

      dkt$Visit <- NULL
      returnList$ants_dkt_region_volumes <- list( Data = dkt, Description = colnames( dkt ) )
      }

    if( "ants_cerebellum" %in% whichData )
      {
      cereb <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_cerebellum.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      cereb <- cereb[which( cereb$Visit == timePointString ),]
      cereb$Visit <- NULL
      returnList$ants_cerebellum <- list( Data = cereb, Description = colnames( cereb ) )
      }

    if( "ants_brain_t1" %in% whichData )
      {
      brain <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_brain_extraction_t1_volumes.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      brain <- brain[which( brain$Visit == timePointString ),]
      brain$Visit <- NULL
      returnList$ants_brain_t1 <- list( Data = brain, Description = colnames( brain ) )
      }

    if( "ants_brain_t1combined" %in% whichData )
      {
      brain <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_brain_extraction_t1combined_volumes.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      brain <- brain[which( brain$Visit == timePointString ),]

      brain$Volume <- brain$Inner + brain$Middle
      brain$Inner <- NULL
      brain$Outer <- NULL
      brain$Middle <- NULL
      brain$Visit <- NULL
      returnList$ants_brain_t1combined <- list( Data = brain, Description = colnames( brain ) )
      }

    if( "ants_brain_t1nobrainer" %in% whichData )
      {
      brain <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_brain_extraction_t1nobrainer_volumes.csv' ) )
      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      brain <- brain[which( brain$Visit == timePointString ),]

      brain$Visit <- NULL
      brain$Background <- NULL
      returnList$ants_brain_t1nobrainer <- list( Data = brain, Description = colnames( brain ) )
      }

    if( "hippmapper" %in% whichData )
      {
      hippmapper <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_hippmapper.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      hippmapper <- hippmapper[which( hippmapper$Visit == timePointString ),]
      hippmapper$Visit <- NULL
      returnList$hippmapper <- list( Data = hippmapper, Description = colnames( hippmapper ) )
      }

    if( "sysu_wmh" %in% whichData )
      {
      sysu <- read.csv( paste0( dataDirectory, 'ANTsXIdps/ukbiobank_sysu_wmh.csv' ) )

      if( timePoint == 1 )
        {
        timePointString <- "20252_2_0"
        } else if( timePoint == 2 )
        {
        timePointString <- "20252_3_0"
        }

      sysu <- sysu[which( sysu$Visit == timePointString ),]
      sysu$Visit <- NULL
      sysu$total <- rowSums( sysu[,3:ncol( sysu )] )
      returnList$sysu_wmh <- list( Data = sysu, Description = paste0( "sysu.", colnames( sysu ) ) )
      }
    }

  } else if( whichCohort == "openneuro" ) {

  stop( "No openneuro." )

  # dataDirectory <- '../Data/openneuro/'

  # if( "ants_deep_flash" %in% whichData )
  #   {
  #   deepFlash <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_deepflash_ri.csv' ) )

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }

  #   deepFlash <- deepFlash[which( deepFlash$Visit == timePointString ),]

  #   deepFlash$Visit <- NULL
  #   returnList$ants_deep_flash <- list( Data = deepFlash, Description = colnames( deepFlash ) )
  #   }

  # if( "ants_deep_flash_hippocampus" %in% whichData )
  #   {
  #   hippocampal_rois <- c( "DG_CA2_CA3_CA4", "CA1", "subiculum", "hippocampus" )
  #   deepFlash <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_deepflash_ri.csv' ) )

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }
  #   deepFlash <- deepFlash[which( deepFlash$Visit == timePointString ),]

  #   deepFlash$Visit <- NULL
  #   Subject <- deepFlash$Subject
  #   deepFlash <- cbind( Subject, deepFlash[, c( paste0( 'left.', hippocampal_rois ), paste0( 'right.', hippocampal_rois ) )] )
  #   returnList$ants_deep_flash_hippocampus <- list( Data = deepFlash, Description = colnames( deepFlash ) )
  #   }

  # if( "ants_deep_atropos" %in% whichData )
  #   {
  #   deep <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_deepatropos_tissuevolumes.csv' ) )

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }

  #   deep <- deep[which( deep$Visit == timePointString ),]

  #   deep$Visit <- NULL
  #   returnList$ants_deep_atropos <- list( Data = deep, Description = colnames( deep ) )
  #   }

  # if( "ants_dkt_cortical_thickness" %in% whichData )
  #   {
  #   dkt <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_dkt_cortical_thickness.csv' ) )

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }

  #   dkt <- dkt[which( dkt$Visit == timePointString ),]

  #   dkt$Visit <- NULL
  #   colnames( dkt ) <- paste0( colnames( dkt ), ".thickness" )
  #   colnames( dkt )[1] <- "Subject"
  #   returnList$ants_dkt_cortical_thickness <- list( Data = dkt, Description = colnames( dkt ) )
  #   }

  # if( "ants_dkt_cortical_volumes" %in% whichData )
  #   {
  #   dkt <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_dkt_cortical_volumes.csv' ) )

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }

  #   dkt <- dkt[which( dkt$Visit == timePointString ),]

  #   dkt$Visit <- NULL
  #   colnames( dkt ) <- paste0( colnames( dkt ), ".volume" )
  #   colnames( dkt )[1] <- "Subject"
  #   returnList$ants_dkt_cortical_volumes <- list( Data = dkt, Description = colnames( dkt ) )
  #   }

  # if( "ants_dkt_region_volumes" %in% whichData )
  #   {
  #   dkt <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_dkt_region_volumes.csv' ) )
  #   naColumns <- c()
  #   for( i in seq.int( 3, ncol( dkt ) ) )
  #     {
  #     numberNA <- length( which( is.na( dkt[,i] ) ) )
  #     if( numberNA > 0.5 * nrow( dkt ) )
  #       {
  #       naColumns <- append( naColumns, i )
  #       }
  #     }
  #   dkt <- dkt[, -naColumns]

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }

  #   dkt <- dkt[which( dkt$Visit == timePointString ),]

  #   dkt$Visit <- NULL
  #   returnList$ants_dkt_region_volumes <- list( Data = dkt, Description = colnames( dkt ) )
  #   }

  # if( "ants_brain_t1" %in% whichData )
  #   {
  #   brain <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_brain_extraction_t1_volumes.csv' ) )

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }

  #   brain <- brain[which( brain$Visit == timePointString ),]
  #   brain$Visit <- NULL
  #   returnList$ants_brain_t1 <- list( Data = brain, Description = colnames( brain ) )
  #   }

  # if( "ants_brain_t1combined" %in% whichData )
  #   {
  #   brain <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_brain_extraction_t1combined_volumes.csv' ) )

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }

  #   brain <- brain[which( brain$Visit == timePointString ),]

  #   brain$Volume <- brain$Inner + brain$Middle
  #   brain$Inner <- NULL
  #   brain$Outer <- NULL
  #   brain$Middle <- NULL
  #   brain$Visit <- NULL
  #   returnList$ants_brain_t1combined <- list( Data = brain, Description = colnames( brain ) )
  #   }

  # if( "ants_brain_t1nobrainer" %in% whichData )
  #   {
  #   brain <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_brain_extraction_t1nobrainer_volumes.csv' ) )

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }

  #   brain <- brain[which( brain$Visit == timePointString ),]

  #   brain$Visit <- NULL
  #   brain$Background <- NULL
  #   returnList$ants_brain_t1nobrainer <- list( Data = brain, Description = colnames( brain ) )
  #   }

  # if( "sysu_wmh" %in% whichData )
  #   {
  #   sysu <- read.csv( paste0( dataDirectory, 'ANTsXIdps/openneuro_sysu_wmh.csv' ) )

  #   if( timePoint == 1 )
  #     {
  #     timePointString <- "ses-1"
  #     }

  #   sysu <- sysu[which( sysu$Visit == timePointString ),]
  #   sysu$Visit <- NULL
  #   sysu$total <- rowSums( sysu[,3:ncol( sysu )] )
  #   returnList$sysu_wmh <- list( Data = sysu, Description = paste0( "sysu.", colnames( sysu ) ) )
  #   }
  }

  if( completeCases )
    {
    for( i in seq.int( length( returnList ) ) )
      {
      returnList[[i]]$Data <- returnList[[i]]$Data[complete.cases( returnList[[i]]$Data ),]
      }
    }

  if( length( returnList ) > 1 )
    {
    commonSubjects <- returnList[[1]]$Data$Subject
    for( i in 2:length( returnList ) )
      {
      commonSubjects <- intersect( commonSubjects, returnList[[i]]$Data$Subject )
      }

    for( i in seq.int( length( returnList ) ) )
      {
      returnList[[i]]$Data <- returnList[[i]]$Data[which( returnList[[i]]$Data$Subject %in% commonSubjects ),]
      }
    }

  return( returnList )
}
